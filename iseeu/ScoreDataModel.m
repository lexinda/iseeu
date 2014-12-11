//
//  ScoreDataModel.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/11.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ScoreDataModel.h"

@implementation ScoreDataModel

@synthesize id;

@synthesize fen;

@synthesize pic2;

@synthesize price_xiaoshou;

@synthesize title;

+(ScoreDataModel *)getScoreData:(NSDictionary *)dictionary{

    ScoreDataModel *scoreDataModel = [[ScoreDataModel alloc] init];
    
    [scoreDataModel setId:[dictionary objectForKey:@"id"]];
    
    [scoreDataModel setFen:[dictionary objectForKey:@"fen"]];
    
    [scoreDataModel setPic2:[dictionary objectForKey:@"pic2"]];
    
    [scoreDataModel setPrice_xiaoshou:[dictionary objectForKey:@"price_xiaoshou"]];
    
    [scoreDataModel setTitle:[dictionary objectForKey:@"title"]];
    
    return scoreDataModel;
    
}

@end
