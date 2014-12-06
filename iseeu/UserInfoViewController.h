//
//  UserInfoViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"

#import "ValidataLogin.h"

#import <AFNetworking/AFNetworking.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import "UIButton+WebCache.h"

#import "MF_Base64Additions.h"

@interface UserInfoViewController : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(strong,nonatomic)UITableView *_aboutTableView;

@property(strong,nonatomic)NSArray *_tableArray;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)NSNumber *_uid;

@property(strong,nonatomic)UIButton *_userPhoto;

@property(strong,nonatomic)UILabel *_userNameLabel;

@property(strong,nonatomic)UILabel *_scoreLabel;

@property(strong,nonatomic)UILabel *_scoreUsedLabel;

@property(strong,nonatomic)UILabel *_noticeLabel;

@end
