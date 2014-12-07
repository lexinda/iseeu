//
//  ScoreTableView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withUserScoreLog:(UserScoreLog *)userScoreLog{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, self.frame.size.width-20.0, 20.0)];
        
        [oneLabel setText:userScoreLog.time];
        
        [oneLabel setTextColor:[UIColor redColor]];
        
        [self addSubview:oneLabel];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, oneLabel.frame.origin.y+oneLabel.frame.size.height, self.frame.size.width-20.0, 20.0)];
        
        [typeLabel setText:[NSString stringWithFormat:@"恭喜您签到成功获取%@积分",userScoreLog.fen]];
        
        [typeLabel setTextColor:[UIColor blackColor]];
        
        [self addSubview:typeLabel];
        
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
