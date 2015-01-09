//
//  GoodsFootView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/19.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsToCartDelegate.h"

@interface GoodsFootView : UIView

@property(strong,nonatomic)NSString *_price;

@property(strong,nonatomic)id<GoodsToCartDelegate> _goodsToCartDelegate;

@end
