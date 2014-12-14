//
//  EyeView.h
//  isue
//
//  Created by 朱孟乐 on 14/11/3.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "ViewProtocol.h"

@interface EyeView : UIView

@property(nonatomic)CGPoint centerPoint;

@property(nonatomic)CGPoint upPoint;

@property(nonatomic)CGPoint rightPoint;

@property(nonatomic)CGPoint downPoint;

@property(nonatomic)CGPoint leftPoint;

@property(strong,nonatomic)id<ViewProtocol> viewDelegate;

@end
