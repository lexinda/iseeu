//
//  ScoreDetailTableCell.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreDetailTableCell.h"

@implementation ScoreDetailTableCell

@synthesize _numberField;

@synthesize _priceLabel;

@synthesize _data;

@synthesize _addButton;

@synthesize _cutButton;

@synthesize _titleLabel;

@synthesize _scoreDetailDelegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCartDetail:(NSDictionary *)dictionary{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        
        
    }
    
    return self;
    
}

-(void)cutTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    if ([text intValue]>1) {
        
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]-1]];
        
        NSString *price = _priceLabel.text;
        
        NSString *priceValue = [_data objectForKey:@"fen"];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%.2lf",[price floatValue]-[priceValue floatValue]]];
        
        [_scoreDetailDelegate cutScoreDetail:1 whith:[priceValue intValue]];
        
    }else{
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]]];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"fen"]]];
        
    }
    
}

-(void)addTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]+1]];
    
    NSString *price = _priceLabel.text;
    
    NSString *priceValue = [_data objectForKey:@"fen"];
    
    NSLog(@"%i,%i,%i",[price intValue],[priceValue intValue],[price intValue]+[priceValue intValue]);
    
    [_priceLabel setText:[NSString stringWithFormat:@"%i",[price intValue]+[priceValue intValue]]];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    NSString *priceStr = [NSString stringWithFormat:@"%i",[price intValue]+[priceValue intValue]];
    
    CGSize textSize = [priceStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [_priceLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10.0, textSize.width, _priceLabel.frame.size.height)];
    
    [_cutButton setFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width, _priceLabel.frame.origin.y, 20.0, 20.0)];
    
    [_numberField setFrame:CGRectMake(_cutButton.frame.origin.x+_cutButton.frame.size.width+2, _cutButton.frame.origin.y, 30.0, 20.0)];
    
    [_addButton setFrame:CGRectMake(_numberField.frame.origin.x+_numberField.frame.size.width+2, _numberField.frame.origin.y, 20.0, 20.0)];
    
    [_scoreDetailDelegate addScoreDetail:1 whith:[priceValue intValue]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
