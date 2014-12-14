//
//  EyeView.m
//  isue
//
//  Created by 朱孟乐 on 14/11/3.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeView.h"

@implementation EyeView

@synthesize centerPoint;

@synthesize upPoint;

@synthesize rightPoint;

@synthesize downPoint;

@synthesize leftPoint;

@synthesize viewDelegate;

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:self.leftPoint];
    
    //NSLog(@"%f,%f",self.leftPoint.x,self.leftPoint.y);
    
    [path addQuadCurveToPoint:self.rightPoint controlPoint:self.upPoint];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:self.rightPoint];
    
    [path1 addQuadCurveToPoint:self.leftPoint controlPoint:self.downPoint];
    
    [path appendPath:path1];
    
    [path setLineWidth:1];
    
    [path stroke];
    
    [viewDelegate getPath:path];

}

@end
