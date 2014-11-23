//
//  RightViewModel.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/23.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "RightViewModel.h"

@implementation RightViewModel

@synthesize id;

@synthesize name;

+(RightViewModel *)getRightViewModel:(NSDictionary *)dictionary{

    RightViewModel *rightViewModel = [[RightViewModel alloc] init];
    
    [rightViewModel setId:[dictionary objectForKey:@"id"]];
    
    [rightViewModel setName:[dictionary objectForKey:@"name"]];
    
    return rightViewModel;
    
}

@end
