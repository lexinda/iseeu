//
//  BannerView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/13.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeModel.h"

#import "UIImageView+WebCache.h"

@interface BannerView : UIView<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *_scrollView;

@property(strong,nonatomic)UIPageControl *_pageControl;

@property(nonatomic)NSUInteger _index;

@property(strong,nonatomic)NSArray *_imageArray;

@end
