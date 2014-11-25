//
//  ClassificationViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/23.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ClassificationViewController.h"

#import "MFSideMenu.h"

@implementation ClassificationViewController

@synthesize _type;

@synthesize _sid;

@synthesize _width;

@synthesize _activeView;

@synthesize _hud;

@synthesize _mainScrollView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"商品分类";
        
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
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消视图！");
    }];
    
}

-(void)viewDidLoad{

    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    _width = self.view.frame.size.width/4;
    
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [oneButton setBackgroundImage:[UIImage imageNamed:@"type_new"] forState:UIControlStateNormal];
    
    [oneButton setBackgroundColor:[UIColor colorWithHexString:@"#ffc9c9"]];
    
    [oneButton setFrame:CGRectMake(0.0, 0.0, _width, 40.0)];
    
    [oneButton setTag:900];
    
    [oneButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:oneButton];
    
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [twoButton setBackgroundImage:[UIImage imageNamed:@"type_hot"] forState:UIControlStateNormal];
    
    [twoButton setBackgroundColor:[UIColor colorWithHexString:@"#ffc9c9"]];
    
    [twoButton setFrame:CGRectMake(oneButton.frame.origin.x+oneButton.frame.size.width, oneButton.frame.origin.x, _width, 40.0)];
    
    [twoButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [twoButton setTag:901];
    
    [self.view addSubview:twoButton];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [threeButton setBackgroundImage:[UIImage imageNamed:@"type_conal"] forState:UIControlStateNormal];
    
    [threeButton setBackgroundColor:[UIColor colorWithHexString:@"#ffc9c9"]];
    
    [threeButton setFrame:CGRectMake(twoButton.frame.origin.x+twoButton.frame.size.width, oneButton.frame.origin.x, _width, 40.0)];
    
    [threeButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [threeButton setTag:902];

    [self.view addSubview:threeButton];
    
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [fourButton setBackgroundImage:[UIImage imageNamed:@"type_price"] forState:UIControlStateNormal];
    
    [fourButton setBackgroundColor:[UIColor colorWithHexString:@"#ffc9c9"]];
    
    [fourButton setFrame:CGRectMake(threeButton.frame.origin.x+threeButton.frame.size.width, oneButton.frame.origin.x, _width, 40.0)];
    
    [fourButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [fourButton setTag:903];
    
    [self.view addSubview:fourButton];
    
    _activeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, oneButton.frame.origin.y+oneButton.frame.size.height, _width, 3)];
    
    [_activeView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"type_line"]]];
    
    [self.view addSubview:_activeView];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, _activeView.frame.origin.y+_activeView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-_activeView.frame.origin.y-_activeView.frame.size.height-40.0-20.0)];
    
    [_mainScrollView setBackgroundColor:[UIColor whiteColor]];
    
    [_mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width*4, _mainScrollView.frame.size.height)];
    
    [_mainScrollView setPagingEnabled:YES];
    
    _mainScrollView.delegate = self;
    
    [self.view addSubview:_mainScrollView];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    _hud.delegate = self;
    
    _hud.labelText=@"加载中...";
    
    [_hud show:YES];
    
    [self.view addSubview:_hud];
    
    [self pushClassificationView];
    
}

-(void)pushClassificationView{

    NSString *url = @"";
    if (_type == 70) {
        url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong",SERVER_URL];
    }else if(_type == 71){
        url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing",SERVER_URL];
    }else if(_type == 72){
        url = [NSString stringWithFormat:@"%@/index.php/yiyi/hulisearch",SERVER_URL];
    }
    NSDictionary *parameters = @{@"sid":[NSNumber numberWithInt:_sid]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSDictionary *data = [dictionary objectForKey:@"cart"];
        
        ///////////////////
        NSMutableArray *newArray = [NSMutableArray array];
        
        NSArray *new = [data objectForKey:@"aa"];
        
        for (int i=0; i<new.count; i++) {
            
            ClassificationModel *classificationModel = [ClassificationModel getClassification:[new objectAtIndex:i]];
            
            [newArray addObject:classificationModel];
        }
        
        if (newArray.count>0) {
            
            ClassificationTableView *classificationTableView = [[ClassificationTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, _mainScrollView.frame.size.height)];
            
            [classificationTableView set_type:&(_type)];
            
            [classificationTableView set_classification:@"new"];
            
            [classificationTableView setIsActive:YES];
            
            [classificationTableView setFakeData:newArray];
            
            [_mainScrollView addSubview:classificationTableView];
            
        }
        
        
        ////////////////////////////
        NSMutableArray *hotArray = [NSMutableArray array];
        
        NSArray *hot = [data objectForKey:@"bb"];
        
        for (int i=0; i<hot.count; i++) {
            
            ClassificationModel *classificationModel = [ClassificationModel getClassification:[hot objectAtIndex:i]];
            
            [newArray addObject:classificationModel];
        }
        if (hotArray.count>0) {
            
            ClassificationTableView *hotClassificationTableView = [[ClassificationTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0.0, self.view.frame.size.width, _mainScrollView.frame.size.height)];
            
            [hotClassificationTableView set_type:&(_type)];
            
            [hotClassificationTableView set_classification:@"hot"];
            
            [hotClassificationTableView setIsActive:YES];
            
            [hotClassificationTableView setFakeData:hotArray];
            
            [_mainScrollView addSubview:hotClassificationTableView];
            
        }
        
        ////////////////////////
        NSMutableArray *conalArray = [NSMutableArray array];
        
        NSArray *conal = [data objectForKey:@"cc"];
        
        for (int i=0; i<conal.count; i++) {
            
            ClassificationModel *classificationModel = [ClassificationModel getClassification:[conal objectAtIndex:i]];
            
            [conalArray addObject:classificationModel];
        }
        
        if (conalArray.count>0) {
            
            ClassificationTableView *conalClassificationTableView = [[ClassificationTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2, 0.0, self.view.frame.size.width, _mainScrollView.frame.size.height)];
            
            [conalClassificationTableView set_type:&(_type)];
            
            [conalClassificationTableView set_classification:@"conal"];
            
            [conalClassificationTableView setIsActive:YES];
            
            [conalClassificationTableView setFakeData:conalArray];
            
            [_mainScrollView addSubview:conalClassificationTableView];
            
        }
        
        
        ////////////////////////
        NSMutableArray *priceArray = [NSMutableArray array];
        
        NSArray *price = [data objectForKey:@"dd"];
        
        for (int i=0; i<price.count; i++) {
            
            ClassificationModel *classificationModel = [ClassificationModel getClassification:[price objectAtIndex:i]];
            
            [priceArray addObject:classificationModel];
        }
        
        if (priceArray.count>0) {
            
            ClassificationTableView *priceClassificationTableView = [[ClassificationTableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3, 0.0, self.view.frame.size.width, _mainScrollView.frame.size.height)];
            
            [priceClassificationTableView set_type:&(_type)];
            
            [priceClassificationTableView set_classification:@"price"];
            
            [priceClassificationTableView setIsActive:YES];
            
            [priceClassificationTableView setFakeData:priceArray];
            
            [_mainScrollView addSubview:priceClassificationTableView];
            
        }
        
        [_hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error");
        
    }];
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud{

    [_hud removeFromSuperview];
    
    _hud = nil;
    
}

-(void)pushContentView:(id)sender{

    UIButton *button = (UIButton *)sender;
    
    CGFloat x = self.view.frame.size.width/4/2;
    
    if (button.tag == 900) {
        
        x=self.view.frame.size.width/4/2;
        
        [_mainScrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        
    }else if(button.tag == 901){
        
        x+=_width;
        
        [_mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0.0) animated:YES];
        
    }else if(button.tag == 902){
        
        x=x+_width*2;
        
        [_mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width*2, 0.0) animated:YES];
        
    }else if(button.tag == 903){
        
        x=x+_width*3;
        
        [_mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width*3, 0.0) animated:YES];
        
    }
            
    [UIView animateWithDuration:0.15f delay:0.1f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //确定UIView的的中心位置和偏转角度
        _activeView.center = CGPointMake(x, _activeView.center.y);
        
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSLog(@"%f",scrollView.contentOffset.x);
    
    int i =scrollView.contentOffset.x/320.0;
    
    CGFloat x = self.view.frame.size.width/4/2;
    
    switch (i) {
        case 0:
            x=self.view.frame.size.width/4/2;
            break;
        case 1:
            x+=_width;
            break;
        case 2:
            x=x+_width*2;
            break;
        case 3:
            x=x+_width*3;
            break;
            
        default:
            break;
    }
    
    [UIView animateWithDuration:0.15f delay:0.1f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        //确定UIView的的中心位置和偏转角度
        _activeView.center = CGPointMake(x, _activeView.center.y);
        
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
    
}

@end
