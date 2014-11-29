//
//  LoginViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *userNameField;

@property(strong,nonatomic)UITextField *passwordField;

@end
