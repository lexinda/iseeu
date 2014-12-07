//
//  UserInfo.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

@synthesize sum_jifen;

@synthesize tou;

@synthesize username;

@synthesize yi_jifen;

-(UserInfo *)getUserInfo:(NSDictionary *)dictionary{

    UserInfo *userInfo = [[UserInfo alloc] init];
    
    [userInfo setSum_jifen:[dictionary objectForKey:@"sum_jifen"]];
    
    [userInfo setTou:[dictionary objectForKey:@"tou"]];
    
    [userInfo setUsername:[dictionary objectForKey:@"username"]];
    
    [userInfo setYi_jifen:[dictionary objectForKey:@"yi_jifen"]];
    
    return  userInfo;
    
}

@end
