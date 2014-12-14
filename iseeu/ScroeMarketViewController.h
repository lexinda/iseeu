//
//  ScroeMarketViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/10.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BannerView.h"

#import <AFNetworking/AFNetworking.h>

#import <MBProgressHUD/MBProgressHUD.h>

#import "HomeModel.h"

#import "ScoreMarketTableView.h"

#import "ScoreDataModel.h"

#import "ScoreDetailViewController.h"

@interface ScroeMarketViewController : UIViewController<MBProgressHUDDelegate,ScoreMarketDelegate>

@property(strong,nonatomic)BannerView *_bannerView;

@property(strong,nonatomic)MBProgressHUD *_hud;



@end
