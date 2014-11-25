//
//  ClassificationModel.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ClassificationModel.h"

@implementation ClassificationModel

@synthesize id;

@synthesize pic2;

@synthesize price_xiaoshou;

@synthesize ren;

@synthesize title;

+(ClassificationModel *)getClassification:(NSDictionary *)dictionary{

    ClassificationModel *classificationModel = [[ClassificationModel alloc] init];
    
    [classificationModel setId:[[dictionary objectForKey:@"id"] intValue]];
    
    [classificationModel setPic2:[dictionary objectForKey:@"pic2"]];
    
    [classificationModel setPrice_xiaoshou:[dictionary objectForKey:@"price_xiaoshou"]];
    
    [classificationModel setRen:[[dictionary objectForKey:@"ren"] intValue]];
    
    [classificationModel setTitle:[dictionary objectForKey:@"title"]];
    
    return classificationModel;
    
}

@end
