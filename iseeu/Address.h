//
//  Address.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property(strong,nonatomic)NSString *id;

@property(strong,nonatomic)NSString *name;

@property(strong,nonatomic)NSString *parentId;

-(Address *)getAddress:(NSString *)cantCode withName:(NSString *)cantName withParentId:(NSString *)superCode;

@end
