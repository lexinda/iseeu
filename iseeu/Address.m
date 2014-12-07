//
//  Address.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "Address.h"

@implementation Address

@synthesize id;

@synthesize name;

@synthesize parentId;

-(Address *)getAddress:(NSString *)cantCode withName:(NSString *)cantName withParentId:(NSString *)superCode{
    Address *address = [[Address alloc] init];
    
    [address setId:cantCode];
    
    [address setName:cantName];
    
    [address setParentId:superCode];
    
    return address;
}

@end
