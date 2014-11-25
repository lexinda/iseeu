//
//  ClassificationTableView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ClassificationTableView.h"

#import "MJRefresh.h"

@implementation ClassificationTableView

@synthesize _tableView;

@synthesize _classification;

@synthesize _type;

@synthesize isActive;

@synthesize homeDelegate;

@synthesize _yansePage;

@synthesize _pinpaiPage;

@synthesize _huliPage;

@synthesize fakeData;

-(void)drawRect:(CGRect)rect{
    
    _yansePage = 1;
    
    _pinpaiPage = 1;
    
    _huliPage = 1;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
    
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#383b42"];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSLog(@"%i",self.tag);
    
    [self addSubview:_tableView];
    
    // 2.集成刷新控件
    if (isActive) {
        [self setupRefresh];
    }
    
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    [_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
    
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    NSString *url = @"";
    
    //[self.fakeData removeAllObjects];
    
    if (*_type ==70) {
        _yansePage = 1;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong5",SERVER_URL];
        }
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_yansePage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView headerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
        
        
        
    }else if(*_type == 71){
        _pinpaiPage = 1;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing5",SERVER_URL];
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_pinpaiPage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView headerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
    }else if(*_type == 72){
        _huliPage = 1;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli5",SERVER_URL];
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_huliPage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView headerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
    }else{
    
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [_tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView headerEndRefreshing];
        });
        
    }
}

- (void)footerRereshing
{
    
    NSString *url = @"";
    if (*_type ==70) {
        _yansePage++;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/meitong5",SERVER_URL];
        }
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_yansePage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView footerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
        
    }else if(*_type == 71){
        _pinpaiPage++;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/yinxing5",SERVER_URL];
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_pinpaiPage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView footerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
    }else if(*_type == 72){
        _huliPage++;
        if ([_classification isEqualToString:@"new"]) {
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli2",SERVER_URL];
        }else if([_classification isEqualToString:@"hot"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli3",SERVER_URL];
        }else if([_classification isEqualToString:@"conal"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli4",SERVER_URL];
        }else if([_classification isEqualToString:@"price"]){
            url = [NSString stringWithFormat:@"%@/index.php/yiyi/huli5",SERVER_URL];
        }
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *parameters = @{@"page":[NSNumber numberWithInt:_huliPage]};
        
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *data = [dictionary objectForKey:@"xin"];
            
            if (data.count>0) {
                
                for (int i=0; i<data.count; i++) {
                    
                    ClassificationModel *classificationModel = [ClassificationModel getClassification:[data objectAtIndex:i]];
                    
                    [self.fakeData addObject:classificationModel];
                }
            }
            
            // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 刷新表格
                [_tableView reloadData];
                
                // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
                [_tableView footerEndRefreshing];
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"加载数据失败！");
        }];
    }else{
    
        // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [_tableView reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [_tableView footerEndRefreshing];
        });
        
    }
}

#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fakeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    
    ClassificationModel *classificationModel = (ClassificationModel *)self.fakeData[indexPath.row];
    
    ClassificationTableCell *cell = (ClassificationTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[ClassificationTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier withModel:classificationModel];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RightViewModel *rightViewModel = (RightViewModel *)self.fakeData[indexPath.row];
    
    [homeDelegate pushClassificationViewController:self.tag withSid:[rightViewModel.id intValue]];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70.0;
    
}

@end
