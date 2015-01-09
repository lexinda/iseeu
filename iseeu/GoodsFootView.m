//
//  GoodsFootView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/19.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "GoodsFootView.h"

@implementation GoodsFootView

@synthesize _price;

@synthesize _goodsToCartDelegate;

-(void)drawRect:(CGRect)rect{
    
    UIImageView *getCartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    
    [getCartImageView setImage:[UIImage imageNamed:@"home_shopping"]];
    
    getCartImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPress)];
    
    [getCartImageView addGestureRecognizer:singleTap1];
    
    [self addSubview:getCartImageView];

    NSString *xiaoshouText = [NSString stringWithFormat:@"￥%@",_price];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
    
    CGSize xiaoshouTextSize = [xiaoshouText boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    UILabel *xiaoshou = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-xiaoshouTextSize.width-130.0, getCartImageView.frame.origin.y+17.0, xiaoshouTextSize.width, 20.0)];
    
    [xiaoshou setText:xiaoshouText];
    
    [xiaoshou setTextColor:[UIColor redColor]];
    
    [xiaoshou setFont:[UIFont systemFontOfSize:18]];
    
    [self addSubview:xiaoshou];
    
    UIButton *goShopping = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [goShopping setFrame:CGRectMake(xiaoshou.frame.origin.x+xiaoshou.frame.size.width, getCartImageView.frame.origin.y+7.0, 130.0, 40.0)];
    
    [goShopping setBackgroundImage:[UIImage imageNamed:@"iseeu_buynow"] forState:UIControlStateNormal];
    
    [self addSubview:goShopping];
    
}

-(void)buttonPress{
    
    [_goodsToCartDelegate pushCartView];

}

@end
