//
//  UserMaterialViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import <AFNetworking/AFNetworking.h>

@interface UserMaterialViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)UITextField *_userField;

@property(strong,nonatomic)UITextField *_phoneField;

@property(strong,nonatomic)UITextField *_emailField;

@property(strong,nonatomic)MBProgressHUD *_hud;

@property(strong,nonatomic)NSString *_uid;

@end
