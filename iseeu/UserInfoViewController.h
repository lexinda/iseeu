//
//  UserInfoViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"

@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *_aboutTableView;

@property(strong,nonatomic)NSArray *_tableArray;

@end
