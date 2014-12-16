//
//  SideViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/22.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "SideViewController.h"

#import "MFSideMenu.h"

@implementation SideViewController

@synthesize _contentView;

@synthesize _width;

@synthesize _hud;

-(void)viewDidLoad{
    
    CGFloat viewWidth = self.view.frame.size.width-80.0;

    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#383b42"]];
    
    _width = (viewWidth-20.0)/3;
    
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [oneButton setTitle:@"美瞳" forState:UIControlStateNormal];
    
    [oneButton setBackgroundColor:[UIColor colorWithHexString:@"#f7afba"]];
    
    [oneButton setFrame:CGRectMake(85.0, 30.0, _width, 30.0)];
    
    [oneButton setTag:900];
    
    [oneButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:oneButton];
    
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [twoButton setTitle:@"隐形" forState:UIControlStateNormal];
    
    [twoButton setBackgroundColor:[UIColor colorWithHexString:@"#22252d"]];
    
    [twoButton setFrame:CGRectMake(oneButton.frame.origin.x+oneButton.frame.size.width, 30.0, _width, 30.0)];
    
    [twoButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [twoButton setTag:901];
    
    [self.view addSubview:twoButton];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [threeButton setTitle:@"护理产品" forState:UIControlStateNormal];
    
    [threeButton setBackgroundColor:[UIColor colorWithHexString:@"#22252d"]];
    
    [threeButton setFrame:CGRectMake(twoButton.frame.origin.x+twoButton.frame.size.width, 30.0, _width, 30.0)];
    
    [threeButton addTarget:self action:@selector(pushContentView:) forControlEvents:UIControlEventTouchUpInside];
    
    [threeButton setTag:902];
    
    [self.view addSubview:threeButton];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(oneButton.frame.origin.x, oneButton.frame.origin.y+oneButton.frame.size.height, _width*3, self.view.frame.size.height-oneButton.frame.origin.y-oneButton.frame.size.height)];
    
    [_contentView setBackgroundColor:[UIColor clearColor]];
    
    _contentView.delegate = self;
    
    _contentView.pagingEnabled = YES;
    
    [_contentView setContentSize:CGSizeMake(_width*3*3, _contentView.frame.size.height)];
    
    [self.view addSubview:_contentView];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    
    _hud.delegate = self;
    
    _hud.labelText=@"加载中...";
    
    [_hud show:YES];
    
    [self.view addSubview:_hud];
    
    [self pushTableContentView];
    
}

-(void)pushTableContentView{
    
    NSString *meitongUrl = [NSString stringWithFormat:@"%@/index.php/yiyi/yanse",SERVER_URL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:meitongUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *meitongString = [self getResponseStr:responseObject];
        
        NSLog(@"%@",meitongString);
        
        NSData *meitongData = [meitongString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *meitongDictionary = [NSJSONSerialization JSONObjectWithData:meitongData options:0 error:nil];
        
        NSArray *meitongArray = [meitongDictionary objectForKey:@"xin"];
        
        NSMutableArray *meitongTableArray = [NSMutableArray array];
        
        for (int i=0; i<meitongArray.count; i++) {
            
            RightViewModel *rightViewModel = [RightViewModel getRightViewModel:[meitongArray objectAtIndex:i]];
            
            [meitongTableArray addObject:rightViewModel];
        }
        
        NSLog(@"%@", meitongDictionary);
        
        NSString *pinpaiUrl = [NSString stringWithFormat:@"%@/index.php/yiyi/brand",SERVER_URL];
        
        [manager GET:pinpaiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSString *pinpaiString = [self getResponseStr:responseObject];
            
            NSLog(@"%@",pinpaiString);
            
            NSData *pinpaiData = [pinpaiString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *pinpaiDictionary = [NSJSONSerialization JSONObjectWithData:pinpaiData options:0 error:nil];
            
            NSLog(@"%@", pinpaiDictionary);
            
            NSArray *pinpaiArray = [pinpaiDictionary objectForKey:@"xin"];
            
            NSMutableArray *pinpaiTableArray = [NSMutableArray array];
            
            for (int i=0; i<pinpaiArray.count; i++) {
                
                RightViewModel *rightViewModel = [RightViewModel getRightViewModel:[pinpaiArray objectAtIndex:i]];
                
                [pinpaiTableArray addObject:rightViewModel];
            }
            
            NSString *huliUrl = [NSString stringWithFormat:@"%@/index.php/yiyi/huli",SERVER_URL];
            
            [manager GET:huliUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *huliString = [self getResponseStr:responseObject];
                
                NSLog(@"%@",huliString);
                
                NSData *huliData = [huliString dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *huliDictionary = [NSJSONSerialization JSONObjectWithData:huliData options:0 error:nil];
                
                NSLog(@"%@", huliDictionary);
                
                NSArray *huliArray = [huliDictionary objectForKey:@"xin"];
                
                NSMutableArray *huliTableArray = [NSMutableArray array];
                
                for (int i=0; i<huliArray.count; i++) {
                    
                    RightViewModel *rightViewModel = [RightViewModel getRightViewModel:[huliArray objectAtIndex:i]];
                    
                    [huliTableArray addObject:rightViewModel];
                }
                
                
                CGFloat x=0.0;
                
                for (int i=0; i<3; i++) {
                    
                    DetailTableView *view = [[DetailTableView alloc] initWithFrame:CGRectMake(x, 0.0, _width*3, _contentView.frame.size.height)];
                    
                    view.homeDelegate = self;
                    
                    if (i==0) {
                        
                        view.tag = 70;
                        
                        [view setBackgroundColor:[UIColor redColor]];
                        
                        [view setFakeData:meitongTableArray];
                        
                    }else if (i==1) {
                        
                        view.tag = 71;
                        
                        [view setBackgroundColor:[UIColor greenColor]];
                        
                        [view setFakeData:pinpaiTableArray];
                        
                    }else if (i==2) {
                        
                        view.tag = 72;
                        
                        [view setBackgroundColor:[UIColor blueColor]];
                        
                        [view setFakeData:huliTableArray];
                        
                    }
                    
                    [_contentView addSubview:view];
                    
                    x+=_width*3;
                }
                
                [_hud hide:YES];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"加载护理失败！");
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载品牌失败！");
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加载美瞳失败！");
    }];
    
}

-(void)pushContentView:(id)sender{
    
    UIButton *button = (UIButton *)sender;

    NSLog(@"%li",(long)button.tag);
    
    UIButton *oneButton = (UIButton *)[self.view viewWithTag:900];
    
    [oneButton setBackgroundColor:[UIColor colorWithHexString:@"#22252d"]];
    
    UIButton *twoButton = (UIButton *)[self.view viewWithTag:901];
    
    [twoButton setBackgroundColor:[UIColor colorWithHexString:@"#22252d"]];
    
    UIButton *threeButton = (UIButton *)[self.view viewWithTag:902];
    
    [threeButton setBackgroundColor:[UIColor colorWithHexString:@"#22252d"]];
    
    switch (button.tag) {
        case 900:
            [_contentView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
            [oneButton setBackgroundColor:[UIColor colorWithHexString:@"#f7afba"]];
            break;
        case 901:
            [_contentView setContentOffset:CGPointMake(_width*3, 0.0) animated:YES];
            [twoButton setBackgroundColor:[UIColor colorWithHexString:@"#f7afba"]];
            break;
        case 902:
            [_contentView setContentOffset:CGPointMake(_width*3*2, 0.0) animated:YES];
            [threeButton setBackgroundColor:[UIColor colorWithHexString:@"#f7afba"]];
            break;
            
        default:
            break;
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int i =scrollView.contentOffset.x/250;
    
     NSLog(@"%i",i);
    
    UIButton *oneButton = (UIButton *)[self.view viewWithTag:900];
    
    [oneButton setBackgroundColor:[UIColor blackColor]];
    
    UIButton *twoButton = (UIButton *)[self.view viewWithTag:901];
    
    [twoButton setBackgroundColor:[UIColor blackColor]];
    
    UIButton *threeButton = (UIButton *)[self.view viewWithTag:902];
    
    [threeButton setBackgroundColor:[UIColor blackColor]];
    
    switch (i) {
        case 0:
            [oneButton setBackgroundColor:[UIColor whiteColor]];
            break;
        case 1:
            [twoButton setBackgroundColor:[UIColor whiteColor]];
            break;
        case 2:
            [threeButton setBackgroundColor:[UIColor whiteColor]];
            break;
            
        default:
            break;
    }
    
}

-(NSMutableString*)getResponseStr:(NSData*)data{
    
    NSMutableString *responseString = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSString *indexStr = @"\"response\":\"home\",\"name\":";
    
    NSRange range = [responseString rangeOfString:indexStr];
    
    NSLog(@"%lu",(unsigned long)responseString.length);
    
    int location = (int)range.location+(int)indexStr.length;
    
    [responseString insertString:@"\"" atIndex:location];
    
    [responseString insertString:@"\"" atIndex:responseString.length-1];
    
    return responseString;

}

-(void)hudWasHidden:(MBProgressHUD *)hud{

    [_hud removeFromSuperview];
    
    _hud = nil;
    
}

-(void)pushClassificationViewController:(int)tag withSid:(int)sid{

    NSLog(@"%i,%i",tag,sid);
    
    ClassificationViewController *classificationViewController = [[ClassificationViewController alloc] init];
    
    classificationViewController._type = tag;
    
    classificationViewController._sid = sid;
    
    UINavigationController *classificationNavi = [[UINavigationController alloc] initWithRootViewController:classificationViewController];
    
//    classificationNavi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
//    [self presentViewController:classificationNavi animated:YES completion:^{
//        NSLog(@"载入试图！");
//    }];
    
    [self.revealSideViewController popViewControllerWithNewCenterController:classificationNavi animated:YES];
    
    PP_RELEASE(classificationViewController);
    
    PP_RELEASE(classificationNavi);
    

    
}

@end
