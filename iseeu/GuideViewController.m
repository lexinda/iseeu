//
//  GuideViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 15/1/8.
//  Copyright (c) 2015年 朱孟乐. All rights reserved.
//

#import "GuideViewController.h"

@implementation GuideViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"用户指南";
        
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
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php/index/zhinan",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-49.0)];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,[dictionary objectForKey:@"xin"]]]];
        [self.view addSubview:bgImageView];
        NSLog(@"success%@",[NSString stringWithFormat:@"%@%@",SERVER_URL,[dictionary objectForKey:@"xin"]]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
    
    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-20.0-44.0-49.0, self.view.frame.size.width, 49.0)];
    
    [footView set_activeView:1];
    
    [footView setViewDelegate:self];
    
    [footView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:footView];

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
    
    if (type == 4) {
        BOOL isHave = NO;
        
        UserInfoViewController *userInfoViewController = [[UserInfoViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:userInfoViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:userInfoViewController animated:NO];
        }
    }
    
}

@end
