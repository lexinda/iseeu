//
//  ViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/12.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize _hud;

@synthesize _mainScrollView;

@synthesize _bannerView;

@synthesize _specialSellingTopView;

@synthesize _specialSellingView;

@synthesize _nextSpecialSellingView;

@synthesize _searchTextField;

@synthesize _bannerArray;

@synthesize _specialSellingTopArray;

@synthesize _specialSellingArray;

@synthesize _nextSpecialSellingArray;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UIImage *navBarImage = [UIImage imageNamed:@"home_head"];
        
        [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"home_head_left"] forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        
        [title setText:@"商城首页"];
        
        [title setTextColor:[UIColor whiteColor]];
        
        title.font = [UIFont systemFontOfSize: 20.0];
        
        self.navigationItem.titleView = title;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [rightButton setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
        
        [rightButton setBackgroundImage:[UIImage imageNamed:@"home_head_right"] forState:UIControlStateNormal];
        
        [rightButton addTarget:self action:@selector(rightSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
    }
    
    return self;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-20.0-44.0-49.0)];
    
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width/3, 40.0)];
    
    [searchImageView setImage:[UIImage imageNamed:@"home_search_head"]];
    
    [_mainScrollView addSubview:searchImageView];
    
    _mainScrollView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerIncident:)];
    
    singleFingerOne.numberOfTouchesRequired = 1;
    
    singleFingerOne.numberOfTapsRequired = 1;
    
    singleFingerOne.delegate = self;
    
    [_mainScrollView addGestureRecognizer:singleFingerOne];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(searchImageView.frame.size.width, searchImageView.frame.origin.y, self.view.frame.size.width-searchImageView.frame.size.width, 40.0)];
    
    [_searchTextField setBorderStyle:UITextBorderStyleNone];
    
    _searchTextField.placeholder = @"搜颜色/直径/价格";
    
    _searchTextField.delegate = self;
    
    _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    _searchTextField.returnKeyType = UIReturnKeyDone;
    
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _searchTextField.contentVerticalAlignment= UIControlContentVerticalAlignmentCenter;
    
    _searchTextField.background = [UIImage imageNamed:@"home_search_content"];
    
    [_mainScrollView addSubview:_searchTextField];
    
    [self.view addSubview:_mainScrollView];
    
    FootView *footView = [[FootView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-20.0-44.0-49.0, self.view.frame.size.width, 49.0)];
    
    [footView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:footView];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    _hud.delegate = self;
    
    [_hud setLabelText:@"加载中..."];
    
    //[_hud showWhileExecuting:@selector(showHud) onTarget:self withObject:nil animated:YES];
    
    [_hud show:YES];
    
    [self showHud];
    
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
//        [self setupMenuBarButtonItems];
    }];
}

-(void)showHud{
    
    NSString *homeUrl = [NSString stringWithFormat:@"%@/index.php/index/index/",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:homeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //NSLog(@"%@",dictionary);
        
        NSDictionary *data = [dictionary objectForKey:@"cart"];
        
        _bannerArray = [data objectForKey:@"aa"];
        
        if (_bannerArray != nil) {
            
            NSMutableArray *imageArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<_bannerArray.count; i++) {
                
                HomeModel *homeModel = [HomeModel getHomeModel:[_bannerArray objectAtIndex:i]];
                
                [imageArray addObject:homeModel];
                
            }
            
            _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0.0, _searchTextField.frame.origin.y+_searchTextField.frame.size.height, self.view.frame.size.width, 150.0)];
            
            [_bannerView set_imageArray:imageArray];
            
            [_bannerView setBackgroundColor:[UIColor whiteColor]];
            
            [_mainScrollView addSubview:_bannerView];
            
        }
        
        UIImageView *meddleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, _bannerView.frame.origin.y+_bannerView.frame.size.height+5.0, self.view.frame.size.width-10.0, 30.0)];
        
        [meddleImageView setImage:[UIImage imageNamed:@"new_put"]];
        
        [_mainScrollView addSubview:meddleImageView];
        
        _specialSellingTopArray = [data objectForKey:@"bb"];
        
        if (_specialSellingTopArray != nil) {
            
            NSMutableArray *imageArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<_specialSellingTopArray.count; i++) {
                
                HomeModel *homeModel = [HomeModel getHomeModel:[_specialSellingTopArray objectAtIndex:i]];
                
                [imageArray addObject:homeModel];
                
            }
            
            _specialSellingTopView = [[SpecialSellingTopView alloc] initWithFrame:CGRectMake(5.0, meddleImageView.frame.origin.y+meddleImageView.frame.size.height+5.0, self.view.frame.size.width-10.0, 100.0)];
            
            _specialSellingTopView._delegate = self;
            
            [_specialSellingTopView set_imageArray:imageArray];
            
            [_specialSellingTopView setBackgroundColor:[UIColor whiteColor]];
            
            [_mainScrollView addSubview:_specialSellingTopView];
            
        }
        
        _specialSellingArray = [data objectForKey:@"cc"];
        
        if (_specialSellingArray != nil) {
            
            
            NSMutableArray *imageArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<_specialSellingArray.count; i++) {
                
                HomeModel *homeModel = [HomeModel getHomeModel:[_specialSellingArray objectAtIndex:i]];
                
                [imageArray addObject:homeModel];
                
            }
            
            _specialSellingView = [[SpecialSellingView alloc] initWithFrame:CGRectMake(5.0, _specialSellingTopView.frame.origin.y+_specialSellingTopView.frame.size.height, self.view.frame.size.width-10.0, 195.0*_specialSellingArray.count)];
            
            [_specialSellingView setBackgroundColor:[UIColor whiteColor]];
            
            _specialSellingView._delegate = self;
            
            [_specialSellingView set_imageArray:imageArray];
            
            [_mainScrollView addSubview:_specialSellingView];
            
        }
        
        UIImageView *nextWeekImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, _specialSellingView.frame.origin.y+_specialSellingView.frame.size.height+5.0, self.view.frame.size.width-10.0,30.0)];
        
        [nextWeekImageView setImage:[UIImage imageNamed:@"home_next_week"]];
        
        [_mainScrollView addSubview:nextWeekImageView];
        
        _nextSpecialSellingArray = [data objectForKey:@"dd"];
        
        if (_nextSpecialSellingArray != nil) {
            
            NSMutableArray *imageArray = [[NSMutableArray alloc] init];
            
            for (int i=0; i<_nextSpecialSellingArray.count; i++) {
                
                HomeModel *homeModel = [HomeModel getHomeModel:[_nextSpecialSellingArray objectAtIndex:i]];
                
                [imageArray addObject:homeModel];
                
            }
            
            _nextSpecialSellingView  = [[NextSpecialSellingView alloc] initWithFrame:CGRectMake(5.0, nextWeekImageView.frame.origin.y+nextWeekImageView.frame.size.height+5.0, self.view.frame.size.width-10.0, 100.0)];
            
            [_nextSpecialSellingView setBackgroundColor:[UIColor whiteColor]];
            
            [_nextSpecialSellingView set_imageArray:imageArray];
            
            _nextSpecialSellingView._delegate = self;
            
            [_mainScrollView addSubview:_nextSpecialSellingView];
            
        }
        
        [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 195.0*_specialSellingArray.count+_specialSellingTopView.frame.size.height+_bannerView.frame.size.height+_nextSpecialSellingView.frame.size.height+123.0)];
        
        [_hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }];
    
}

//手指点击事件
- (void)fingerIncident:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTouchesRequired==1) {
        //单指点击事件
        if(sender.numberOfTapsRequired == 1) {
            //单指单击
            NSLog(@"单指单击");
            
            CGPoint point = [sender locationInView:self.view];
            
            NSLog(@"%i",CGRectContainsPoint(_searchTextField.frame, point));
            
            if(!CGRectContainsPoint(_searchTextField.frame, point)){
                    
                [_searchTextField resignFirstResponder];
            
            }
        }
        else if(sender.numberOfTapsRequired ==2 ){
            //单指双击
            NSLog(@"单指双击");
        }
    }
    else if (sender.numberOfTouchesRequired==2) {
        //双指点击事件
        if(sender.numberOfTapsRequired == 1) {
            //双指单击
            NSLog(@"双指单击");
            
        }
        else if(sender.numberOfTapsRequired ==2 ){
            //双指双击
            NSLog(@"双指双击");
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    return [textField resignFirstResponder];
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [_hud removeFromSuperview];
    _hud = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushGoodsDetail:(NSNumber *)sid{

    GoodsDetailViewController *goodsDetailViewController = [[GoodsDetailViewController alloc] init];
    
    [goodsDetailViewController set_sid:sid];
    
    [self.navigationController pushViewController:goodsDetailViewController animated:YES];

}

@end
