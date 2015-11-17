# MSPScrollView

MSPScrollView is a framework on the basis of SDCycleScrollView.But it is smaller than SDCycleScrollView.It cancel the function of layout title and use UIScrollView instead of UICollectionView.
It use to implement picture carousel;


Features
========
It support local image array or international image array.
Using SDWebImage to manage cache.
It support custom dot view.


Usage
=====
load image from local with classic dot
--------------------------------------
```objective-c
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) imagesGroup:imageArray];
view.pageControlStyle = MSPScrollViewPageControlStyleClassic;
```

load image from local With custom dot view
-----------------------------------------
```objective-c
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) imagesGroup:imageArray];
view.pageControlStyle = MSPScrollViewPageControlStyleCustom;
view.customPageControl.dotImage = [UIImage imageNamed:@"dotImage.jpg"];
view.customPageControl.dotImageHL = [UIImage imageNamed:@"dotImageHL.jpg"];
```

load image from net 
-------------------
```objective-c
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) URLStringsGroup:imagURLlArray];
view.pageControlStyle = MSPScrollViewPageControlStyleClassic;
```

