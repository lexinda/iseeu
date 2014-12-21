//
//  ViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/12.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <MFSideMenu/MFSideMenu.h>

#import "FootView.h"

#import "BannerView.h"

#import "SpecialSellingTopView.h"

#import "SpecialSellingView.h"

#import "NextSpecialSellingView.h"

#import <AFNetworking/AFNetworking.h>

#import "HomeModel.h"

#import "GoodsDetailViewController.h"

#import "CartDetail.h"

#import "UserInfoViewController.h"

#import "CartDetailViewController.h"

#import "MarketViewController.h"

#import "EyeColorViewController.h"

#import "SideViewController.h"

#import <PPRevealSideViewController/PPRevealSideViewController.h>

@interface ViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,HomeDelegate,UIAlertViewDelegate,FootPushViewDelegate>

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@property(strong,nonatomic)BannerView *_bannerView;

@property(strong,nonatomic)SpecialSellingTopView *_specialSellingTopView;

@property(strong,nonatomic)SpecialSellingView *_specialSellingView;

@property(strong,nonatomic)NextSpecialSellingView *_nextSpecialSellingView;

@property(strong,nonatomic)UITextField *_searchTextField;

@property(strong,nonatomic)NSMutableArray *_bannerArray;

@property(strong,nonatomic)NSMutableArray *_specialSellingTopArray;

@property(strong,nonatomic)NSMutableArray *_specialSellingArray;

@property(strong,nonatomic)NSMutableArray *_nextSpecialSellingArray;

@end

