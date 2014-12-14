//
//  ScoreMarketTableViewCell.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/11.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"

#import "ScoreDataModel.h"

#import "ScoreCellModelDelegate.h"

@interface ScoreMarketTableViewCell : UITableViewCell

@property(strong,nonatomic)id<ScoreCellModelDelegate> _scoreCellDelegate;

@property(strong,nonatomic)ScoreDataModel *_scoreDataModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withScoreData:(ScoreDataModel *)scoreDataModel;

@end
