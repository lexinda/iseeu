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

@synthesize hud;

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
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(userName.frame.origin.x+userName.frame.size.width+15.0, userName.frame.origin.y+55.0, 220.0, 35.0)];
    
    self.userNameField.placeholder = @"输入用户名";
    
    self.userNameField.delegate = self;
    
    self.userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.userNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.userNameField.returnKeyType = UIReturnKeyDone;
    
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.userNameField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.userNameField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [self.view addSubview:self.userNameField];
    
    UIImageView *password = [[UIImageView alloc] initWithFrame:CGRectMake(userName.frame.origin.x, userName.frame.origin.y+userName.frame.size.height+10.0, 35.0, 35.0)];
    
    [password setImage:[UIImage imageNamed:@"password"]];
    
    [loginImageView addSubview:password];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(password.frame.origin.x+password.frame.size.width+15.0, password.frame.origin.y+55.0, 220.0, 35.0)];
    
    self.passwordField.placeholder = @"输入密码";
    
    self.passwordField.delegate = self;
    
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.passwordField.returnKeyType = UIReturnKeyDone;
    
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.passwordField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [self.view addSubview:self.passwordField];
    
    UIImageView *passwordAgain = [[UIImageView alloc] initWithFrame:CGRectMake(userName.frame.origin.x, password.frame.origin.y+password.frame.size.height+10.0, 35.0, 35.0)];
    
    [passwordAgain setImage:[UIImage imageNamed:@"password"]];
    
    [loginImageView addSubview:passwordAgain];
    
    self.passwordAgainField = [[UITextField alloc] initWithFrame:CGRectMake(passwordAgain.frame.origin.x+passwordAgain.frame.size.width+15.0, passwordAgain.frame.origin.y+55.0, 220.0, 35.0)];
    
    self.passwordAgainField.placeholder = @"确认密码";
    
    self.passwordAgainField.delegate = self;
    
    self.passwordAgainField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.passwordAgainField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.passwordAgainField.returnKeyType = UIReturnKeyDone;
    
    self.passwordAgainField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordAgainField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.passwordAgainField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [self.view addSubview:self.passwordAgainField];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registerButton setFrame:CGRectMake((self.view.frame.size.width-180.0)/2, password.frame.origin.y+password.frame.size.height+10.0+50.0+50.0, 80.0, 30.0)];
    
    [registerButton setBackgroundImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerButton];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [resetButton setFrame:CGRectMake(registerButton.frame.origin.x+registerButton.frame.size.width+20.0, registerButton.frame.origin.y, 80.0, 30.0)];
    
    [resetButton setBackgroundImage:[UIImage imageNamed:@"reset_select"] forState:UIControlStateNormal];
    
    [self.view addSubview:resetButton];
    
}

-(void)registerAction{
    
    if ([[self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if ([[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if ([[self.passwordAgainField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if (![[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:[self.passwordAgainField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else{
        
        self.hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:self.hud];
        
        [self.hud setLabelText:@"加载中..."];
        
        self.hud.delegate = self;
        
        [self.hud show:YES];
        
        NSDictionary *parameters = @{@"username":self.userNameField.text,@"password":self.passwordField.text};
        
        NSString *homeUrl = [NSString stringWithFormat:@"%@/index.php/login/reg/",SERVER_URL];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:homeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSDictionary *data = [dictionary objectForKey:@"xin"];
            
            NSString *result = [NSString stringWithFormat:@"%@",[data objectForKey:@"a"]];
            
            if ([result isEqual:@"1"]) {
                [self.hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户已存在！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }else if ([result isEqual:@"2"]) {
                [self.hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }else if ([result isEqual:@"3"]) {
                [self.hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }else if ([result isEqual:@"4"]) {
                [self.hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"非法操作！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            
            NSLog(@"%@",result);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    float Y = 30.0f;
    CGRect rect=CGRectMake(0.0f,Y+34.0,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    
    return [textField resignFirstResponder];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (self.view.frame.size.height-textField.frame.origin.y<216) {
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        //上移30个单位，按实际情况设置
        CGRect rect=CGRectMake(0.0f,-30,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
        
    }
    
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    float Y = 30.0f;
    CGRect rect=CGRectMake(0.0f,Y+34.0,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    
    [self.userNameField resignFirstResponder];
    
    [self.passwordField resignFirstResponder];
    
    [self.passwordAgainField resignFirstResponder];
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud{

    [self.hud removeFromSuperview];
    self.hud = nil;
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
