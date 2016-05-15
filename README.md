# MSPScrollView

MSPScrollView is a framework on the basis of SDCycleScrollView.But it is more simplify than SDCycleScrollView.It cancel the function of layout title and use UIScrollView instead of UICollectionView.
It use to implement picture carousel;


Features
========
It support local image array or international image array.

Using SDWebImage to manage cache.

It support custom dot view.


Usage
=====
<<<<<<< HEAD
load image from local with classic dot
--------------------------------------
```objective-c
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) imagesGroup:imageArray];
view.pageControlStyle = MSPScrollViewPageControlStyleClassic;
=======
load image from local with classic dot view
--------------------------------------
```objective-c
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:frame imagesGroup:imageArray];
>>>>>>> e248db65ad87e4dfb92ffb1b2cbc06068e9a3563
```

load image from local With custom dot view
-----------------------------------------
```objective-c
<<<<<<< HEAD
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) imagesGroup:imageArray];
=======
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:frame imagesGroup:imageArray];
>>>>>>> e248db65ad87e4dfb92ffb1b2cbc06068e9a3563
view.pageControlStyle = MSPScrollViewPageControlStyleCustom;
view.customPageControl.dotImage = [UIImage imageNamed:@"dotImage.jpg"];
view.customPageControl.dotImageHL = [UIImage imageNamed:@"dotImageHL.jpg"];
```

load image from net 
-------------------
```objective-c
<<<<<<< HEAD
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:CGRectMake(0, 300, 320, 200) URLStringsGroup:imagURLlArray];
view.pageControlStyle = MSPScrollViewPageControlStyleClassic;
=======
MSPScrollView *view = [MSPScrollView scrollViewWithFrame:frame URLStringsGroup:imagURLlArray];
>>>>>>> e248db65ad87e4dfb92ffb1b2cbc06068e9a3563
```

