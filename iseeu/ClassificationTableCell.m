//
//  ClassificationTableCell.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ClassificationTableCell.h"

@implementation ClassificationTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(ClassificationModel *)_classificationModel{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, 3.0, 100.0, 60.0)];
        
        NSLog(@"%@",_classificationModel.title);
        
        NSString *image = [NSString stringWithFormat:@"%@%@",SERVER_URL,_classificationModel.pic2];
        
        NSURL *imageUrl = [NSURL URLWithString:image];
        
        [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",_classificationModel.pic2]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"");
        }];
        
        [self addSubview:imageView];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width, imageView.frame.origin.y, self.frame.size.width-imageView.frame.size.width-10.0, 20.0)];
        
        [topLabel setText:[NSString stringWithFormat:@"%@",_classificationModel.title]];
        
        [self addSubview:topLabel];
        
        UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [cartButton setFrame:CGRectMake(self.frame.size.width-10.0-30.0, imageView.frame.origin.y+5, 30.0, 30.0)];
        
        [cartButton setBackgroundImage:[UIImage imageNamed:@"home_shopping"] forState:UIControlStateNormal];
        
        [self addSubview:cartButton];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, topLabel.frame.origin.y+topLabel.frame.size.height, topLabel.frame.size.width-cartButton.frame.size.width, 20.0)];
        
        [priceLabel setText:[NSString stringWithFormat:@"%@",_classificationModel.price_xiaoshou]];
        
        [self addSubview:priceLabel];
        
        UILabel *renLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, priceLabel.frame.origin.y+priceLabel.frame.size.height, topLabel.frame.size.width-cartButton.frame.size.width, 20.0)];
        
        [renLabel setText:[NSString stringWithFormat:@"%i人已经购买",_classificationModel.ren]];
        
        [self addSubview:renLabel];
        
        
    }
    
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
