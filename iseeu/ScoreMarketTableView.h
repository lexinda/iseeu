//
//  ScoreMarketTableView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/11.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIColor+Color.h"

#import <AFNetworking/AFNetworking.h>

#import "ScoreDataModel.h"

#import "ScoreMarketTableViewCell.h"

@interface ScoreMarketTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *_tableView;

@property (strong, nonatomic) NSMutableArray *fakeData;

@property(nonatomic)int _scorePage;

@end
