//
//  EyeColorViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EyeView.h"

#import <QuartzCore/QuartzCore.h>

@interface EyeColorViewController : UIViewController<UIScrollViewDelegate,ViewProtocol>

@property(strong,nonatomic)UIView *upView;

@property(strong,nonatomic)UIView *rightView;

@property(strong,nonatomic)UIView *downView;

@property(strong,nonatomic)UIView *leftView;

@property(strong,nonatomic)UIView *centerView;

@property(nonatomic)CGPoint centerPoint;

@property(nonatomic)CGPoint upPoint;

@property(nonatomic)CGPoint rightPoint;

@property(nonatomic)CGPoint downPoint;

@property(nonatomic)CGPoint leftPoint;

@property(strong,nonatomic)EyeView *eyeView;

@property(strong,nonatomic)UIScrollView *scrollView;

@property(strong,nonatomic)UIImageView *imageView;

//上一次放大的倍数
@property(strong,nonatomic)NSNumber *oldScale;

@property(nonatomic)CGPoint realCenterPoint;

@property(nonatomic)CGPoint realUpPoint;

@property(nonatomic)CGPoint realRightPoint;

@property(nonatomic)CGPoint realDownPoint;

@property(nonatomic)CGPoint realLeftPoint;

@property(nonatomic)UIButton *commitButton;

@property(strong,nonatomic)UIButton *draw;

@property(strong,nonatomic)UIButton *resizeButton;

@property(strong,nonatomic)UIBezierPath *path;

@property(strong,nonatomic)CAShapeLayer *shapeLayer;

@property(strong,nonatomic)UIImageView *selectImageView;

@property(nonatomic)CGPoint startPoint;

@end
