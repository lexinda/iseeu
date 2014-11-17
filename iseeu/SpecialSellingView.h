//
//  SpecialSellingView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/15.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeModel.h"

#import "UIImageView+WebCache.h"

#import "HomeDelegate.h"

@interface SpecialSellingView : UIView

@property(strong,nonatomic)NSArray *_imageArray;

@property(nonatomic)id<HomeDelegate> _delegate;

@end
