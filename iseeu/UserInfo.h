//
//  UserInfo.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(strong,nonatomic)NSString *sum_jifen;

@property(strong,nonatomic)NSString *tou;

@property(strong,nonatomic)NSString *username;

@property(strong,nonatomic)NSString *yi_jifen;

-(UserInfo *)getUserInfo:(NSDictionary *)dictionary;

@end
