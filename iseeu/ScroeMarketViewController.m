//
//  ScroeMarketViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/10.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScroeMarketViewController.h"

@implementation ScroeMarketViewController

@synthesize _bannerView;

@synthesize _hud;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"积分商城";
        
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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    _hud.delegate = self;
    
    [_hud show:YES];
    
    [self pushScoreView];
}

-(void)pushScoreView{

    NSString *url = [NSString stringWithFormat:@"%@/index.php/index/lunbo",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *data = [dictionary objectForKey:@"xin"];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        
        for (NSDictionary *dictionary in data) {
            
            HomeModel *homeModel = [HomeModel getHomeModel:dictionary];
            
            [imageArray addObject:homeModel];
        }
        
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 150.0)];
        
        [_bannerView set_imageArray:imageArray];
        
        [_bannerView setBackgroundColor:[UIColor whiteColor]];
        
        [self.view addSubview:_bannerView];
        
        NSString *url = [NSString stringWithFormat:@"%@/index.php/jifen/index",SERVER_URL];
        
        [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSMutableArray *tableData = [NSMutableArray array];
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            for (NSDictionary *info in data) {
                
                ScoreDataModel *scoreDataModel = [ScoreDataModel getScoreData:info];
                
                [tableData addObject:scoreDataModel];
                
            }
            
            ScoreMarketTableView *scoreMarketTableView = [[ScoreMarketTableView alloc] initWithFrame:CGRectMake(0.0, _bannerView.frame.origin.y+_bannerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-_bannerView.frame.size.height-49.0)];
            
            [scoreMarketTableView setFakeData:tableData];
            
            [scoreMarketTableView set_scoreMarketDelegate:self];
            
            [self.view addSubview:scoreMarketTableView];
            
            NSLog(@"%@",data);
        
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"scoreError");
            
        }];
        
        [_hud hide:YES];
        
        NSLog(@"image%@",dictionary);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error");
        
    }];
    
}

-(void)pushScoreDetailView:(ScoreDataModel *)scoreDataModel{
    
    ScoreDetailViewController *scoreDetailViewController = [[ScoreDetailViewController alloc] init];
    
    [scoreDetailViewController set_scoreDataModel:scoreDataModel];
    
    [self.navigationController pushViewController:scoreDetailViewController animated:YES];

}

@end
