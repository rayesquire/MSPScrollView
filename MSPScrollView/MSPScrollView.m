//
//  MSPScrollView.m
//  SDCycleScrollView
//
//  Created by 尾巴超大号 on 15/11/13.
//  Copyright © 2015年 GSD. All rights reserved.
//

#import "MSPScrollView.h"
#import "MSPPageControl.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import <SDWebImage/SDWebImageManager.h>

@interface MSPScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) NSMutableArray *imagesGroup;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) UIControl *pageControl;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, assign) BOOL isDraging;
@property (nonatomic, assign) BOOL isFromNet;

@end

@implementation MSPScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];    // 初始化各属性
        [self initMainView];      // 添加scrollview
        [self initContainer];     // 添加容器
        [self setupTimer];
    }
    return self;
}

+ (instancetype)scrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup {
    MSPScrollView *view = [[self alloc] initWithFrame:frame];
    view.imagesGroup = [NSMutableArray arrayWithArray:imagesGroup];
    return view;
}

+ (instancetype)scrollViewWithFrame:(CGRect)frame URLStringsGroup:(NSArray *)URLGroup {
    MSPScrollView *view = [[self alloc] initWithFrame:frame];
    view.netImageURLGroup = [NSMutableArray arrayWithArray:URLGroup];
    return view;
}

- (void)initialization {
    _autoScrollTimeInterval = 4.0;
    _infinite = YES;
    _automaticScroll = YES;
    _showPageControl = YES;
    _pageControlStyle = MSPScrollViewPageControlStyleClassic;
    _pageControlAliment = MSPScrollViewPageControlAlimentCenter; ////
    _pageControlDotSize = CGSizeMake(10, 10);
    _dotColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    _dotColorHL = [UIColor greenColor];
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont = [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    
    _currentIndex = 0;
    _isDraging = NO;
    _isFromNet = YES;
    _imagesGroup = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)initMainView {
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _mainView.backgroundColor = [UIColor clearColor];
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.delegate = self;
    _mainView.scrollEnabled = YES;
    [_mainView setContentSize:CGSizeMake(self.frame.size.width * 3, 0)];
    [_mainView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    [self addSubview:_mainView];
}

- (void)initContainer {
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setContainer:_leftImageView];

    _centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self setContainer:_centerImageView];
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self setContainer:_rightImageView];
}

- (void)setContainer:(UIImageView *)imageView {
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchImage)];
    [imageView addGestureRecognizer:tap];
    [self.mainView addSubview:imageView];
}

#pragma mark - touch
- (void)touchImage {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImage:)]) {
        [self.delegate clickImage:_currentIndex];
    }
}

#pragma mark - datasource
- (void)setImagesGroup:(NSMutableArray *)imagesGroup {
    _imagesGroup = imagesGroup;
    
    _totalCount = imagesGroup.count;
    
    [self setLocalImagesGroup:imagesGroup];
    [self setupPageControl];
}

- (void)setLocalImagesGroup:(NSArray *)localImagesGroup {
    _isFromNet = NO;
    _localImagesGroup = localImagesGroup;

    _imagesGroup = [NSMutableArray arrayWithArray:localImagesGroup];
    
    _leftImageView.image = _imagesGroup[_totalCount - 1];
    _centerImageView.image = _imagesGroup[0];
    _rightImageView.image = _imagesGroup[1];
}

- (void)setNetImageURLGroup:(NSArray *)netImageURLGroup {
    _isFromNet = YES;
    _netImageURLGroup = netImageURLGroup;
    _totalCount = netImageURLGroup.count;
    _imagesGroup = [[NSMutableArray alloc] initWithCapacity:_totalCount];
    self.placeholderImage = [UIImage imageNamed:@"default.jpg"];   // 初始化placeholderimage
    [self setupPageControl];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    for (int i = 0; i < _totalCount; i++) {
        [_imagesGroup insertObject:placeholderImage atIndex:i];   // 将placeholderimage放入图片数组
    }
    [self setImageReplaceHolder];     // 寻找缓存或下载图片并代替placeholderimage
}

- (void)setImageReplaceHolder {
    for (int i = 0; i < _netImageURLGroup.count; i++) {
        NSString *urlString = _netImageURLGroup[i];
        NSURL *url = [NSURL URLWithString:urlString];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
        if (image) {
            [_imagesGroup replaceObjectAtIndex:i withObject:image];
        }
        else {
            SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
            [downloader downloadImageWithURL:url options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                if (image) {
                    if (i < _netImageURLGroup.count && [_netImageURLGroup[i] isEqualToString:urlString]) {
                        [_imagesGroup replaceObjectAtIndex:i withObject:image];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self reloadImage];
                        });
                    }
                }
            }];
        }
    }
}

#pragma mark - status
- (void)setAutomaticScroll:(BOOL)automaticScroll {
    _automaticScroll = automaticScroll;
    if (!_automaticScroll || _timer) {
        [_timer invalidate];
        _timer = nil;
    }
    else {
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self setupTimer];
}

#pragma mark - style
- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize {
    _pageControlDotSize = pageControlDotSize;
    
    [self setupPageControl];
}

- (void)setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    
    [self setupPageControl];
}

- (void)setDotColorHL:(UIColor *)dotColorHL {
    _dotColorHL = dotColorHL;
    
    [self setupPageControl];
}

- (void)setPageControlStyle:(MSPScrollViewPageControlStyle)pageControlStyle {
    _pageControlStyle = pageControlStyle;
    
    [self setupPageControl];
}

- (void)setPageControlAliment:(MSPScrollViewPageControlAliment)pageControlAliment {
    _pageControlAliment = pageControlAliment;
    
    [self setupPageControl];
}

- (void)setupPageControl {
    if (_pageControl) [_pageControl removeFromSuperview];
    
    switch (_pageControlStyle) {
        case MSPScrollViewPageControlStyleCustom:
        {
            _customPageControl = [[MSPPageControl alloc] init];
            _customPageControl.numberOfPages = _totalCount;
            if (_pageControlAliment == MSPScrollViewPageControlAlimentCenter) {
                [_customPageControl setFrame:CGRectMake(self.frame.size.width / 2, self.frame.size.height * 9 / 10, _customPageControl.frame.size.width, _customPageControl.frame.size.height)];
            }
            else if (_pageControlAliment == MSPScrollViewPageControlAlimentRight){
                [_customPageControl setFrame:CGRectMake(self.frame.size.width - _customPageControl.frame.size.width - 20, self.frame.size.height * 9 / 10, _customPageControl.frame.size.width, _customPageControl.frame.size.height)];
            }
            [self addSubview:_customPageControl];
            _pageControl = _customPageControl;
        }
            break;
        case MSPScrollViewPageControlStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = _totalCount;
            pageControl.currentPageIndicatorTintColor = _dotColorHL;
            pageControl.pageIndicatorTintColor = _dotColor;
            pageControl.currentPage = _currentIndex;
            CGSize size = CGSizeMake(_totalCount * _pageControlDotSize.width * 1.2, _pageControlDotSize.height);
            if (_pageControlAliment == MSPScrollViewPageControlAlimentCenter) {
                [pageControl setFrame:CGRectMake(self.frame.size.width / 2 - size.width / 2, self.frame.size.height * 9 / 10, size.width, size.height)];
            }
            else if (_pageControlAliment == MSPScrollViewPageControlAlimentRight){
                [pageControl setFrame:CGRectMake(self.frame.size.width - size.width - 20, self.frame.size.height * 9 / 10, size.width, size.height)];
            }
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
        default:
            break;
    }
}

- (void)setupTimer {
    if (_automaticScroll) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(updateView) userInfo:nil repeats:_infinite];
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDraging = YES;
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isDraging = NO;
    [self reloadImage];
    [_mainView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    if ([_pageControl isKindOfClass:[MSPPageControl class]]) {
        MSPPageControl *pageControl = (MSPPageControl *)_pageControl;
        pageControl.currentPage = _currentIndex;
    }
    else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = _currentIndex;
    }
    if (_automaticScroll) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(updateView) userInfo:nil repeats:_infinite];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (!_isDraging) {
        _currentIndex = (_currentIndex + 1) % _totalCount;
        _leftImageView.image = _imagesGroup[_currentIndex];
        _centerImageView.image = _imagesGroup[_currentIndex];
        _rightImageView.image = _imagesGroup[(_currentIndex + 1) % _totalCount];
        
        if ([_pageControl isKindOfClass:[MSPPageControl class]]) {
            MSPPageControl *pageControl = (MSPPageControl *)_pageControl;
            [pageControl setCurrentPage:_currentIndex];
        }
        else {
            UIPageControl *pageControl = (UIPageControl *)_pageControl;
            pageControl.currentPage = _currentIndex;
        }
        [_mainView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
}

- (void)reloadImage {
    NSInteger leftIndex,rightIndex;
    CGPoint offset = [_mainView contentOffset];
    if (offset.x > self.frame.size.width) {
        _currentIndex = (_currentIndex + 1) % _totalCount;
    }
    else if (offset.x < self.frame.size.width) {
        _currentIndex = (_currentIndex + _totalCount - 1) % _totalCount;
    }
    _centerImageView.image = _imagesGroup[_currentIndex];
    leftIndex = (_currentIndex + _totalCount - 1) % _totalCount;
    rightIndex = (_currentIndex + 1) % _totalCount;
    _leftImageView.image = _imagesGroup[leftIndex];
    _rightImageView.image = _imagesGroup[rightIndex];
}

- (void)updateView {
    CGPoint offset = [_mainView contentOffset];
    offset.x += self.frame.size.width;
    [_mainView setContentOffset:offset animated:YES];
}

- (void)setInfinite:(BOOL)infinite {
    _infinite = infinite;
    
    [self setupTimer];
}

@end
