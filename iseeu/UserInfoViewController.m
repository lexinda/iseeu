//
//  UserInfoViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "UserInfoViewController.h"

@implementation UserInfoViewController

@synthesize _aboutTableView;

@synthesize _tableArray;

@synthesize _hud;

@synthesize _uid;

@synthesize _userPhoto;

@synthesize _userNameLabel;

@synthesize _scoreLabel;

@synthesize _scoreUsedLabel;

@synthesize _noticeLabel;

@synthesize _touImage;

@synthesize _userInfo;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"个人中心";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    return self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    ValidataLogin *validataLogin = [[ValidataLogin alloc] init];
    
    NSDictionary *validata = [validataLogin validataUserInfo];

    NSString *username = [validata objectForKey:@"username"];
    
    NSString *password = [validata objectForKey:@"password"];
    
    _uid = [validata objectForKey:@"uid"] ;
    
    if (![username isEqualToString:@""]&&![password isEqualToString:@""]) {
        
        if ([self.view subviews].count>0) {
            for (UIView *view in [self.view subviews]) {
                [view removeFromSuperview];
            }
        }
        
        UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 120.0)];
        
        [topView setImage:[UIImage imageNamed:@"personal_balack"]];
        
        [self.view addSubview:topView];
        
        _userPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [_userPhoto setFrame:CGRectMake(10.0, 10.0, 100.0, 100.0)];
        
        [_userPhoto setBackgroundImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
        
        [_userPhoto addTarget:self action:@selector(showPhotoOptions) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_userPhoto];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userPhoto.frame.origin.x+_userPhoto.frame.size.width+10.0, 10.0, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
        
        [_userNameLabel setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:_userNameLabel];
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x, _userNameLabel.frame.origin.y+_userNameLabel.frame.size.height, 60.0, 30.0)];
        
        [_scoreLabel setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:_scoreLabel];
        
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
        
        [_noticeLabel setText:@"小提示:签到可获得一定的积分哦！"];
        
        _noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        _noticeLabel.numberOfLines = 0;
        
        [_noticeLabel setFont:[UIFont systemFontOfSize:11.0]];
        
        [_noticeLabel setTextColor:[UIColor redColor]];
        
        [self.view addSubview:_noticeLabel];
        
        _scoreUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userNameLabel.frame.origin.x, _scoreLabel.frame.origin.y+_scoreLabel.frame.size.height, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
        
        [_scoreUsedLabel setTextColor:[UIColor whiteColor]];
        
        [self.view addSubview:_scoreUsedLabel];
        
        CGFloat width = (self.view.frame.size.width-20.0)/3;
        
        UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [orderButton setFrame:CGRectMake(10.0, topView.frame.origin.y+topView.frame.size.height+5.0, width, 70.0)];
        
        [orderButton setBackgroundImage:[UIImage imageNamed:@"ordermanager"] forState:UIControlStateNormal];
        
        [orderButton addTarget:self action:@selector(pushOrderView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:orderButton];
        
        UIButton *checkinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [checkinButton setFrame:CGRectMake(orderButton.frame.origin.x+orderButton.frame.size.width, orderButton.frame.origin.y, width, 70.0)];
        
        [checkinButton setBackgroundImage:[UIImage imageNamed:@"checkin"] forState:UIControlStateNormal];
        
        [checkinButton addTarget:self action:@selector(checkinAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:checkinButton];
        
        UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [scoreButton setFrame:CGRectMake(checkinButton.frame.origin.x+checkinButton.frame.size.width, orderButton.frame.origin.y, width, 70.0)];
        
        [scoreButton setBackgroundImage:[UIImage imageNamed:@"personal_score"] forState:UIControlStateNormal];
        
        [scoreButton addTarget:self action:@selector(scoreManage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:scoreButton];
        
        UIImageView *shoppingView = [[UIImageView alloc] initWithFrame:CGRectMake(orderButton.frame.origin.x, orderButton.frame.size.height+orderButton.frame.origin.y+5.0, self.view.frame.size.width-20.0, 50.0)];
        
        [shoppingView setImage:[UIImage imageNamed:@"baseshoppijng"]];
        
        [self.view addSubview:shoppingView];
        
        _tableArray = [NSArray arrayWithObjects:@"基本资料",@"修改密码",@"修改送货地址",@"意见反馈", nil];
        
        _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(shoppingView.frame.origin.x, shoppingView.frame.origin.y+shoppingView.frame.size.height+10.0, shoppingView.frame.size.width, 175.0)];
        
        _aboutTableView.scrollEnabled = NO;
        
        _aboutTableView.delegate = self;
        
        _aboutTableView.dataSource = self;
        
        [self.view addSubview:_aboutTableView];
        
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_hud];
        
        _hud.delegate = self;
        
        [_hud setLabelText:@"加载中..."];
        
        [_hud show:YES];
        
        [self loadUserInfo];
        
    }else{
        
        [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
        
        [imageView setImage:[UIImage imageNamed:@"personal_infobalack"]];
        
        [self.view addSubview:imageView];
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [loginButton setFrame:CGRectMake((self.view.frame.size.width-100)/2, 150.0, 100.0, 30.0)];
        
        [loginButton setBackgroundImage:[UIImage imageNamed:@"nolongin_submmit"] forState:UIControlStateNormal];
        
        [loginButton addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:loginButton];
        
        UIImageView *newShare = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, imageView.frame.origin.y+imageView.frame.size.height+10.0, self.view.frame.size.width-20.0, 45.0)];
        
        [newShare setImage:[UIImage imageNamed:@"new_share"]];
        
        [self.view addSubview:newShare];
        
        _tableArray = [NSArray arrayWithObjects:@"关于Iseeu",@"更多", nil];
        
        _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(newShare.frame.origin.x, newShare.frame.origin.y+newShare.frame.size.height+10.0, newShare.frame.size.width, 90.0)];
        
        _aboutTableView.scrollEnabled = NO;
        
        _aboutTableView.delegate = self;
        
        _aboutTableView.dataSource = self;
        
        [self.view addSubview:_aboutTableView];
        
    }
    
    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-49.0, self.view.frame.size.width, 49.0)];
    
    [footView set_activeView:5];
    
    [footView setViewDelegate:self];
    
    [footView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:footView];
    
}

-(void)viewDidLoad{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
}

-(void)loadUserInfo{
    
    NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
    
    NSDictionary *params = @{@"uid":_uid};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *data = [dictionary objectForKey:@"xin"];
        
        _userInfo = [[UserInfo alloc] getUserInfo:data];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[data objectForKey:@"tou"]]]];
        
        _touImage = [NSString stringWithFormat:@"%@/%@",SERVER_URL,_userInfo.tou];
        
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image != nil) {
            
            [_userPhoto setBackgroundImage:image forState:UIControlStateNormal];
            
        }
        
        [_userNameLabel setText:[NSString stringWithFormat:@"%@",_userInfo.username]];
        
        NSString *scoreText = [NSString stringWithFormat:@"积分：%@",_userInfo.sum_jifen];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        
        CGSize textSize = [scoreText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        [_scoreLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x, _scoreLabel.frame.origin.y, textSize.width, _scoreLabel.frame.size.height)];
        
        [_scoreLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_scoreLabel setText:scoreText];
        
        [_noticeLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
        
        [_scoreUsedLabel setText:[NSString stringWithFormat:@"已使用积分：%@",_userInfo.yi_jifen]];
        
        [_hud hide:YES];
        
        NSLog(@"%@",dictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];

}

-(void)showPhotoOptions{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选取", nil];
    
    sheet.delegate = self;
    
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSLog(@"%li",(long)buttonIndex);
    
    if (buttonIndex == 0) {
        
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.allowsEditing=YES;
        
        picker.delegate=self;
        
        [self presentViewController:picker animated:YES completion:^{
            NSLog(@"载入图片库");
        }];
        
        [self.view addSubview:picker.view];
    }
    
}

//保存获取的照片
-(void)saveImage:(UIImage *)image{
    
    NSLog(@"baocun");
    
    NSString *touUrl = [NSString stringWithFormat:@"%@/index.php/user/tou",SERVER_URL];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *image64 = [data base64String];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png",image64];
    
    NSDictionary *params = @{@"uid":_uid,@"tou":fileName};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:touUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"tou" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableString *responseString = [[NSMutableString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [self showAlert:@"上传成功！"];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_touImage]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image != nil) {
            
            [_userPhoto setBackgroundImage:image forState:UIControlStateNormal];
            
        }
        
        NSLog(@"success%@",responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showAlert:@"上传失败！"];
        
        NSLog(@"error");
        
    }];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"完成图片库");
    }];
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];//获取编辑后的照片
    
    //UIImage *image1=[info objectForKey:UIImagePickerControllerOriginalImage];//获取未编辑的照片
    
    [self performSelector:@selector(saveImage:)withObject:image afterDelay:0.5];//延迟0.5秒获取照片
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消图片库");
    }];
    
}

-(void)goBack{

    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)pushLoginView{

    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_tableArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdetify = @"aboutCell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%li",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        
        UserMaterialViewController *userMaterialViewController = [[UserMaterialViewController alloc] init];
        
        [userMaterialViewController set_uid:_uid];
        
        [self.navigationController pushViewController:userMaterialViewController animated:YES];
        
    }else if(indexPath.row == 1){
        ModifyPasswordViewController *modifyPasswordViewController = [[ModifyPasswordViewController alloc] init];
        
        [modifyPasswordViewController set_uid:_uid];
        
        [self.navigationController pushViewController:modifyPasswordViewController animated:YES];
    }else if (indexPath.row ==2){
    
        ModifyAddressViewController *modifyAddressViewController = [[ModifyAddressViewController alloc] init];
        
        [modifyAddressViewController set_uid:_uid];
        
        [self.navigationController pushViewController:modifyAddressViewController animated:YES];
        
    }
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud{

    [_hud removeFromSuperview];
    
    _hud = nil;
    
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

-(void)pushOrderView{
    
    OrderManageViewController *orderManageViewController = [[OrderManageViewController alloc] init];
    
    [orderManageViewController set_uid:_uid];
    
    [self.navigationController pushViewController:orderManageViewController animated:YES];

}

-(void)checkinAction{
    
    NSString *checkinUrl = [NSString stringWithFormat:@"%@/index.php/user/qiandaoadd",SERVER_URL];
    
    NSDictionary *params = @{@"uid":_uid};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:checkinUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *data = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"a"]];
        if ([data isEqualToString:@"1"]) {
            [self showAlert:@"今天已签到过！"];
        }else if([data isEqualToString:@"2"]) {
            
            NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
            
            NSDictionary *params = @{@"uid":_uid};
            
            [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                
                NSDictionary *data = [dictionary objectForKey:@"xin"];
                
                _userInfo = [[UserInfo alloc] getUserInfo:data];
                
                NSString *scoreText = [NSString stringWithFormat:@"积分：%@",_userInfo.sum_jifen];
                
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
                
                CGSize textSize = [scoreText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                [_scoreLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x, _scoreLabel.frame.origin.y, textSize.width, _scoreLabel.frame.size.height)];
                
                [_scoreLabel setFont:[UIFont systemFontOfSize:15]];
                
                [_scoreLabel setText:scoreText];
                
                [_noticeLabel setFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+2, _scoreLabel.frame.origin.y+2, self.view.frame.size.width-_scoreLabel.frame.origin.x-_scoreLabel.frame.size.width-5.0, 30.0)];
                
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error");
            }];
            
            [self showAlert:@"签到成功！"];
        }
        NSLog(@"%@",dictionary);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];

}

-(void)scoreManage{
    
    ScoreManageViewController *scoreManageViewController = [[ScoreManageViewController alloc] init];
    
    [scoreManageViewController set_uid:_uid];
    
    [scoreManageViewController set_userInfo:_userInfo];
    
    [self.navigationController pushViewController:scoreManageViewController animated:YES];

}

-(void)pushViewController:(int)type{
    
    if (type==0) {
        
        BOOL isHave = NO;
        
        ViewController *viewController = [[ViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:viewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:viewController animated:NO];
        }
        
    }
    
    if (type==1) {
        
        BOOL isHave = NO;
        
        EyeColorViewController *eyeColorViewController = [[EyeColorViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:eyeColorViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:eyeColorViewController animated:NO];
        }
        
    }
    
    if (type == 2) {
        
        BOOL isHave = NO;
        
        MarketViewController *marketViewController = [[MarketViewController alloc] init];
        
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:marketViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:marketViewController animated:NO];
        }
        
    }
    
    
    if (type == 3) {
        
        BOOL isHave = NO;
        
        CartDetailViewController *cartDetailViewController = [[CartDetailViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:cartDetailViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:cartDetailViewController animated:NO];
        }
        
    }

    
}

@end
