//
//  EyeView.m
//  isue
//
//  Created by 朱孟乐 on 14/11/3.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeView.h"

#import <QuartzCore/QuartzCore.h>

@implementation EyeView

@synthesize centerPoint;

@synthesize upPoint;

@synthesize rightPoint;

@synthesize downPoint;

@synthesize leftPoint;

@synthesize viewDelegate;

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(self.leftPoint.x+10.0, self.leftPoint.y)];
    
    //NSLog(@"%f,%f",self.leftPoint.x,self.leftPoint.y);
    
    [path addQuadCurveToPoint:CGPointMake(self.rightPoint.x-10.0, self.rightPoint.y) controlPoint:self.upPoint];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(self.rightPoint.x-10.0, self.rightPoint.y)];
    
    [path1 addQuadCurveToPoint:CGPointMake(self.leftPoint.x+10.0, self.leftPoint.y) controlPoint:self.downPoint];
    
    [path appendPath:path1];
    
    [path setLineWidth:1];
    
    [[UIColor greenColor] setFill];
    
    [path fill];
    
    [path stroke];
    
    [viewDelegate getPath:path];

}

@end
