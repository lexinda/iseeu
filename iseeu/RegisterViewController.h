//
//  RegisterViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)UITextField *userNameField;

@property(strong,nonatomic)UITextField *passwordField;

@property(strong,nonatomic)UITextField *passwordAgainField;

@property(strong,nonatomic)MBProgressHUD *hud;

@end
