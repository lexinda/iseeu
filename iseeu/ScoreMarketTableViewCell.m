//
//  ScoreMarketTableViewCell.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/11.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreMarketTableViewCell.h"

@implementation ScoreMarketTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withScoreData:(ScoreDataModel *)scoreDataModel{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-200)/2, 0.0, 200.0, 120.0)];
        
        NSURL *picUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,scoreDataModel.pic2]];
        
        [imageView sd_setImageWithURL:picUrl];
        
        [self addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10.0, imageView.frame.size.height, self.frame.size.width, 20.0)];
        
        [title setText:scoreDataModel.title];
        
        [self addSubview:title];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, title.frame.origin.y+title.frame.size.height, 85.0, 20.0)];
        
        [scoreLabel setText:@"需耗积分："];
        
        [self addSubview:scoreLabel];
        
        UILabel *scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreLabel.frame.origin.x+scoreLabel.frame.size.width, scoreLabel.frame.origin.y, self.frame.size.width-10.0-10.0-scoreLabel.frame.size.width-40.0, 20.0)];
        
        [scoreValueLabel setTextColor:[UIColor redColor]];
        
        [scoreValueLabel setText:scoreDataModel.fen];
        
        [self addSubview:scoreValueLabel];
        
        UIButton *convertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [convertButton setFrame:CGRectMake(self.frame.size.width-40.0-10.0, scoreLabel.frame.origin.y-5.0, 40.0, 40.0)];
        
        [convertButton setBackgroundImage:[UIImage imageNamed:@"integralshopping"] forState:UIControlStateNormal];
        
        [self addSubview:convertButton];
        
    }
    
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
