//
//  MSPScrollView.h
//  SDCycleScrollView
//
//  Created by 尾巴超大号 on 15/11/13.
//  Copyright © 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSPPageControl.h"
typedef NS_ENUM(NSInteger,MSPScrollViewPageControlAliment){
    MSPScrollViewPageControlAlimentRight,
    MSPScrollViewPageControlAlimentCenter      // default
};

typedef NS_ENUM(NSInteger,MSPScrollViewPageControlStyle){
    MSPScrollViewPageControlStyleClassic,      //default
    MSPScrollViewPageControlStyleCustom,
    MSPScrollViewPageControlStyleNone
};

@protocol MSPScrollViewDelegate <UIScrollViewDelegate>

@optional
- (void)clickImage:(NSInteger)index;
@end


@interface MSPScrollView : UIView

//  ************************* delegate
/**
 *   delegate
 */
@property (nonatomic,weak) id<MSPScrollViewDelegate> delegate;


//  ************************* data

/**
 *   local image array
 */
@property (nonatomic,strong) NSArray *localImagesGroup;


/**
 *   international image url array
 */
@property (nonatomic,strong) NSArray *netImageURLGroup;


//  ************************* status

/**
 *   auto scroll timeinterval
 */
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;


/**
 *   repeat
 */
@property (nonatomic,assign) BOOL infinite;


/**
 *   auto scroll
 */
@property (nonatomic,assign) BOOL automaticScroll;


// ************************** style

/**
 *   show pagecontrol
 */
@property (nonatomic,assign) BOOL showPageControl;


/**
 *   pageControl style
 */
@property (nonatomic,assign) MSPScrollViewPageControlStyle pageControlStyle;


/**
 *   placeholder image
 */
@property (nonatomic,strong) UIImage *placeholderImage;


/**
 *   pageControl frame
 */
@property (nonatomic,assign) MSPScrollViewPageControlAliment pageControlAliment;


/**
 *   pageControl dot size
 */
@property (nonatomic,assign) CGSize pageControlDotSize;


/**
 *   pageControl dot color
 */
@property (nonatomic,strong) UIColor *dotColor;


/**
 *   pageControl dot colorHL
 */
@property (nonatomic,strong) UIColor *dotColorHL;


/**
 *   customPageControl need to be set when MSPScrollViewPageControlStyle == MSPScrollViewPageControlStyleCustom
 */
@property (nonatomic,strong) MSPPageControl *customPageControl;


/**
 *   title color
 */
@property (nonatomic,strong) UIColor *titleLabelTextColor;


/**
 *   title font
 */
@property (nonatomic,strong) UIFont *titleLabelTextFont;


/**
 *   title backgroundcolor
 */
@property (nonatomic,strong) UIColor *titleLabelBackgroundColor;


/**
 *   title height
 */
@property (nonatomic,assign) CGFloat titleLabelHeight;


/**
 *   init with local image array
 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;


/**
 *   init with international image url array
 */
+ (instancetype)scrollViewWithFrame:(CGRect)frame URLStringsGroup:(NSArray *)URLGroup;

@end
