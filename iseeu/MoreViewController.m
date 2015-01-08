//
//  MoreViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 15/1/8.
//  Copyright (c) 2015年 朱孟乐. All rights reserved.
//

#import "MoreViewController.h"

@implementation MoreViewController

@synthesize _tableArray;

@synthesize _aboutTableView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"更多";
        
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
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
    
    [imageView setImage:[UIImage imageNamed:@"personal_infobalack"]];
    
    [self.view addSubview:imageView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, imageView.frame.origin.y+imageView.frame.size.height+10.0f, self.view.frame.size.width-20.0f,40.0f)];
    
    [topView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:topView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 100.0f,30.0f)];
    
    [label setText:@"当前版本"];
    
    [topView addSubview:label];
    
    UILabel *typelabel = [[UILabel alloc] initWithFrame:CGRectMake(topView.frame.size.width-130.0f, 5.0f, 130.0f,30.0f)];
    
    [typelabel setText:@"版本号为：1.0"];
    
    [topView addSubview:typelabel];
    
    _tableArray = [NSArray arrayWithObjects:@"给Iseeu五星",@"在微博上关注Iseeu", nil];
    
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0f, topView.frame.origin.y+topView.frame.size.height+10.0, self.view.frame.size.width-20.0, 90.0)];
    
    _aboutTableView.scrollEnabled = NO;
    
    _aboutTableView.delegate = self;
    
    _aboutTableView.dataSource = self;
    
    [self.view addSubview:_aboutTableView];
    
    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-20.0-44.0-49.0, self.view.frame.size.width, 49.0)];
    
    [footView set_activeView:5];
    
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

        NSString *url = [NSString stringWithFormat:@"%@/index.php/index/isu",SERVER_URL];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = [NSString stringWithFormat:@"%@%@",SERVER_URL,[dictionary objectForKey:@"xin"]];
            if ([result isEqualToString:@"1"]) {
                [self showAlert:@"已经点赞！"];
            }else if ([result isEqualToString:@"2"]) {
                [self showAlert:@"点赞成功！"];
            }else{
                [self showAlert:@"点赞失败，请稍后再试！"];
            }
            NSLog(@"success%@",[NSString stringWithFormat:@"%@%@",SERVER_URL,[dictionary objectForKey:@"xin"]]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error");
        }];

        
    }else if(indexPath.row == 1){
        
        
    }
    
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

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

@end
