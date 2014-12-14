//
//  ScoreDetailViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#import "ScoreDetailTableCell.h"

#import "ScoreDataModel.h"

#import "ValidataLogin.h"

@interface ScoreDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ScoreDetailDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)UILabel *_cartNumber;

@property(strong,nonatomic)UILabel *_sumPriceValue;

@property(strong,nonatomic)ScoreDataModel *_scoreDataModel;

@property(strong,nonatomic)UITextField *_numberField;

@property(strong,nonatomic)UILabel *_priceLabel;

@property(strong,nonatomic)NSDictionary *_data;

@property(strong,nonatomic)UIButton *_cutButton;

@property(strong,nonatomic)UIButton *_addButton;

@property(strong,nonatomic)UILabel *_titleLabel;

@property(strong,nonatomic)MBProgressHUD *_hud;

@end
