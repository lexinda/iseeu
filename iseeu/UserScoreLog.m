//
//  UserScoreLog.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "UserScoreLog.h"

@implementation UserScoreLog

@synthesize fen;

@synthesize id;

@synthesize time;

@synthesize type;

@synthesize user_id;

-(UserScoreLog *)getUserScoreLog:(NSDictionary *)dictionary{

    UserScoreLog *userScoreLog = [[UserScoreLog alloc] init];
    
    [userScoreLog setFen:[dictionary objectForKey:@"fen"]];
    
    [userScoreLog setId:[dictionary objectForKey:@"id"]];
    
    [userScoreLog setTime:[dictionary objectForKey:@"time"]];
    
    [userScoreLog setType:[dictionary objectForKey:@"type"]];
    
    [userScoreLog setUser_id:[dictionary objectForKey:@"user_id"]];
    
    return userScoreLog;
    
}

@end
