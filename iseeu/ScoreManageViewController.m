//
//  ScoreManageViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreManageViewController.h"

@implementation ScoreManageViewController

@synthesize _uid;

@synthesize _userPhoto;

@synthesize _userNameLabel;

@synthesize _scoreLabel;

@synthesize _scoreUsedLabel;

@synthesize _userInfo;

@synthesize _tableView;

@synthesize _hud;

@synthesize _tableData;

@synthesize _scoreDetail;

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
    
    _userPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_userPhoto setFrame:CGRectMake(10.0, imageView.frame.origin.y+imageView.frame.size.height+10.0, 60.0, 60.0)];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,_userInfo.tou]]];
    
    //        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"]];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (image != nil) {
        
        [_userPhoto setBackgroundImage:image forState:UIControlStateNormal];
        
    }else{
    
        [_userPhoto setBackgroundImage:[UIImage imageNamed:@"personal"] forState:UIControlStateNormal];
        
    }
    
    [self.view addSubview:_userPhoto];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userPhoto.frame.origin.x+_userPhoto.frame.size.width+10.0,_userPhoto.frame.origin.y+2.0, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
    
    [_userNameLabel setTextColor:[UIColor blackColor]];
    
    [_userNameLabel setText:_userInfo.username];
    
    [self.view addSubview:_userNameLabel];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userPhoto.frame.origin.x+_userPhoto.frame.size.width+10.0, _userNameLabel.frame.origin.y+_userNameLabel.frame.size.height, 55.0, 30.0)];
    
    [scoreLabel setText:@"积分："];
    
    [self.view addSubview:scoreLabel];
    
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x+scoreLabel.frame.size.width, _userNameLabel.frame.origin.y+_userNameLabel.frame.size.height, 60.0, 30.0)];
    
    [_scoreLabel setTextColor:[UIColor redColor]];
    
    [_scoreLabel setFont:[UIFont systemFontOfSize:13]];
    
    [_scoreLabel setText:[NSString stringWithFormat:@"%@",_userInfo.sum_jifen]];
    
    [self.view addSubview:_scoreLabel];
    
    UILabel *scoreUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(_scoreLabel.frame.origin.x+_scoreLabel.frame.size.width+10.0, scoreLabel.frame.origin.y, 70.0, 30.0)];
    
    [scoreUsedLabel setText:@"已使用："];
    
    [self.view addSubview:scoreUsedLabel];
    
    _scoreUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreUsedLabel.frame.origin.x+scoreUsedLabel.frame.size.width, scoreUsedLabel.frame.origin.y, self.view.frame.size.width-_userPhoto.frame.origin.x-_userPhoto.frame.size.width, 30.0)];
    
    [_scoreUsedLabel setTextColor:[UIColor redColor]];
    
    [_scoreUsedLabel setFont:[UIFont systemFontOfSize:13]];
    
    [_scoreUsedLabel setText:[NSString stringWithFormat:@"%@",_userInfo.yi_jifen]];
    
    [self.view addSubview:_scoreUsedLabel];
    
    _scoreDetail = [[UILabel alloc] initWithFrame:CGRectMake(10.0, _userPhoto.frame.origin.y+_userPhoto.frame.size.height+10.0, self.view.frame.size.width-20.0, 30.0)];
    
    [_scoreDetail setText:@"积分详情"];
    
    [self.view addSubview:_scoreDetail];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    [_hud setLabelText:@"加载中..."];
    
    [_hud show:YES];
    
    [self pushTableView];
    
}


-(void)pushTableView{
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php/user/qiandaolist",SERVER_URL];
    
    NSDictionary *parameters = @{@"uid":@"10"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *cartData = [dictionary objectForKey:@"cart"];
        
        NSArray *cartArray = [cartData objectForKey:@"bb"];
        
        _tableData = [NSMutableArray array];
        
        for (NSDictionary *dictionary in cartArray) {
         
            UserScoreLog *userScoreLog = [[UserScoreLog alloc] getUserScoreLog:dictionary];
            
            [_tableData addObject:userScoreLog];
            
        }
        
        [_hud hide:YES];
        
        NSLog(@"%@",dictionary);
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(_scoreDetail.frame.origin.x, _scoreDetail.frame.origin.y+_scoreDetail.frame.size.height, _scoreDetail.frame.size.width, self.view.frame.size.height-_scoreDetail.frame.origin.y-_scoreDetail.frame.size.height-49.0)];
        
        _tableView.delegate = self;
        
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _tableView.dataSource = self;
        
        [_tableView setBackgroundColor:[UIColor clearColor]];
        
        [self.view addSubview:_tableView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error");
        
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tableData.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"";
    
    UserScoreLog *userScoreLog = (UserScoreLog *)[_tableData objectAtIndex:indexPath.row];
    
    ScoreTableViewCell *cell = (ScoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[ScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withUserScoreLog:userScoreLog];

    //取消选中颜色
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    //取消边框线
    [cell setBackgroundView:[[UIView alloc] init]];
    //取消边框线
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end
