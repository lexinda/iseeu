//
//  RegisterViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "RegisterViewController.h"

@implementation RegisterViewController

@synthesize userNameField;

@synthesize passwordField;

@synthesize passwordAgainField;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"注册Iseeu";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    return self;
    
}

-(void)viewDidLoad{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 45.0)];
    
    [topImageView setImage:[UIImage imageNamed:@"regiser_head"]];
    
    [self.view addSubview:topImageView];

    UIImageView *loginImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, topImageView.frame.origin.y+topImageView.frame.size.height+10.0, self.view.frame.size.width-20.0, 280.0)];
    
    [loginImageView setImage:[UIImage imageNamed:@"userlonginbalack"]];
    
    [self.view addSubview:loginImageView];
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 70.0, 50.0)];
    
    [photoImageView setImage:[UIImage imageNamed:@"userlongin_photo"]];
    
    [loginImageView addSubview:photoImageView];
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoImageView.frame.origin.x+photoImageView.frame.size.width+10.0, photoImageView.frame.origin.y+10.0, 300.0, 30.0)];
    
    noticeLabel.text = @"还没有账号？现在注册";
    
    [loginImageView addSubview:noticeLabel];
    
    
    UIImageView *userName = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, photoImageView.frame.origin.y+photoImageView.frame.size.height+10.0, 35.0, 35.0)];
    
    [userName setImage:[UIImage imageNamed:@"username"]];
    
    [loginImageView addSubview:userName];
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(userName.frame.origin.x+userName.frame.size.width+5.0, userName.frame.origin.y, 220.0, 35.0)];
    
    self.userNameField.placeholder = @"输入用户名";
    
    self.userNameField.delegate = self;
    
    self.userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.userNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.userNameField.returnKeyType = UIReturnKeyDone;
    
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.userNameField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.userNameField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [loginImageView addSubview:self.userNameField];
    
    UIImageView *password = [[UIImageView alloc] initWithFrame:CGRectMake(userName.frame.origin.x, userName.frame.origin.y+userName.frame.size.height+10.0, 35.0, 35.0)];
    
    [password setImage:[UIImage imageNamed:@"password"]];
    
    [loginImageView addSubview:password];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(password.frame.origin.x+password.frame.size.width+5.0, password.frame.origin.y, 220.0, 35.0)];
    
    self.passwordField.placeholder = @"输入密码";
    
    self.passwordField.delegate = self;
    
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.passwordField.returnKeyType = UIReturnKeyDone;
    
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.passwordField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [loginImageView addSubview:self.passwordField];
    
    UIImageView *passwordAgain = [[UIImageView alloc] initWithFrame:CGRectMake(userName.frame.origin.x, password.frame.origin.y+password.frame.size.height+10.0, 35.0, 35.0)];
    
    [passwordAgain setImage:[UIImage imageNamed:@"password"]];
    
    [loginImageView addSubview:passwordAgain];
    
    self.passwordAgainField = [[UITextField alloc] initWithFrame:CGRectMake(passwordAgain.frame.origin.x+passwordAgain.frame.size.width+5.0, passwordAgain.frame.origin.y, 220.0, 35.0)];
    
    self.passwordAgainField.placeholder = @"确认密码";
    
    self.passwordAgainField.delegate = self;
    
    self.passwordAgainField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.passwordAgainField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.passwordAgainField.returnKeyType = UIReturnKeyDone;
    
    self.passwordAgainField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordAgainField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.passwordAgainField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [loginImageView addSubview:self.passwordAgainField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [loginButton setFrame:CGRectMake((self.view.frame.size.width-180.0)/2, password.frame.origin.y+password.frame.size.height+10.0+50.0+50.0, 80.0, 30.0)];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    
    [self.view addSubview:loginButton];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registButton setFrame:CGRectMake(loginButton.frame.origin.x+loginButton.frame.size.width+20.0, loginButton.frame.origin.y, 80.0, 30.0)];
    
    [registButton setBackgroundImage:[UIImage imageNamed:@"reset_select"] forState:UIControlStateNormal];
    
    [self.view addSubview:registButton];
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
