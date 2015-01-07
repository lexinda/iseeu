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

#import "UIScrollView+UITouch.h"

#import "EyeCircleView.h"

#import "EyeImageView.h"

#import "UserInfoViewController.h"

#import "CartDetailViewController.h"

#import "MarketViewController.h"

#import "ViewController.h"

@interface EyeColorViewController : UIViewController<UIScrollViewDelegate,ViewProtocol,FootPushViewDelegate>

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

@property(nonatomic)CGPoint _gestureStartPoint;

@property(strong,nonatomic)NSString *_originPointName;

@property(strong,nonatomic)NSString *_steepName;

@property(strong,nonatomic)EyeCircleView *_eyeCircleView;

@property(nonatomic)CGPoint _leftCenterPoint;

@property(nonatomic)CGPoint _rightCenterPoint;

@property(strong,nonatomic)UISlider *_eyeSlider;

@property(strong,nonatomic)NSDictionary *_leftDictionary;

@property(strong,nonatomic)NSDictionary *_leftEyeDictionary;

@property(strong,nonatomic)NSDictionary *_rightDictionary;

@property(strong,nonatomic)NSDictionary *_rightEyeDictionary;

@property(strong,nonatomic)UIImageView *_leftImageView;

@property(strong,nonatomic)UIView *_leftEyeView;

@property(strong,nonatomic)UIImageView *_rightImageView;

@property(nonatomic)CGFloat _eyeViewAlpha;

@property(strong,nonatomic)UIView *_rightEyeView;

@property(nonatomic)CGPoint _mousePoint;

@property(nonatomic)CGFloat _radius;

@property(nonatomic)CGFloat _leftRadius;

@property(nonatomic)CGFloat _rightRadius;

@property(strong,nonatomic)NSArray *_colorEyeImage;

@end
