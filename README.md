# MSPScrollView

MSPScrollView
=============
MSPScrollView is a framework on the basis of SDCycleScrollView.But it is smaller than SDCycleScrollView.It cancel the function of layout title and use UIScrollView instead of UICollectionView.
It use to implement picture carousel;


Features
========
It support local image array or international image array.
Using SDWebImage to manage cache.
It support custom dot view.


Usage
=====
load image from local With custom dot view
---------------------
NSArray *images = @[[UIImage imageNamed:@"image1.jpg"],
[UIImage imageNamed:@"image2.jpg"],
[UIImage imageNamed:@"image3.jpg"],
[UIImage imageNamed:@"image4.jpg"]
];
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) imagesGroup:images];
view.pageControlStyle = MSPScrollViewPageControlStyleCustom;
view.customPageControl.dotImage = [UIImage imageNamed:@"dotImage.jpg"];
view.customPageControl.dotImageHL = [UIImage imageNamed:@"dotImageHL.jpg"];
view.delegate = self;
[self.view addSubView:view];

load image from net 
-------------------
NSString *image1 = [NSString stringWithFormat:@"http://pic.nipic.com/2007-11-09/2007119122519868_2.jpg"];
NSString *image2 = [NSString stringWithFormat:@"http://pic25.nipic.com/20121209/9252150_194258033000_2.jpg"];
NSString *image3 = [NSString stringWithFormat:@"http://zx.kaitao.cn/UserFiles/Image/beijingtupian6.jpg"];
NSString *image4 = [NSString stringWithFormat:@"http://pic8.nipic.com/20100723/5296193_105040043769_2.jpg"];
NSArray *imageurl = @[image1,image2,image3,image4];
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) URLStringsGroup:imageurl];
view.pageControlStyle = MSPScrollViewPageControlStyleClassic;
[self.view addSubview:view];

