//
//  HomeModel.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/15.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property(strong,nonatomic)NSString *id;

@property(strong,nonatomic)NSString *pic;

@property(strong,nonatomic)NSString *price_xiaoshou;

@property(strong,nonatomic)NSString *title;

+(HomeModel *)getHomeModel:(NSDictionary *)dictionary;

@end
