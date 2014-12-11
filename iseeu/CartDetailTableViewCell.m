//
//  CartDetailTableViewCell.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "CartDetailTableViewCell.h"

@implementation CartDetailTableViewCell

@synthesize _numberField;

@synthesize _priceLabel;

@synthesize _data;

@synthesize _addButton;

@synthesize _cutButton;

@synthesize _titleLabel;

@synthesize _reloadDelegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCartDetail:(NSDictionary *)dictionary{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        _data = dictionary;
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15.0, 5.0, 80.0, 60.0)];
        
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_URL,[dictionary objectForKey:@"pic"]]];
        
        [picImageView sd_setImageWithURL:imageUrl];
        
        [self addSubview:picImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.frame.origin.x+picImageView.frame.size.width+10.0, picImageView.frame.origin.y+5.0, self.frame.size.width-30.0-picImageView.frame.origin.x-picImageView.frame.size.width, 20.0)];
        
        [_titleLabel setText:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"title"]]];
        
        [self addSubview:_titleLabel];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
        
        NSString *priceStr = [dictionary objectForKey:@"price"];
        
        NSString *numberStr = [dictionary objectForKey:@"number"];
        
        NSString *priceValueStr = [NSString stringWithFormat:@"%.2f",[priceStr floatValue]*[numberStr intValue]];
        
        CGSize textSize = [priceValueStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10.0, textSize.width, 20.0)];
        
        [_priceLabel setFont:[UIFont systemFontOfSize:15]];
        
        [_priceLabel setTextColor:[UIColor redColor]];
        
        [_priceLabel setText:priceValueStr];
        
        [self addSubview:_priceLabel];
        
        _cutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [_cutButton setFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width, _priceLabel.frame.origin.y, 20.0, 20.0)];
        
        [_cutButton addTarget:self action:@selector(cutTextValue) forControlEvents:UIControlEventTouchUpInside];
        
        [_cutButton setBackgroundImage:[UIImage imageNamed:@"shopping_cut"] forState:UIControlStateNormal];
        
        [_cutButton setBackgroundImage:[UIImage imageNamed:@"shopping_cut1"] forState:UIControlStateSelected];
        
        [self addSubview:_cutButton];
        
        _numberField = [[UITextField alloc] initWithFrame:CGRectMake(_cutButton.frame.origin.x+_cutButton.frame.size.width+2, _cutButton.frame.origin.y, 30.0, 20.0)];
        
        _numberField.text = numberStr;
        
        _numberField.textAlignment = NSTextAlignmentCenter;
        
        [_numberField setBackground:[UIImage imageNamed:@"shopping_et"]];
        
        [_numberField setEnabled:NO];
        
        [self addSubview:_numberField];
        
        _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [_addButton setFrame:CGRectMake(_numberField.frame.origin.x+_numberField.frame.size.width+2, _numberField.frame.origin.y, 20.0, 20.0)];
        
        [_addButton addTarget:self action:@selector(addTextValue) forControlEvents:UIControlEventTouchUpInside];
        
        [_addButton setBackgroundImage:[UIImage imageNamed:@"shopping_add"] forState:UIControlStateNormal];
        
        [_addButton setBackgroundImage:[UIImage imageNamed:@"shopping_add1"] forState:UIControlStateSelected];
        
        [self addSubview:_addButton];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        NSString *id = [dictionary objectForKey:@"id"];
        
        [deleteButton setTag:[id intValue]];
        
        [deleteButton setFrame:CGRectMake(self.frame.size.width-30.0, _addButton.frame.origin.y-15.0,25.0, 25.0)];
        
        [deleteButton addTarget:self action:@selector(deleteCartRow:) forControlEvents:UIControlEventTouchUpInside];
        
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"shoppingcar_delete"] forState:UIControlStateNormal];
        
        [self addSubview:deleteButton];
    
    }
    
    return self;
    
}

-(void)cutTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    if ([text intValue]>1) {
        
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]-1]];
        
        NSString *price = _priceLabel.text;
        
        NSString *priceValue = [_data objectForKey:@"price"];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%.2lf",[price floatValue]-[priceValue floatValue]]];
        
        [_reloadDelegate cutCartDetail:1 whith:[priceValue floatValue]];
        
    }else{
        [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]]];
        
        [_priceLabel setText:[NSString stringWithFormat:@"%@",[_data objectForKey:@"price"]]];
        
    }

}

-(void)addTextValue{
    
    NSString *text = [NSString stringWithFormat:@"%@",_numberField.text];
    
    [_numberField setText:[NSString stringWithFormat:@"%i",[text intValue]+1]];
    
    NSString *price = _priceLabel.text;
    
    NSString *priceValue = [_data objectForKey:@"price"];
    
    NSLog(@"%f,%f,%f",[price floatValue],[priceValue floatValue],[price floatValue]+[priceValue floatValue]);
    
    [_priceLabel setText:[NSString stringWithFormat:@"%.2lf",[price floatValue]+[priceValue floatValue]]];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    NSString *priceStr = [NSString stringWithFormat:@"%.2lf",[price floatValue]+[priceValue floatValue]];
    
    CGSize textSize = [priceStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [_priceLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+10.0, textSize.width, _priceLabel.frame.size.height)];
    
    [_cutButton setFrame:CGRectMake(_priceLabel.frame.origin.x+_priceLabel.frame.size.width, _priceLabel.frame.origin.y, 20.0, 20.0)];
    
    [_numberField setFrame:CGRectMake(_cutButton.frame.origin.x+_cutButton.frame.size.width+2, _cutButton.frame.origin.y, 30.0, 20.0)];
    
    [_addButton setFrame:CGRectMake(_numberField.frame.origin.x+_numberField.frame.size.width+2, _numberField.frame.origin.y, 20.0, 20.0)];
    
    [_reloadDelegate addCartDetail:1 whith:[priceValue floatValue]];

    
}

-(void)deleteCartRow:(id)sender{
    
    UIButton *button = (UIButton *)sender;
        
    [_reloadDelegate reloadCartDetail:(int)button.tag];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
