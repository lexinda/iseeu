//
//  GoodsDetailViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/16.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

@synthesize _sid;

@synthesize _hud;

@synthesize _mainScrollView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        
        [title setText:@"商品详情"];
        
        [title setTextColor:[UIColor whiteColor]];
        
        title.font = [UIFont systemFontOfSize: 20.0];
        
        self.navigationItem.titleView = title;
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-20.0-44.0)];
    
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    [self.view addSubview:_mainScrollView];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    _hud.delegate = self;
    
    _hud.labelText=@"加载中...";
    
    [_hud show:YES];
    
    [self.view addSubview:_hud];
    
    [self pushGoodsView];
    // Do any additional setup after loading the view.
}

-(void)pushGoodsView{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];   // 要传递的json数据是一个字典
    
    [params setObject:_sid forKey:@"sid"];
    
    NSString *goodsDetail = [NSString stringWithFormat:@"%@/index/content",SERVER_URL];
    
    NSLog(@"%@",goodsDetail);
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:goodsDetail parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [responseObject objectForKey:@"cart"] ;
        
        CartDetail *cartDetail = [CartDetail getCartDetail:dictionary];
        
        UIImageView *goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 0.0, self.view.frame.size.width-20.0, 180.0)];
        
        NSURL *goodsImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,cartDetail.pic2]];
        
        [goodsImageView sd_setImageWithURL:goodsImage placeholderImage:[UIImage imageNamed:@"goodsImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"加载goodsImage!");
        }];
        
        [_mainScrollView addSubview:goodsImageView];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, goodsImageView.frame.origin.y+goodsImageView.frame.size.height+10.0, 100.0, 20.0)];
        
        [priceLabel setFont:[UIFont systemFontOfSize:15]];
        
        [priceLabel setText:[NSString stringWithFormat:@"￥%@",cartDetail.price_xiaoshou]];
        
        [_mainScrollView addSubview:priceLabel];
        
        NSString *sellShuText = [NSString stringWithFormat:@"已有%@人购买",cartDetail.shu];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        
        CGSize textSize = [sellShuText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        CGFloat cartAndShuWidth = textSize.width+30.0+10.0;
        
        UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [cartButton setFrame:CGRectMake(_mainScrollView.frame.size.width-cartAndShuWidth-10.0, priceLabel.frame.origin.y-8.0, 30.0, 30.0)];
        
        [cartButton setBackgroundImage:[UIImage imageNamed:@"home_shopping"] forState:UIControlStateNormal];
        
        [_mainScrollView addSubview:cartButton];
        
        UILabel *sellShu = [[UILabel alloc] initWithFrame:CGRectMake(cartButton.frame.origin.x+cartButton.frame.size.width+10.0, priceLabel.frame.origin.y, textSize.width, 20.0)];
        
        [sellShu setFont:[UIFont systemFontOfSize:15]];
        
        [sellShu setText:sellShuText];
        
        [_mainScrollView addSubview:sellShu];
        
        NSLog(@"%@",dictionary);
        
        [_hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error%@",error);
        
    }];
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [_hud removeFromSuperview];
    
    _hud = nil;
}



-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
