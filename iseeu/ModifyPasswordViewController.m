//
//  ModifyPasswordViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@implementation ModifyPasswordViewController

@synthesize _emailField;

@synthesize _phoneField;

@synthesize _userField;

@synthesize _fourField;

@synthesize _hud;

@synthesize _uid;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"我的积分";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    return self;
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 120.0)];
    
    [imageView setImage:[UIImage imageNamed:@"personal_infobalack"]];
    
    [self.view addSubview:imageView];
    
    UIImageView *userHello = [[UIImageView alloc] initWithFrame:CGRectMake(30.0, imageView.frame.origin.y+imageView.frame.size.height+10,self.view.frame.size.width-60.0,40.0)];
    
    [userHello setImage:[UIImage imageNamed:@"personal_info_enter"]];
    
    [self.view addSubview:userHello];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, userHello.frame.origin.y+userHello.frame.size.height, 80.0, 30.0)];
    
    [userLabel setText:@"手机号码"];
    
    [self.view addSubview:userLabel];
    
    _userField = [[UITextField alloc] initWithFrame:CGRectMake(userLabel.frame.size.width+userLabel.frame.origin.x, userLabel.frame.origin.y, self.view.frame.size.width-userLabel.frame.size.width-userLabel.frame.origin.x-20.0, 30.0)];
    
    [_userField setBorderStyle:UITextBorderStyleNone];
    
    _userField.placeholder = @"";
    
    _userField.delegate = self;
    
    _userField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _userField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _userField.returnKeyType = UIReturnKeyDone;
    
    _userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _userField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    _userField.background = [UIImage imageNamed:@"personal_info_et"];
    
    [self.view addSubview:_userField];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, userLabel.frame.origin.y+userLabel.frame.size.height+5.0, 80.0, 30.0)];
    
    [phoneLabel setText:@"登录密码"];
    
    [self.view addSubview:phoneLabel];
    
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.frame.size.width+phoneLabel.frame.origin.x, phoneLabel.frame.origin.y, self.view.frame.size.width-userLabel.frame.size.width-userLabel.frame.origin.x-20.0, 30.0)];
    
    [_phoneField setBorderStyle:UITextBorderStyleNone];
    
    _phoneField.placeholder = @"";
    
    _phoneField.delegate = self;
    
    _phoneField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _phoneField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _phoneField.returnKeyType = UIReturnKeyDone;
    
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _phoneField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    _phoneField.background = [UIImage imageNamed:@"personal_info_et"];
    
    [self.view addSubview:_phoneField];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, phoneLabel.frame.origin.y+phoneLabel.frame.size.height+5.0, 80.0, 30.0)];
    
    [emailLabel setText:@"新设密码"];
    
    [self.view addSubview:emailLabel];
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(emailLabel.frame.size.width+emailLabel.frame.origin.x, emailLabel.frame.origin.y, self.view.frame.size.width-userLabel.frame.size.width-userLabel.frame.origin.x-20.0, 30.0)];
    
    [_emailField setBorderStyle:UITextBorderStyleNone];
    
    _emailField.placeholder = @"";
    
    _emailField.delegate = self;
    
    _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _emailField.returnKeyType = UIReturnKeyDone;
    
    _emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _emailField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    _emailField.background = [UIImage imageNamed:@"personal_info_et"];
    
    [self.view addSubview:_emailField];
    
    UILabel *fourLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, emailLabel.frame.origin.y+emailLabel.frame.size.height+5.0, 80.0, 30.0)];
    
    [fourLabel setText:@"新设密码"];
    
    [self.view addSubview:fourLabel];
    
    _fourField = [[UITextField alloc] initWithFrame:CGRectMake(fourLabel.frame.size.width+fourLabel.frame.origin.x, fourLabel.frame.origin.y, self.view.frame.size.width-fourLabel.frame.size.width-fourLabel.frame.origin.x-20.0, 30.0)];
    
    [_fourField setBorderStyle:UITextBorderStyleNone];
    
    _fourField.placeholder = @"";
    
    _fourField.delegate = self;
    
    _fourField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _fourField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _fourField.returnKeyType = UIReturnKeyDone;
    
    _fourField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _fourField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    _fourField.background = [UIImage imageNamed:@"personal_info_et"];
    
    [self.view addSubview:_fourField];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registerButton setFrame:CGRectMake((self.view.frame.size.width-180.0)/2, fourLabel.frame.origin.y+fourLabel.frame.size.height+10.0, 80.0, 30.0)];
    
    [registerButton setBackgroundImage:[UIImage imageNamed:@"submmit_normal"] forState:UIControlStateNormal];
    
    [registerButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerButton];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [resetButton setFrame:CGRectMake(registerButton.frame.origin.x+registerButton.frame.size.width+20.0, registerButton.frame.origin.y, 80.0, 30.0)];
    
    [resetButton setBackgroundImage:[UIImage imageNamed:@"reset_normal"] forState:UIControlStateNormal];
    
    [resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:resetButton];
    
}

-(void)commitAction{
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    [_hud setLabelText:@"加载中..."];
    
    _hud.delegate = self;
    
    [_hud show:YES];
    
    if ([_phoneField.text isEqualToString:@""]){
        
        [self showAlert:@"登录密码不能为空"];
        
    }else if([_emailField.text isEqualToString:@""]){
        
        [self showAlert:@"新设密码不能为空"];
    
    }else if([_fourField.text isEqualToString:@""]){
        
        [self showAlert:@"新设密码不能为空"];
        
    }else{
        
        NSDictionary *parameters = @{@"uid":_uid,@"nicen":_userField.text,@"phone":_phoneField.text,@"email":_emailField.text};
        
        NSString *homeUrl = [NSString stringWithFormat:@"%@/index.php/user/yii",SERVER_URL];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:homeUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSString *result = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"a"]];
            
            [_hud hide:YES];
            
            [self showAlert:@"修改成功！"];
            
            NSLog(@"%@",result);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
    
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}


-(void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    
    [_hud removeFromSuperview];
    
    _hud = nil;
    
}

-(void)resetAction{
    
    _userField.text=@"";
    
    _phoneField.text=@"";
    
    _emailField.text=@"";
    
    _fourField.text = @"";
    
}


@end
