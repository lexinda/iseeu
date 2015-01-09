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

@synthesize _leftEyeCount;

@synthesize _leftEyePickerView;

@synthesize _rightEyeCount;

@synthesize _rightEyePickerView;

@synthesize _pickerViewData;

@synthesize _cartDetail;

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
        
        NSLog(@"%@",dictionary);
        
        _cartDetail = [CartDetail getCartDetail:dictionary];
        
        UIImageView *goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
        
        NSURL *goodsImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,_cartDetail.pic2]];
        
        [goodsImageView sd_setImageWithURL:goodsImage placeholderImage:[UIImage imageNamed:@"goodsImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"加载goodsImage!");
        }];
        
        [_mainScrollView addSubview:goodsImageView];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, goodsImageView.frame.origin.y+goodsImageView.frame.size.height+10.0, 100.0, 20.0)];
        
        [priceLabel setFont:[UIFont systemFontOfSize:15]];
        
        [priceLabel setText:[NSString stringWithFormat:@"￥%@",_cartDetail.price_xiaoshou]];
        
        [_mainScrollView addSubview:priceLabel];
        
        NSString *sellShuText = [NSString stringWithFormat:@"已有%@人购买",_cartDetail.shu];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        
        CGSize textSize = [sellShuText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        CGFloat cartAndShuWidth = textSize.width+30.0+10.0;
        
        UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [cartButton setFrame:CGRectMake(_mainScrollView.frame.size.width-cartAndShuWidth-10.0, priceLabel.frame.origin.y-8.0, 30.0, 30.0)];
        
        [cartButton setBackgroundImage:[UIImage imageNamed:@"home_shopping"] forState:UIControlStateNormal];
        
        [cartButton addTarget:self action:@selector(pushCartView) forControlEvents:UIControlEventTouchUpInside];
        
        [_mainScrollView addSubview:cartButton];
        
        UILabel *sellShu = [[UILabel alloc] initWithFrame:CGRectMake(cartButton.frame.origin.x+cartButton.frame.size.width+10.0, priceLabel.frame.origin.y, textSize.width, 20.0)];
        
        [sellShu setFont:[UIFont systemFontOfSize:15]];
        
        [sellShu setText:sellShuText];
        
        [_mainScrollView addSubview:sellShu];
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(10.0, priceLabel.frame.origin.y+priceLabel.frame.size.height+5.0, self.view.frame.size.width-20.0, 240.0)];
        
        [selectView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *selectColor = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width-20.0, 20.0)];
        
        [selectColor setText:@"可选颜色"];
        
        [selectColor setFont:[UIFont systemFontOfSize:15]];
        
        [selectView addSubview:selectColor];
        
        UIImageView *separeteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.0, selectColor.frame.origin.y+selectColor.frame.size.height, selectView.frame.size.width-4.0, 2.0)];
        
        [separeteImageView setImage:[UIImage imageNamed:@"home1_item"]];
        
        [selectView addSubview:separeteImageView];
        
        CGFloat imageY = separeteImageView.frame.origin.y+separeteImageView.frame.size.height+5.0;
        
        NSString *yanUrl = [NSString stringWithFormat:@"%@/index/yan",SERVER_URL];
        
        [manager POST:yanUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *data = [responseObject objectForKey:@"xin"];
            
            CGFloat imageX = 0.0;
            
            for (int i=0; i<data.count; i++) {
                
                NSDictionary *dictionary = (NSDictionary *)[data objectAtIndex:i];
                
                HomeModel *yanImage = [HomeModel getHomeModel:dictionary];
                
                NSLog(@"%@",yanImage.pic);
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, 30.0, 30.0)];
                
                [imageView setTag:[yanImage.id intValue]];
                
                NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,yanImage.pic]];
                
                [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"yanImage%d",i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSLog(@"加载眼图片！");
                }];
                
                [selectView addSubview:imageView];
                
                imageX +=30.0;
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载失败！");
        }];
        
        UILabel *leftEye = [[UILabel alloc] initWithFrame:CGRectMake(10.0, selectView.frame.size.height/2+18.0, 40.0, 20.0)];
        
        [leftEye setText:@"左眼"];
        
        [selectView addSubview:leftEye];
        
        CGFloat pickerViewWidth = (selectView.frame.size.width-110.0)/2;
        
        _leftEyePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        _leftEyePickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        _leftEyePickerView.delegate = self;
        
        _leftEyePickerView.dataSource = self;
        
        _leftEyePickerView.frame = CGRectMake(leftEye.frame.origin.x+leftEye.frame.size.width, imageY+30.0+10.0, pickerViewWidth, 20.0);
        
        _leftEyePickerView.showsSelectionIndicator = YES;
        
        _pickerViewData = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        
        _leftEyePickerView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        
        [selectView addSubview:_leftEyePickerView];
        
        UILabel *rightEye = [[UILabel alloc] initWithFrame:CGRectMake(_leftEyePickerView.frame.origin.x+_leftEyePickerView.frame.size.width+10.0, selectView.frame.size.height/2+18.0, 40.0, 20.0)];
        
        [rightEye setText:@"右眼"];
        
        [selectView addSubview:rightEye];
        
        _rightEyePickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        
        _rightEyePickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        _rightEyePickerView.delegate = self;
        
        _rightEyePickerView.dataSource = self;
        
        _rightEyePickerView.frame = CGRectMake(rightEye.frame.origin.x+rightEye.frame.size.width, imageY+30.0+10.0, pickerViewWidth, 20.0);
        
        _rightEyePickerView.showsSelectionIndicator = YES;
        
        _rightEyePickerView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        
        [selectView addSubview:_rightEyePickerView];
        
        [_mainScrollView addSubview:selectView];
        
        UILabel *promise = [[UILabel alloc] initWithFrame:CGRectMake(10.0, selectView.frame.origin.y+selectView.frame.size.height+5.0, 80.0, 20.0)];
        
        [promise setText:[NSString stringWithFormat:@"iseeu保证"]];
        
        [_mainScrollView addSubview:promise];
        
        UIImageView *onePromiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(promise.frame.origin.x, promise.frame.origin.y+promise.frame.size.height+10.0, 35.0, 40.0)];
        
        [onePromiseImageView setImage:[UIImage imageNamed:@"iseeu1"]];
        
        [_mainScrollView addSubview:onePromiseImageView];
        
        UILabel *onePromiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(onePromiseImageView.frame.origin.x+onePromiseImageView.frame.size.width+10.0, onePromiseImageView.frame.origin.y+5.0, 85.0, 30.0)];
        
        [onePromiseLabel setFont:[UIFont systemFontOfSize:18]];
        
        [onePromiseLabel setTextColor:[UIColor redColor]];
        
        [onePromiseLabel setText:@"真品保证:"];
        
        [_mainScrollView addSubview:onePromiseLabel];
        
        UILabel *onePromiseInfo = [[UILabel alloc] initWithFrame:CGRectMake(onePromiseLabel.frame.origin.x+onePromiseLabel.frame.size.width, onePromiseImageView.frame.origin.y+5.0, self.view.frame.size.width-(10.0+35.0+10.0+85.0), 30.0)];
        
        [onePromiseInfo setFont:[UIFont systemFontOfSize:18]];
        
        [onePromiseInfo setText:@"所有商品均为正品"];
        
        [_mainScrollView addSubview:onePromiseInfo];
        
        UIImageView *oneEndImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60.0, onePromiseInfo.frame.origin.y-20.0, 60.0, 70.0)];
        
        [oneEndImageView setImage:[UIImage imageNamed:@"iseeu_notice"]];
        
        [_mainScrollView addSubview:oneEndImageView];
        
        UIImageView *twoPromiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(promise.frame.origin.x, onePromiseImageView.frame.origin.y+onePromiseImageView.frame.size.height+10.0, 35.0, 40.0)];
        
        [twoPromiseImageView setImage:[UIImage imageNamed:@"iseeu2"]];
        
        [_mainScrollView addSubview:twoPromiseImageView];
        
        UILabel *twoPromiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(twoPromiseImageView.frame.origin.x+twoPromiseImageView.frame.size.width+10.0, twoPromiseImageView.frame.origin.y+5.0, 85.0, 30.0)];
        
        [twoPromiseLabel setFont:[UIFont systemFontOfSize:18]];
        
        [twoPromiseLabel setTextColor:[UIColor redColor]];
        
        [twoPromiseLabel setText:@"闪电发货:"];
        
        [_mainScrollView addSubview:twoPromiseLabel];
        
        UILabel *twoPromiseInfo = [[UILabel alloc] initWithFrame:CGRectMake(twoPromiseLabel.frame.origin.x+twoPromiseLabel.frame.size.width, twoPromiseImageView.frame.origin.y+5.0, self.view.frame.size.width-(10.0+35.0+10.0+85.0), 30.0)];
        
        [twoPromiseInfo setFont:[UIFont systemFontOfSize:18]];
        
        [twoPromiseInfo setText:@"6小时发货"];
        
        [_mainScrollView addSubview:twoPromiseInfo];
        
        UIImageView *twoEndImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60.0, twoPromiseInfo.frame.origin.y-20.0, 60.0, 70.0)];
        
        [twoEndImageView setImage:[UIImage imageNamed:@"iseeu_notice"]];
        
        [_mainScrollView addSubview:twoEndImageView];
        
        UIImageView *threePromiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(twoPromiseImageView.frame.origin.x, twoPromiseImageView.frame.origin.y+twoPromiseImageView.frame.size.height+10.0, 35.0, 40.0)];
        
        [threePromiseImageView setImage:[UIImage imageNamed:@"iseeu3"]];
        
        [_mainScrollView addSubview:threePromiseImageView];
        
        UILabel *threePromiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(threePromiseImageView.frame.origin.x+threePromiseImageView.frame.size.width+10.0, threePromiseImageView.frame.origin.y+5.0, 85.0, 30.0)];
        
        [threePromiseLabel setFont:[UIFont systemFontOfSize:18]];
        
        [threePromiseLabel setTextColor:[UIColor redColor]];
        
        [threePromiseLabel setText:@"包邮活动:"];
        
        [_mainScrollView addSubview:threePromiseLabel];
        
        UILabel *threePromiseInfo = [[UILabel alloc] initWithFrame:CGRectMake(threePromiseLabel.frame.origin.x+threePromiseLabel.frame.size.width, threePromiseImageView.frame.origin.y+5.0, self.view.frame.size.width-(10.0+35.0+10.0+85.0), 30.0)];
        
        [threePromiseInfo setFont:[UIFont systemFontOfSize:18]];
        
        [threePromiseInfo setText:@"包邮哦亲"];
        
        [_mainScrollView addSubview:threePromiseInfo];
        
        UIImageView *threeEndImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60.0, threePromiseInfo.frame.origin.y-20.0, 60.0, 70.0)];
        
        [threeEndImageView setImage:[UIImage imageNamed:@"iseeu_notice"]];
        
        [_mainScrollView addSubview:threeEndImageView];
        
        UIImageView *fourPromiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(threePromiseImageView.frame.origin.x, threePromiseImageView.frame.origin.y+threePromiseImageView.frame.size.height+10.0, 35.0, 40.0)];
        
        [fourPromiseImageView setImage:[UIImage imageNamed:@"iseeu4"]];
        
        [_mainScrollView addSubview:fourPromiseImageView];
        
        UILabel *fourPromiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(fourPromiseImageView.frame.origin.x+fourPromiseImageView.frame.size.width+10.0, fourPromiseImageView.frame.origin.y+5.0, 85.0, 30.0)];
        
        [fourPromiseLabel setFont:[UIFont systemFontOfSize:18]];
        
        [fourPromiseLabel setTextColor:[UIColor redColor]];
        
        [fourPromiseLabel setText:@"轻松退货:"];
        
        [_mainScrollView addSubview:fourPromiseLabel];
        
        UILabel *fourPromiseInfo = [[UILabel alloc] initWithFrame:CGRectMake(fourPromiseLabel.frame.origin.x+fourPromiseLabel.frame.size.width, fourPromiseImageView.frame.origin.y+5.0, self.view.frame.size.width-(10.0+35.0+10.0+85.0), 30.0)];
        
        [fourPromiseInfo setFont:[UIFont systemFontOfSize:18]];
        
        [fourPromiseInfo setText:@"无拆装可以退货哦"];
        
        [_mainScrollView addSubview:fourPromiseInfo];
        
        UIImageView *fourEndImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60.0, fourPromiseInfo.frame.origin.y-20.0, 60.0, 70.0)];
        
        [fourEndImageView setImage:[UIImage imageNamed:@"iseeu_notice"]];
        
        [_mainScrollView addSubview:fourEndImageView];
        
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0.0, fourPromiseImageView.frame.origin.y+fourPromiseImageView.frame.size.height+5.0, self.view.frame.size.width, 320.0)];
        
        [footView setTag:800];
        
        [footView setBackgroundColor:[UIColor colorWithRed:167.0/255.0 green:167.0/255.0 blue:167.0/255.0 alpha:1.0]];
        
        CGFloat buttonWidth = (footView.frame.size.width-20.0)/3;
        
        UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [oneButton setFrame:CGRectMake(10.0, 10.0, buttonWidth, 30.0)];
        
        [oneButton setBackgroundColor:[UIColor whiteColor]];
        
        [oneButton setTitle:@"商品介绍" forState:UIControlStateNormal];
        
        [oneButton setTag:801];
        
        [oneButton addTarget:self action:@selector(selectFootViewContent:) forControlEvents:UIControlEventTouchUpInside];
        
        [oneButton setTintColor:[UIColor redColor]];
        
        [footView addSubview:oneButton];
        
        UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [twoButton setFrame:CGRectMake(oneButton.frame.origin.x+oneButton.frame.size.width, 10.0, buttonWidth, 30.0)];
        
        [twoButton setBackgroundColor:[UIColor blackColor]];
        
        [twoButton setTitle:@"商品详情" forState:UIControlStateNormal];
        
        [twoButton setTag:802];
        
        [twoButton addTarget:self action:@selector(selectFootViewContent:) forControlEvents:UIControlEventTouchUpInside];
        
        [twoButton setTintColor:[UIColor whiteColor]];
        
        [footView addSubview:twoButton];
        
        UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [threeButton setFrame:CGRectMake(twoButton.frame.origin.x+twoButton.frame.size.width, 10.0, buttonWidth, 30.0)];
        
        [threeButton setBackgroundColor:[UIColor blackColor]];
        
        [threeButton setTitle:@"口碑" forState:UIControlStateNormal];
        
        [threeButton setTag:803];
        
        [threeButton addTarget:self action:@selector(selectFootViewContent:) forControlEvents:UIControlEventTouchUpInside];
        
        [threeButton setTintColor:[UIColor whiteColor]];
        
        [footView addSubview:threeButton];
        
        UIView *footContentView = [[UIView alloc] initWithFrame:CGRectMake(oneButton.frame.origin.x, oneButton.frame.origin.y+oneButton.frame.size.height, footView.frame.size.width-20.0, 220.0)];
        
        [footContentView setBackgroundColor:[UIColor whiteColor]];
        
        [footContentView setTag:804];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 20.0, 85.0, 20.0)];
        
        [titleLabel setText:@"商品名称："];
        
        [footContentView addSubview:titleLabel];
        
        UILabel *titleLabelInfo = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, titleLabel.frame.origin.y, footContentView.frame.size.width-titleLabel.frame.size.width, 20.0)];
        
        [titleLabelInfo setText:_cartDetail.titleName];
        
        [footContentView addSubview:titleLabelInfo];
        
        [footView addSubview:footContentView];
        
        UILabel *effectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, titleLabel.frame.origin.y+titleLabel.frame.size.height+10.0, 85.0, 20.0)];
        
        [effectLabel setText:@"功效："];
        
        [footContentView addSubview:effectLabel];
        
        UILabel *effectLabelInfo = [[UILabel alloc] initWithFrame:CGRectMake(effectLabel.frame.origin.x+effectLabel.frame.size.width, effectLabel.frame.origin.y, footContentView.frame.size.width-titleLabel.frame.size.width, 20.0)];
        
        [effectLabelInfo setText:@"同一材料更加舒适"];
        
        [footContentView addSubview:effectLabelInfo];
        
        [footView addSubview:footContentView];
        
        UILabel *zhijingLabel = [[UILabel alloc] initWithFrame:CGRectMake(effectLabel.frame.origin.x, effectLabel.frame.origin.y+effectLabel.frame.size.height+10.0, 85.0, 20.0)];
        
        [zhijingLabel setText:@"直径："];
        
        [footContentView addSubview:zhijingLabel];
        
        UILabel *zhijingLabelInfo = [[UILabel alloc] initWithFrame:CGRectMake(zhijingLabel.frame.origin.x+zhijingLabel.frame.size.width, zhijingLabel.frame.origin.y, footContentView.frame.size.width-zhijingLabel.frame.size.width, 20.0)];
        
        [zhijingLabelInfo setText:_cartDetail.zhijin_id];
        
        [footContentView addSubview:zhijingLabelInfo];
        
        [footView addSubview:footContentView];
        
        UILabel *fenLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, zhijingLabel.frame.origin.y+zhijingLabel.frame.size.height+10.0, 85.0, 20.0)];
        
        [fenLabel setText:@"所得积分："];
        
        [footContentView addSubview:fenLabel];
        
        UILabel *fenLabelInfo = [[UILabel alloc] initWithFrame:CGRectMake(fenLabel.frame.origin.x+fenLabel.frame.size.width, fenLabel.frame.origin.y, footContentView.frame.size.width-fenLabel.frame.size.width, 20.0)];
        
        [fenLabelInfo setText:_cartDetail.fen];
        
        [footContentView addSubview:fenLabelInfo];
        
        [footView addSubview:footContentView];
        
        UILabel *hangLabel = [[UILabel alloc] initWithFrame:CGRectMake(fenLabel.frame.origin.x, fenLabel.frame.origin.y+fenLabel.frame.size.height+10.0, 85.0, 20.0)];
        
        [hangLabel setText:@"含水量："];
        
        [footContentView addSubview:hangLabel];
        
        UILabel *hangLabelInfo = [[UILabel alloc] initWithFrame:CGRectMake(hangLabel.frame.origin.x+hangLabel.frame.size.width, hangLabel.frame.origin.y, footContentView.frame.size.width-hangLabel.frame.size.width, 20.0)];
        
        [hangLabelInfo setText:_cartDetail.hang_id];
        
        [footContentView addSubview:hangLabelInfo];
        
        [footView addSubview:footContentView];
        
        UIImageView *footDetailView = [[UIImageView alloc] initWithFrame:CGRectMake(oneButton.frame.origin.x, oneButton.frame.origin.y+oneButton.frame.size.height, footView.frame.size.width-20.0, 320.0)];
        
        [footDetailView setTag:805];
        
        NSURL *goodsDetailImage = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,_cartDetail.pic3]];
        
        [footDetailView sd_setImageWithURL:goodsDetailImage placeholderImage:[UIImage imageNamed:@"goodsDetailImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"加载图片!");
        }];
        
        [footDetailView setHidden:YES];
        
        [footView addSubview:footDetailView];
        
        GoodsFootView *goodsFootView = [[GoodsFootView alloc] initWithFrame:CGRectMake(footContentView.frame.origin.x, footView.frame.size.height-55.0, footContentView.frame.size.width, 55.0)];
        
        [goodsFootView setTag:806];
        
        [goodsFootView set_goodsToCartDelegate:self];
        
        [goodsFootView set_price:_cartDetail.price_xiaoshou];
        
        [goodsFootView setBackgroundColor:[UIColor clearColor]];
        
        [footView addSubview:goodsFootView];
        
        [_mainScrollView addSubview:footView];
        
        [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1020.0)];
        
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return [_pickerViewData count];
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [_pickerViewData objectAtIndex:row];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectFootViewContent:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    UIView *footView = [self.view viewWithTag:800];
    
    UIButton *oneButton = (UIButton *)[self.view viewWithTag:801];
    
    [oneButton setBackgroundColor:[UIColor blackColor]];
    
    [oneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *twoButton = (UIButton *)[self.view viewWithTag:802];
    
    [twoButton setBackgroundColor:[UIColor blackColor]];
    
    [twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *threeButton = (UIButton *)[self.view viewWithTag:803];
    
    [threeButton setBackgroundColor:[UIColor blackColor]];
    
    [threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIView *footContentView = [self.view viewWithTag:804];
    
    [footContentView setHidden:YES];
    
    UIView *footDetailView = [self.view viewWithTag:805];
    
    GoodsFootView *goodsFootView = (GoodsFootView *)[self.view viewWithTag:806];
    
    [footDetailView setHidden:YES];
    
    switch (button.tag) {
        case 801:
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [footView setFrame:CGRectMake(footView.frame.origin.x, footView.frame.origin.y, footView.frame.size.width, 320.0)];
            [goodsFootView setFrame:CGRectMake(footContentView.frame.origin.x, footView.frame.size.height-55.0, footContentView.frame.size.width, 55.0)];
            [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1020.0)];
            [footContentView setHidden:NO];
            break;
        case 802:
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [footView setFrame:CGRectMake(footView.frame.origin.x, footView.frame.origin.y, footView.frame.size.width, 420.0)];
            [goodsFootView setFrame:CGRectMake(footContentView.frame.origin.x, footView.frame.size.height-55.0, footContentView.frame.size.width, 55.0)];
            [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1120.0)];
            [footDetailView setHidden:NO];
            break;
        case 803:
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [footView setFrame:CGRectMake(footView.frame.origin.x, footView.frame.origin.y, footView.frame.size.width, 120.0)];
            [goodsFootView setFrame:CGRectMake(footContentView.frame.origin.x, footView.frame.size.height-55.0, footContentView.frame.size.width, 55.0)];
            [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 820.0)];
            break;
            
        default:
            break;
    }
    
    NSLog(@"%li",(long)button.tag);

}

-(void)pushCartView{
    
    //    personal_infobalack.png
    //
    //    try1111.png
    //
    //    dialg11.png
    
    CartActionDetail *cartActionDetail = [[CartActionDetail alloc] init];
    
    FMDatabase *db = [CartActionDetail getDb];
    
    NSDictionary *dictionary = @{@"id":_cartDetail.id,@"title":_cartDetail.titleName,@"number":@"1",@"price":_cartDetail.price_xiaoshou,@"pic":_cartDetail.pic2};
    
    [cartActionDetail insertCartRow:db withDictionary:dictionary];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"添加购物车成功" delegate:self cancelButtonTitle:@"继续购物" otherButtonTitles:@"进入购物车", nil];
    
    [alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        CartDetailViewController *cartDetailViewController = [[CartDetailViewController alloc] init];
        
        [self.navigationController pushViewController:cartDetailViewController animated:YES];
    }
    
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
