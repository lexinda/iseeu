//
//  LoginViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

#import "ValidataLogin.h"

#import "UserInfoViewController.h"

#import "CartDetailViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)UITextField *userNameField;

@property(strong,nonatomic)UITextField *passwordField;

@property(strong,nonatomic)MBProgressHUD *hud;

@property(strong,nonatomic)NSString *_parentView;

@end
