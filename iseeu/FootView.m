//
//  FootView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/13.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "FootView.h"

@implementation FootView

@synthesize viewDelegate;

-(void)drawRect:(CGRect)rect{

    NSNumber *width = [NSNumber numberWithFloat:rect.size.width/5];
    
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [oneButton setFrame:CGRectMake(0.0, 0.0, [width floatValue], rect.size.height)];
    
    [oneButton setBackgroundImage:[UIImage imageNamed:@"bar_home_selected"] forState:UIControlStateNormal];
    
    [oneButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    [oneButton setTag:0];
    
    [self addSubview:oneButton];
    
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [twoButton setFrame:CGRectMake(oneButton.frame.origin.x+oneButton.frame.size.width, 0.0, [width floatValue], rect.size.height)];
    
    [twoButton setBackgroundImage:[UIImage imageNamed:@"bar_try_normal"] forState:UIControlStateNormal];
    
    [twoButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    [twoButton setTag:1];
    
    [self addSubview:twoButton];
    
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [threeButton setFrame:CGRectMake(twoButton.frame.origin.x+twoButton.frame.size.width, 0.0, [width floatValue], rect.size.height)];
    
    [threeButton setBackgroundImage:[UIImage imageNamed:@"bar_integralshopping_normal"] forState:UIControlStateNormal];
    
    [threeButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    [threeButton setTag:2];
    
    [self addSubview:threeButton];
    
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [fourButton setFrame:CGRectMake(threeButton.frame.origin.x+threeButton.frame.size.width, 0.0, [width floatValue], rect.size.height)];
    
    [fourButton setBackgroundImage:[UIImage imageNamed:@"bar_shopping_normal"] forState:UIControlStateNormal];
    
    [fourButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    [fourButton setTag:3];
    
    [self addSubview:fourButton];
    
    UIButton *fiveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [fiveButton setFrame:CGRectMake(fourButton.frame.origin.x+fourButton.frame.size.width, 0.0, [width floatValue], rect.size.height)];
    
    [fiveButton setBackgroundImage:[UIImage imageNamed:@"bar_personal_normal"] forState:UIControlStateNormal];
    
    [fiveButton addTarget:self action:@selector(pushView:) forControlEvents:UIControlEventTouchUpInside];
    
    [fiveButton setTag:4];
    
    [self addSubview:fiveButton];
    
}

-(void)pushView:(id)sender{

    UIButton *button = (UIButton *)sender;
    
    [viewDelegate pushViewController:(int)button.tag];
    
}

@end
