//
//  GoodsDetailViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/16.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking/AFNetworking.h>

#import "CartDetail.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "UIImageView+WebCache.h"

#import "HomeModel.h"

#import "GoodsFootView.h"

@interface GoodsDetailViewController : UIViewController<MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong,nonatomic)NSNumber *_sid;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@property(strong,nonatomic)UIPickerView *_leftEyePickerView;

@property(strong,nonatomic)NSString *_leftEyeCount;

@property(strong,nonatomic)UIPickerView *_rightEyePickerView;

@property(strong,nonatomic)NSString *_rightEyeCount;

@property(strong,nonatomic)NSArray *_pickerViewData;

@end
