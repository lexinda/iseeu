//
//  EyeCircleView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/17.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeCircleView.h"

#import <QuartzCore/QuartzCore.h>

@implementation EyeCircleView

@synthesize centerPoint;

@synthesize radius;

-(void)drawRect:(CGRect)rect{

     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:180 clockwise:YES];
    
    [path setLineWidth:1];
    
    [[UIColor blueColor] setFill];
    
    [path fill];
    
    [path stroke];
    
}

@end
