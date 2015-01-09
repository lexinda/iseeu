//
//  FeedBackViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 15/1/10.
//  Copyright (c) 2015年 朱孟乐. All rights reserved.
//

#import "FeedBackViewController.h"

@implementation FeedBackViewController

@synthesize _userPhoto;

@synthesize _feedBackText;

@synthesize _uid;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"意见反馈";
        
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
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 120.0)];
    
    [topView setImage:[UIImage imageNamed:@"personal_balack"]];
    
    [self.view addSubview:topView];
    
    _userPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 100.0)];
    
    [_userPhoto setImage:[UIImage imageNamed:@"personal"]];
    
    [self.view addSubview:_userPhoto];
    
    UILabel *kefuLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userPhoto.frame.origin.x+_userPhoto.frame.size.width, _userPhoto.frame.origin.y+30, 60.0f, 10)];
    
    [kefuLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [kefuLabel setTextColor:[UIColor whiteColor]];
    
    [kefuLabel setText:@"在线客服"];
    
    [self.view addSubview:kefuLabel];//iseeu_tel.png qq.png
    
    UIImageView *oneQQImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kefuLabel.frame.origin.x+kefuLabel.frame.size.width, kefuLabel.frame.origin.y, 10.0f, 10.0f)];
    
    [oneQQImageView setImage:[UIImage imageNamed:@"qq.png"]];
    
    [self.view addSubview:oneQQImageView];
    
    UILabel *oneQQLabel = [[UILabel alloc] initWithFrame:CGRectMake(oneQQImageView.frame.origin.x+oneQQImageView.frame.size.width, kefuLabel.frame.origin.y, 80.0f, 10)];
    
    [oneQQLabel setTextColor:[UIColor whiteColor]];
    
    [oneQQLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [oneQQLabel setText:@"316525598"];
    
    [self.view addSubview:oneQQLabel];
    
    UIImageView *twoQQImageView = [[UIImageView alloc] initWithFrame:CGRectMake(oneQQImageView.frame.origin.x, oneQQImageView.frame.origin.y+oneQQImageView.frame.size.height+10.0f, 10.0f, 10.0f)];
    
    [twoQQImageView setImage:[UIImage imageNamed:@"qq.png"]];
    
    [self.view addSubview:twoQQImageView];
    
    UILabel *twoQQLabel = [[UILabel alloc] initWithFrame:CGRectMake(twoQQImageView.frame.origin.x+twoQQImageView.frame.size.width, twoQQImageView.frame.origin.y, 80.0f, 10)];
    
    [twoQQLabel setTextColor:[UIColor whiteColor]];
    
    [twoQQLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [twoQQLabel setText:@"316525598"];
    
    [self.view addSubview:twoQQLabel];
    
    UIImageView *telImageView = [[UIImageView alloc] initWithFrame:CGRectMake(twoQQImageView.frame.origin.x, twoQQImageView.frame.origin.y+twoQQImageView.frame.size.height+10.0f, 10.0f, 10.0f)];
    
    [telImageView setImage:[UIImage imageNamed:@"iseeu_tel.png"]];
    
    [self.view addSubview:telImageView];
    
    UILabel *telQQLabel = [[UILabel alloc] initWithFrame:CGRectMake(telImageView.frame.origin.x+telImageView.frame.size.width, telImageView.frame.origin.y, 90.0f, 10.0f)];
    
    [telQQLabel setTextColor:[UIColor whiteColor]];
    
    [telQQLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    [telQQLabel setText:@"027-87654321"];
    
    [self.view addSubview:telQQLabel];
    
    UILabel *addressDetail = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, topView.frame.origin.y+topView.frame.size.height+25.0, 75.0, 30.0)];
    
    [addressDetail setText:@"意见反馈"];
    
    [self.view addSubview:addressDetail];
    
    _feedBackText = [[UITextView alloc] initWithFrame:CGRectMake(addressDetail.frame.origin.x, addressDetail.frame.origin.y+addressDetail.frame.size.height+5.0, self.view.frame.size.width-20.0f, 80.0)];
    
    UIImageView *imageBackgroundView = [[UIImageView alloc] initWithFrame:[_feedBackText bounds]];
    
    imageBackgroundView.image = [UIImage imageNamed:@"change_address"];
    
    [_feedBackText setText:@"请在此处填写您的宝贵意见！谢谢"];
    
    [_feedBackText addSubview:imageBackgroundView];
    
    _feedBackText.delegate = self;
    
    [self.view addSubview:_feedBackText];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registerButton setFrame:CGRectMake((self.view.frame.size.width-180.0)/2, _feedBackText.frame.origin.y+_feedBackText.frame.size.height+10.0, 80.0, 35.0)];
    
    [registerButton setBackgroundImage:[UIImage imageNamed:@"submmit_normal"] forState:UIControlStateNormal];
    
//    [registerButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerButton];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [resetButton setFrame:CGRectMake(registerButton.frame.origin.x+registerButton.frame.size.width+20.0, registerButton.frame.origin.y, 80.0, 35.0)];
    
    [resetButton setBackgroundImage:[UIImage imageNamed:@"reset_normal"] forState:UIControlStateNormal];
    
    [resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:resetButton];
    
    NSString *userUrl = [NSString stringWithFormat:@"%@/index.php/user/index",SERVER_URL];
    
    NSDictionary *params = @{@"uid":_uid};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:userUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *data = [dictionary objectForKey:@"xin"];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[data objectForKey:@"tou"]]]];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        if (image != nil) {
            
            _userPhoto.image = image;
            
            [_userPhoto.layer setCornerRadius:CGRectGetHeight([_userPhoto bounds]) / 2];  //修改半径，实现头像的圆形化
            
            _userPhoto.layer.masksToBounds = YES;
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error");
        
    }];

    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [_feedBackText setText:@""];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"])  {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

-(void)resetAction{
    
    [_feedBackText setText:@"请在此处填写您的宝贵意见！谢谢"];

}

@end
