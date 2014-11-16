//
//  HomeModel.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/15.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

@synthesize id;

@synthesize pic;

@synthesize price_xiaoshou;

@synthesize title;

+(HomeModel *)getHomeModel:(NSDictionary *)dictionary{

    HomeModel *homeModel = [[HomeModel alloc] init];
    
    [homeModel setId:[dictionary objectForKey:@"id"]];
    
    [homeModel setPic:[dictionary objectForKey:@"pic"]];
    
    [homeModel setPrice_xiaoshou:[dictionary objectForKey:@"price_xiaoshou"]];
    
    [homeModel setTitle:[dictionary objectForKey:@"title"]];
    
    return homeModel;
    
}

@end
