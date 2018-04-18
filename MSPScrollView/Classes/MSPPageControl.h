//
//  MSPPageControl.h
//  lvtu
//
//  Created by 尾巴超大号 on 15/11/14.
//  Copyright © 2015年 尾巴超大号. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MSPPageControlDelegate <NSObject>



@end

@interface MSPPageControl : UIControl


/**
 *   current page
 */
@property (nonatomic,assign) NSInteger currentPage;


/**
 *   number of pages
 */
@property (nonatomic,assign) NSInteger numberOfPages;


/**
 *   dot color
 */
@property (nonatomic,strong) UIImage *dotImage;


/**
 *   dot colorHL
 */
@property (nonatomic,strong) UIImage *dotImageHL;


/**
 *   dot space
 */
@property (nonatomic,assign) NSInteger dotSpace;


/**
 *   dot size
 */
@property (nonatomic,assign) CGSize dotSize;


/**
 *   dotView array
 */
@property (nonatomic,copy) NSMutableArray *dotViews;


/**
 *   delegate
 */
@property (nonatomic,weak) id<MSPPageControlDelegate> delegate;


@end
