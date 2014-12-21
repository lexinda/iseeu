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
    
    [path moveToPoint:CGPointMake(self.leftPoint.x, self.leftPoint.y)];
    
    //NSLog(@"%f,%f",self.leftPoint.x,self.leftPoint.y);
    
    float upControlX = self.upPoint.x * 2 - ((self.leftPoint.x + self.rightPoint.x) / 2);
    float upControlY = self.upPoint.y * 2 - ((self.leftPoint.y + self.rightPoint.y) / 2);
    
    [path addQuadCurveToPoint:CGPointMake(self.rightPoint.x, self.rightPoint.y) controlPoint:CGPointMake(upControlX, upControlY)];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(self.rightPoint.x, self.rightPoint.y)];
    
    float downControlX = self.downPoint.x * 2 - ((self.leftPoint.x + self.rightPoint.x) / 2);
    float downControlY = self.downPoint.y * 2 - ((self.leftPoint.y + self.rightPoint.y) / 2);

    
    [path1 addQuadCurveToPoint:CGPointMake(self.leftPoint.x, self.leftPoint.y) controlPoint:CGPointMake(downControlX, downControlY)];
    
    [path appendPath:path1];
    
    [path setLineWidth:1];
    
    [[UIColor greenColor] setFill];
    
    [path fill];
    
    [path stroke];
    
    [viewDelegate getPath:path];

}

@end
