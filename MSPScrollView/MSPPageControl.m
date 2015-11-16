//
//  MSPPageControl.m
//  lvtu
//
//  Created by 尾巴超大号 on 15/11/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import "MSPPageControl.h"

@interface MSPPageControl ()
@property (nonatomic,assign) NSInteger lastIndex;
@end

@implementation MSPPageControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.dotSpace = 8;
    self.numberOfPages = 0;
    self.dotSize = CGSizeMake(8, 8);
    _lastIndex = 0;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    
    [self resetCurrentDotView:currentPage];
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    
    [self resetDotViews];

}

- (void)setDotSpace:(NSInteger)dotSpace
{
    _dotSpace = dotSpace;
    
    [self resetDotViews];
}

- (void)setDotSize:(CGSize)dotSize
{
    _dotSize = dotSize;
    
    [self resetDotViews];
}

- (void)setDotImage:(UIImage *)dotImage
{
    _dotImage = dotImage;
    
    [self resetDotViews];
}

- (void)setDotImageHL:(UIImage *)dotImageHL
{
    _dotImageHL = dotImageHL;
    
    if (self.dotViews.count == self.numberOfPages) {
        UIImageView *igv = [[UIImageView alloc]initWithImage:dotImageHL];
        [self.dotViews replaceObjectAtIndex:_currentPage withObject:igv];
        [self resetCurrentDotView:_currentPage];
    }
}

- (void)resetDotViews
{
    for (UIImageView *dotView in self.dotViews) {
        [dotView removeFromSuperview];
    }
    [self.dotViews removeAllObjects];
    [self generateDotView];
}

- (void)generateDotView
{
    for (int i = 0; i < self.numberOfPages; i++) {
        UIImageView *dotView;
        if (i < self.dotViews.count) {
            dotView = [self.dotViews objectAtIndex:i];
        }else {
            dotView = [[UIImageView alloc]initWithImage:self.dotImage];
            dotView.frame = CGRectMake(0, 0, self.dotSize.width, self.dotSize.height);
            [self.dotViews addObject:dotView];
        }
        [self updateDotFrame:dotView atIndex:i];
    }
}

- (void)updateDotFrame:(UIImageView *)dotView atIndex:(NSInteger)index
{
    CGFloat x = (self.dotSize.width + self.dotSpace) * index + ((CGRectGetWidth(self.frame) - [self sizeForNumberOfPages:self.numberOfPages].width) / 2);
    CGFloat y = (CGRectGetHeight(self.frame) - self.dotSize.height) / 2;
    
    dotView.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
    
    [self addSubview:dotView];
}

- (void)resetCurrentDotView:(NSInteger)currentPage
{
    UIImageView *view = [self.dotViews objectAtIndex:_lastIndex];
    [view removeFromSuperview];
    [self updateDotFrame:view atIndex:currentPage];
}

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.dotSize.width + self.dotSpace) * pageCount - self.dotSpace, self.dotSize.height);
}

- (NSMutableArray *)dotViews
{
    if (!_dotViews) {
        _dotViews = [[NSMutableArray alloc]init];
    }
    return _dotViews;
}

@end
