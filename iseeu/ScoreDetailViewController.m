//
//  ScoreDetailViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreDetailViewController.h"

@implementation ScoreDetailViewController

@synthesize _cartNumber;

@synthesize _sumPriceValue;

@synthesize _scoreDataModel;

@synthesize _numberField;

@synthesize _priceLabel;

@synthesize _data;

@synthesize _cutButton;

@synthesize _addButton;

@synthesize _titleLabel;

@synthesize _hud;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"兑换";
        
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
    
    CGFloat width = (self.view.frame.size.width-40.0)/2;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
    
    [topView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:topView];
    
    UILabel *cartCount = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 80.0, 30.0)];
    
    [cartCount setTextColor:[UIColor whiteColor]];
    
    [cartCount setText:@"商品数量:"];
    
    [self.view addSubview:cartCount];
    
    _cartNumber = [[UILabel alloc] initWithFrame:CGRectMake(cartCount.frame.origin.x+cartCount.frame.size.width, cartCount.frame.origin.y, width-cartCount.frame.size.width-30.0, 30.0)];
    
    [_cartNumber setTextColor:[UIColor whiteColor]];
    
    [_cartNumber setText:[NSString stringWithFormat:@"%i",1]];
    
    [self.view addSubview:_cartNumber];
    
    UILabel *sumPrice = [[UILabel alloc] initWithFrame:CGRectMake(_cartNumber.frame.origin.x+_cartNumber.frame.size.width, 10.0, 80.0, 30.0)];
    
    [sumPrice setTextColor:[UIColor whiteColor]];
    
    [sumPrice setText:@"需耗积分:"];
    
    [self.view addSubview:sumPrice];
    
    _sumPriceValue = [[UILabel alloc] initWithFrame:CGRectMake(sumPrice.frame.origin.x+sumPrice.frame.size.width, sumPrice.frame.origin.y, width-sumPrice.frame.size.width+30.0, 30.0)];
    
    [_sumPriceValue setTextColor:[UIColor redColor]];
    
    [_sumPriceValue setText:[NSString stringWithFormat:@"%d分",[_scoreDataModel.fen intValue]]];
    
    [self.view addSubview:_sumPriceValue];
    
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, topView.frame.size.height+5.0, 80.0, 60.0)];
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,_scoreDataModel.pic2]];
    
    [picImageView sd_setImageWithURL:imageUrl];
    
    [self.view addSubview:picImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.frame.origin.x+picImageView.frame.size.width+10.0, picImageView.frame.origin.y+5.0, self.view.frame.size.width-30.0-picImageView.frame.origin.x-picImageView.frame.size.width, 20.0)];
    
    [_titleLabel setText:[NSString stringWithFormat:@"%@",_scoreDataModel.title]];
    
    [self.view addSubview:_titleLabel];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    NSString *fenStr = _scoreDataModel.fen;
    
    NSString *numberStr = [NSString stringWithFormat:@"1"];
    
    NSString *priceValueStr = [NSString stringWithFormat:@"%i",[fenStr intValue]*[numberStr intValue]];
    
    CGSize textSize = [priceValueStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10.0, textSize.width, 20.0)];
    
    [_priceLabel setFont:[UIFont systemFontOfSize:15]];
    
    [_priceLabel setTextColor:[UIColor redColor]];
    
    [_priceLabel setText:priceValueStr];
    
    [self.view addSubview:_priceLabel];
    
    _cutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_cutButton setFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width+20.0, _priceLabel.frame.origin.y, 20.0, 20.0)];
    
    [_cutButton addTarget:self action:@selector(cutTextValue) forControlEvents:UIControlEventTouchUpInside];
    
    [_cutButton setBackgroundImage:[UIImage imageNamed:@"shopping_cut"] forState:UIControlStateNormal];
    
    [_cutButton setBackgroundImage:[UIImage imageNamed:@"shopping_cut1"] forState:UIControlStateSelected];
    
    [self.view addSubview:_cutButton];
    
    _numberField = [[UITextField alloc] initWithFrame:CGRectMake(_cutButton.frame.origin.x+_cutButton.frame.size.width+2, _cutButton.frame.origin.y, 50.0, 20.0)];
    
    _numberField.text = numberStr;
    
    _numberField.textAlignment = NSTextAlignmentCenter;
    
    [_numberField setBackground:[UIImage imageNamed:@"shopping_et"]];
    
    [_numberField setEnabled:NO];
    
    [self.view addSubview:_numberField];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_addButton setFrame:CGRectMake(_numberField.frame.origin.x+_numberField.frame.size.width+2, _numberField.frame.origin.y, 20.0, 20.0)];
    
    [_addButton addTarget:self action:@selector(addTextValue) forControlEvents:UIControlEventTouchUpInside];
    
    [_addButton setBackgroundImage:[UIImage imageNamed:@"shopping_add"] forState:UIControlStateNormal];
    
    [_addButton setBackgroundImage:[UIImage imageNamed:@"shopping_add1"] forState:UIControlStateSelected];
    
    [self.view addSubview:_addButton];
    
    UIButton *getMoney = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [getMoney setFrame:CGRectMake(30.0, picImageView.frame.origin.y+picImageView.frame.size.height+10.0, self.view.frame.size.width-60.0, 30.0)];
    
    [getMoney addTarget:self action:@selector(convertScore) forControlEvents:UIControlEventTouchUpInside];
    
    [getMoney setBackgroundImage:[UIImage imageNamed:@"submmit_changescore"] forState:UIControlStateNormal];
    
    [self.view addSubview:getMoney];
    
    // Do any additional setup after loading the view.
}

-(void)gotoMarket{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)cutTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    if ([text intValue]>1) {
        
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]-1]];
        
        NSString *price = _priceLabel.text;
        
        NSString *priceValue = [_data objectForKey:@"fen"];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%.2lf",[price floatValue]-[priceValue floatValue]]];
        
        [self cutCartDetail:1 whith:[priceValue intValue]];
        
    }else{
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]]];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"fen"]]];
        
    }
    
}

-(void)addTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]+1]];
    
    NSString *price = _priceLabel.text;
    
    NSString *priceValue = _scoreDataModel.fen;
    
    NSLog(@"%i,%i,%i",[price intValue],[priceValue intValue],[price intValue]+[priceValue intValue]);
    
    [_priceLabel setText:[NSString stringWithFormat:@"%i",[price intValue]+[priceValue intValue]]];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    NSString *priceStr = [NSString stringWithFormat:@"%i",[price intValue]+[priceValue intValue]];
    
    CGSize textSize = [priceStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [_priceLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10.0, textSize.width, _priceLabel.frame.size.height)];
    
    [_cutButton setFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width+20.0, _priceLabel.frame.origin.y, 20.0, 20.0)];
    
    [_numberField setFrame:CGRectMake(_cutButton.frame.origin.x+_cutButton.frame.size.width+2, _cutButton.frame.origin.y, 50.0, 20.0)];
    
    [_addButton setFrame:CGRectMake(_numberField.frame.origin.x+_numberField.frame.size.width+2, _numberField.frame.origin.y, 20.0, 20.0)];
    
    [self addCartDetail:1 whith:[priceValue intValue]];
    
    
}


-(void)cutCartDetail:(int)number whith:(int)price{
    
    [_cartNumber setText:[NSString stringWithFormat:@"%i",[_cartNumber.text intValue]-number]];
    
    [_sumPriceValue setText:[NSString stringWithFormat:@"%i分",[_sumPriceValue.text intValue]-price]];
    
}

-(void)addCartDetail:(int)number whith:(int)price{
    
    [_cartNumber setText:[NSString stringWithFormat:@"%i",[_cartNumber.text intValue]+number]];
    
    [_sumPriceValue setText:[NSString stringWithFormat:@"%i分",[_sumPriceValue.text intValue]+price]];
    
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
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


-(void)convertScore{
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    [_hud setLabelText:@"加载中..."];
    
    _hud.delegate = self;
    
    [_hud show:YES];
    
    NSString *url = [NSString stringWithFormat:@"%@/index.php/index/orderupdate/",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *number = _cartNumber.text;
    
    ValidataLogin *validataLogin = [[ValidataLogin alloc] init];
    
    NSDictionary *userDictionary = [validataLogin validataUserInfo];
    
    NSDictionary *param = @{@"sid":_scoreDataModel.id,@"number":number,@"uid":[userDictionary objectForKey:@"uid"]};
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [_hud hide:YES];
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSString *result = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"a"]];
        
        if ([result isEqualToString:@"1"]) {
            [self showAlert:@"你的积分不计分不够，赶紧去攒哦"];
        }else if ([result isEqualToString:@"2"]) {
            [self showAlert:@"恭喜你已经兑换成功"];
        }else if ([result isEqualToString:@"3"]) {
            [self showAlert:@"操作失败，请你重新操作"];
        }else if ([result isEqualToString:@"4"]) {
            [self showAlert:@"操作失败，请你重新操作"];
        }else{
            [self showAlert:@"操作失败，请你重新操作"];
        }
        
        NSLog(@"%@",dictionary);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"scoreError");
        
    }];


}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    
    [_hud removeFromSuperview];
    
    _hud = nil;

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
