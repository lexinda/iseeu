//
//  CartDetailViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "CartDetailViewController.h"

@interface CartDetailViewController ()

@end

@implementation CartDetailViewController

@synthesize _tableData;

@synthesize _tableView;

@synthesize _deleteId;

@synthesize _cartNumber;

@synthesize _sumPriceValue;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"购物车";
        
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
    
    [self getTableData];
    
    if (_tableData.count>0) {
        
        int number=0;
        
        float price = 0.0f;
        
        for (NSDictionary *dictionary in _tableData) {
            
            number = number+[[dictionary objectForKey:@"number"] intValue];
            
            price = price+[[dictionary objectForKey:@"price"] floatValue]*[[dictionary objectForKey:@"number"] intValue];
            
        }
        
        
        CGFloat width = (self.view.frame.size.width-40.0)/2;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
        
        [topView setBackgroundColor:[UIColor blackColor]];
        
        [self.view addSubview:topView];
        
        UILabel *cartCount = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, 80.0, 30.0)];
        
        [cartCount setTextColor:[UIColor whiteColor]];
        
        [cartCount setText:@"商品数量:"];
        
        [self.view addSubview:cartCount];
        
        _cartNumber = [[UILabel alloc] initWithFrame:CGRectMake(cartCount.frame.origin.x+cartCount.frame.size.width, cartCount.frame.origin.y, width-cartCount.frame.size.width, 30.0)];
        
        [_cartNumber setTextColor:[UIColor whiteColor]];
        
        [_cartNumber setText:[NSString stringWithFormat:@"%i",number]];
        
        [self.view addSubview:_cartNumber];
        
        UILabel *sumPrice = [[UILabel alloc] initWithFrame:CGRectMake(20.0+width, 10.0, 40.0, 30.0)];
        
        [sumPrice setTextColor:[UIColor whiteColor]];
        
        [sumPrice setText:@"总计:"];
        
        [self.view addSubview:sumPrice];
        
        _sumPriceValue = [[UILabel alloc] initWithFrame:CGRectMake(sumPrice.frame.origin.x+sumPrice.frame.size.width, sumPrice.frame.origin.y, width-sumPrice.frame.size.width, 30.0)];
        
        [_sumPriceValue setTextColor:[UIColor redColor]];
        
        [_sumPriceValue setText:[NSString stringWithFormat:@"%.2f元",price]];
        
        [self.view addSubview:_sumPriceValue];
        
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0.0, topView.frame.origin.y+topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-50-49-64-40)];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        
        UIButton *getMoney = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [getMoney setFrame:CGRectMake(30.0, _tableView.frame.origin.y+_tableView.frame.size.height+10.0, self.view.frame.size.width-60.0, 30.0)];
        
        [getMoney setBackgroundImage:[UIImage imageNamed:@"shopping_getmoney"] forState:UIControlStateNormal];
        
        [self.view addSubview:getMoney];
        
    }else{
    
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width)];
        
        [imageView setImage:[UIImage imageNamed:@"shopping_no"]];
        
        [self.view addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [button setFrame:CGRectMake(80.0, imageView.frame.size.height+10.0, self.view.frame.size.width-160.0, 40.0)];
        
        [button setBackgroundImage:[UIImage imageNamed:@"toshopping"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(gotoMarket) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
    }
    
    
    
    // Do any additional setup after loading the view.
}

-(void)gotoMarket{
            
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tableData.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CustomCellIdentifier";
    
    NSDictionary *dictionary = [_tableData objectAtIndex:indexPath.row];
    
    CartDetailTableViewCell *cell = (CartDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[CartDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withCartDetail:dictionary];
    
    cell._reloadDelegate = self;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 73.0;
    
}

-(void)getTableData{
    
    _tableData = [NSMutableArray array];
    
    FMDatabase *fmDatabase = [CartActionDetail getDb];
    
    [fmDatabase open];
    
    if ([fmDatabase open]) {
        
        NSString *queryStr = [NSString stringWithFormat:@"select * from cart"];
        
        FMResultSet *rs = [fmDatabase executeQuery:queryStr];
        
        while (rs.next) {
            
            NSString *id = [rs stringForColumn:@"id"];
            
            NSString *number = [rs stringForColumn:@"number"];
            
            NSString *title = [rs stringForColumn:@"title"];
            
            NSString *price = [rs stringForColumn:@"price"];
            
            NSString *pic = [rs stringForColumn:@"pic"];
            
            NSDictionary *dictionary = @{@"id":id,@"number":number,@"title":title,@"price":price,@"pic":pic};
            
            [_tableData addObject:dictionary];
        }
        
    }
    
    [fmDatabase close];

}

-(void)reloadCartDetail:(int)deleteResult{
    
    _deleteId = deleteResult;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"你确定将此物品删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [alertView show];
}

-(void)cutCartDetail:(int)number whith:(float)price{
    
    [_cartNumber setText:[NSString stringWithFormat:@"%i",[_cartNumber.text intValue]-number]];
    
    [_sumPriceValue setText:[NSString stringWithFormat:@"%.2f",[_sumPriceValue.text floatValue]-price]];

}

-(void)addCartDetail:(int)number whith:(float)price{
    
    [_cartNumber setText:[NSString stringWithFormat:@"%i",[_cartNumber.text intValue]+number]];
    
    [_sumPriceValue setText:[NSString stringWithFormat:@"%.2f",[_sumPriceValue.text floatValue]+price]];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        
        CartActionDetail *cartActionDetail = [[CartActionDetail alloc] init];
        
        FMDatabase *db = [CartActionDetail getDb];
        
        int i=[cartActionDetail deleteCartRow:db withId:_deleteId];
        
        if (i>0) {
            
            [self getTableData];
            
            [_tableView reloadData];
            
            int number=0;
            
            float price = 0.0f;
            
            for (NSDictionary *dictionary in _tableData) {
                
                number = number+[[dictionary objectForKey:@"number"] intValue];
                
                price = price+[[dictionary objectForKey:@"price"] floatValue]*[[dictionary objectForKey:@"number"] intValue];
                
            }
            
            [_cartNumber setText:[NSString stringWithFormat:@"%i",number]];
            
            [_sumPriceValue setText:[NSString stringWithFormat:@"%.2f",price]];
            
            [self showAlert:@"恭喜你删除物品成功！"];
            
        }else{
            
            [self showAlert:@"删除失败！"];
            
        }

    }
    
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
