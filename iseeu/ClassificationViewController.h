//
//  ClassificationViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/23.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#import "ClassificationTableView.h"

#import <PPRevealSideViewController/PPRevealSideViewController.h>

#import "ViewController.h"

@interface ClassificationViewController : UIViewController<MBProgressHUDDelegate,UIScrollViewDelegate>

@property(nonatomic)int _type;

@property(nonatomic)int _sid;

@property(nonatomic)CGFloat _width;

@property(strong,nonatomic)UIView *_activeView;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@property(nonatomic)int _comefrom;

@end
