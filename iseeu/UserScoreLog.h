//
//  UserScoreLog.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserScoreLog : NSObject

@property(strong,nonatomic)NSString *fen;

@property(strong,nonatomic)NSString *id;

@property(strong,nonatomic)NSString *time;

@property(strong,nonatomic)NSString *type;

@property(strong,nonatomic)NSString *user_id;

-(UserScoreLog *)getUserScoreLog:(NSDictionary *)dictionary;

@end
