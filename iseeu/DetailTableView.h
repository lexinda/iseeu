//
//  DetailTableView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/23.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import "RightViewModel.h"

@interface DetailTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;

/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeData;

@property(nonatomic)BOOL isActive;

@end
