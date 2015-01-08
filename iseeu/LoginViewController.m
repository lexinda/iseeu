//
//  LoginViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

@synthesize userNameField;

@synthesize passwordField;

@synthesize hud;

@synthesize _parentView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"登录Iseeu";
        
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

    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, self.view.frame.size.width-20.0, 30.0)];
    
    topLabel.textAlignment = NSTextAlignmentCenter;
    
    [topLabel setText:@"登录后Iseeu有更强大的功能喔！"];
    
    [self.view addSubview:topLabel];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, topLabel.frame.origin.y+topLabel.frame.size.height, self.view.frame.size.width-20.0, 2.0)];
    
    [line setImage:[UIImage imageNamed:@"userlongin_line"]];
    
    [self.view addSubview:line];
    
    UIImageView *loginImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, topLabel.frame.origin.y+topLabel.frame.size.height+10.0, self.view.frame.size.width-20.0, 230.0)];
    
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
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(userName.frame.origin.x+userName.frame.size.width+15.0, userName.frame.origin.y+50.0, 220.0, 35.0)];
    
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
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(password.frame.origin.x+password.frame.size.width+15.0, password.frame.origin.y+50.0, 220.0, 35.0)];
    
    self.passwordField.placeholder = @"输入密码";
    
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.delegate = self;
    
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    self.passwordField.returnKeyType = UIReturnKeyDone;
    
    self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.passwordField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    self.passwordField.background = [UIImage imageNamed:@"userlong_edit"];
    
    [self.view addSubview:self.passwordField];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [loginButton setFrame:CGRectMake((self.view.frame.size.width-180.0)/2, password.frame.origin.y+password.frame.size.height+10.0+50.0, 80.0, 30.0)];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"longin_submmit"] forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registButton setFrame:CGRectMake(loginButton.frame.origin.x+loginButton.frame.size.width+20.0, loginButton.frame.origin.y, 80.0, 30.0)];
    
    [registButton setBackgroundImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    
    [registButton addTarget:self action:@selector(pushRegisterView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registButton];
    
}

-(void)loginAction{
    
    if ([[self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else if ([[self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else{
        
        self.hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:self.hud];
        
        [self.hud setLabelText:@"加载中..."];
        
        self.hud.delegate = self;
        
        [self.hud show:YES];
        
        NSDictionary *parameters = @{@"username":self.userNameField.text,@"password":self.passwordField.text};
        
        NSString *homeUrl = [NSString stringWithFormat:@"%@/index.php/login",SERVER_URL];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:homeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSDictionary *data = [dictionary objectForKey:@"xin"];
            
            NSString *result = [NSString stringWithFormat:@"%@",[data objectForKey:@"a"]];
            
            if ([result isEqual:@""]) {
                [self.hud hide:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }else{
                [self.hud hide:YES];
                
                NSDictionary *dataDictionary = @{@"username":self.userNameField.text,@"password":self.passwordField.text,@"uid":result};
                
                ValidataLogin *validataLogin = [[ValidataLogin alloc] init];
                
                [validataLogin standardUserInfo:dataDictionary];
                
                for (UIViewController *viewController in self.navigationController.viewControllers) {
                    
                    if ([_parentView isEqualToString:@"cart"]) {
                        
                        if ([viewController isKindOfClass:CartDetailViewController.class]) {
                            
                            [self.navigationController popToViewController:viewController animated:YES];
                            
                        }
                        
                    }else{
                        
                        if ([viewController isKindOfClass:UserInfoViewController.class]) {
                            
                            [self.navigationController popToViewController:viewController animated:YES];
                            
                        }
                    
                    }
                    
                }
                
            }
            
            NSLog(@"%@",dictionary);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}


-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
}

-(void)pushRegisterView{

    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
    
}
@end
