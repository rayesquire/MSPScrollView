//
//  MSPViewController.m
//  MSPScrollView
//
//  Created by rayesquire on 04/18/2018.
//  Copyright (c) 2018 rayesquire. All rights reserved.
//

#import "MSPViewController.h"
#import "MSPScrollView.h"

@interface MSPViewController () <MSPScrollViewDelegate>

@end

@implementation MSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *image1 = [NSString stringWithFormat:@"http://pic.nipic.com/2007-11-09/2007119122519868_2.jpg"];
    NSString *image2 = [NSString stringWithFormat:@"http://pic25.nipic.com/20121209/9252150_194258033000_2.jpg"];
    NSString *image3 = [NSString stringWithFormat:@"http://zx.kaitao.cn/UserFiles/Image/beijingtupian6.jpg"];
    NSString *image4 = [NSString stringWithFormat:@"http://pic8.nipic.com/20100723/5296193_105040043769_2.jpg"];
    NSArray *imageurl = @[image1,image2,image3,image4];
    MSPScrollView *viewview = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) URLStringsGroup:imageurl];
    viewview.pageControlStyle = MSPScrollViewPageControlStyleCustom;
//    viewview.customPageControl.dotImage = [UIImage imageNamed:@"yyyyyy.jpg"];
//    viewview.customPageControl.dotImageHL = [UIImage imageNamed:@"tttttt.jpg"];
    viewview.delegate = self;
    [self.view addSubview:viewview];
    
}

- (void)clickImage:(NSInteger)index
{
    NSLog(@"第%d张图片",(int)index + 1);
}

@end
