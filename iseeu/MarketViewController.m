//
//  MarketViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/10.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "MarketViewController.h"

@implementation MarketViewController

@synthesize _hud;

@synthesize _brandScrollView;

@synthesize _oneButton;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"商城";
        
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
    
    _brandScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0,self.view.frame.size.width, self.view.frame.size.height-49.0-64.0)];
    
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 130.0)];
    
    [topView setImage:[UIImage imageNamed:@"five.jpg"]];
    
    [_brandScrollView addSubview:topView];
    
    CGFloat topButtonWidth = (self.view.frame.size.width-20.0)/4;
    
    _oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_oneButton setFrame:CGRectMake(10.0, topView.frame.origin.y+topView.frame.size.height, topButtonWidth, 70.0)];
    
    [_oneButton setBackgroundImage:[UIImage imageNamed:@"aa"] forState:UIControlStateNormal];
    
    [_brandScrollView addSubview:_oneButton];
    
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [twoButton setFrame:CGRectMake(_oneButton.frame.origin.x+_oneButton.frame.size.width, topView.frame.origin.y+topView.frame.size.height, topButtonWidth, 70.0)];
    
    [twoButton setBackgroundImage:[UIImage imageNamed:@"bb"] forState:UIControlStateNormal];
    
    [_brandScrollView addSubview:twoButton];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [threeButton setFrame:CGRectMake(twoButton.frame.origin.x+twoButton.frame.size.width, topView.frame.origin.y+topView.frame.size.height, topButtonWidth, 70.0)];
    
    [threeButton setBackgroundImage:[UIImage imageNamed:@"cc"] forState:UIControlStateNormal];
    
    [_brandScrollView addSubview:threeButton];
    
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [fourButton setFrame:CGRectMake(threeButton.frame.origin.x+threeButton.frame.size.width, topView.frame.origin.y+topView.frame.size.height, topButtonWidth, 70.0)];
    
    [fourButton addTarget:self action:@selector(pushScoreMarketView) forControlEvents:UIControlEventTouchUpInside];
    
    [fourButton setBackgroundImage:[UIImage imageNamed:@"dd"] forState:UIControlStateNormal];
    
    [_brandScrollView addSubview:fourButton];
    
    [self.view addSubview:_brandScrollView];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    _hud.delegate = self;
    
    [_hud show:YES];
    
    [self pushMarketView];
    
    
}

-(void)pushMarketView{
    
    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php/index/pinban",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *data = [dictionary objectForKey:@"xin"];
        
        int row = (int)data.count/4;
        
        if (row == 0) {
            row = 1;
        }else{
            row=row+1;
        }
        
        int index=0;
        
        int y = _oneButton.frame.origin.y+_oneButton.frame.size.height+5.0;
        
        CGFloat brandWidth = (self.view.frame.size.width-10.0-15.0)/4;
        
        for(int m=0;m<row;m++){
            
            CGFloat x=5.0;
            
            for (int n=0;n<4;n++) {
                
                if (index<data.count) {
                    
                    NSDictionary *brandDictionary = [data objectAtIndex:index];
                    
                    NSString *picUrl = [NSString stringWithFormat:@"%@%@",SERVER_URL,[brandDictionary objectForKey:@"pic"]];
                    
                    NSLog(@"%@",picUrl);
                    
//                    NSData *picData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
                    
                    UIButton *brandButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    
//                    [brandButton setImage:[UIImage imageWithData:picData] forState:UIControlStateNormal];
                    
                    [brandButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picUrl] forState:UIControlStateNormal];
                    
                    [brandButton setFrame:CGRectMake(x, y, brandWidth, brandWidth)];
                    
                    [_brandScrollView addSubview:brandButton];
                    
                    x = x+brandWidth+5.0;
                    
                    index++;
                    
                }
                
            }
            
            y=y+brandWidth+5.0;
            
        }
        
        [_brandScrollView setContentSize:CGSizeMake(self.view.frame.size.width, y)];
        
        [_hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error");
        
    }];

}

-(void)pushScoreMarketView{

    ScroeMarketViewController *scoreMarketViewController = [[ScroeMarketViewController alloc] init];
    
    [self.navigationController pushViewController:scoreMarketViewController animated:YES];
    
}

@end
