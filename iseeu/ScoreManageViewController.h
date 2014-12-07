//
//  ScoreManageViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserInfo.h"

#import "ScoreTableViewCell.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#import "UserScoreLog.h"

@interface ScoreManageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSString *_uid;

@property(strong,nonatomic)UIButton *_userPhoto;

@property(strong,nonatomic)UILabel *_userNameLabel;

@property(strong,nonatomic)UILabel *_scoreLabel;

@property(strong,nonatomic)UILabel *_scoreUsedLabel;

@property(strong,nonatomic)UserInfo *_userInfo;

@property(strong,nonatomic)UITableView *_tableView;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)NSMutableArray *_tableData;

@property(strong,nonatomic)UILabel *_scoreDetail;

@end
