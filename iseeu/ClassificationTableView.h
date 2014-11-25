//
//  ClassificationTableView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import "RightViewModel.h"

#import "HomeDelegate.h"

#import "ClassificationTableCell.h"

#import <AFNetworking/AFNetworking.h>

@interface ClassificationTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *_tableView;

@property(nonatomic)int *_type;

@property(strong,nonatomic)NSString *_classification;

/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeData;

@property(nonatomic)BOOL isActive;

@property(strong,nonatomic)id<HomeDelegate> homeDelegate;

@property(nonatomic)int _yansePage;

@property(nonatomic)int _pinpaiPage;

@property(nonatomic)int _huliPage;

@end
