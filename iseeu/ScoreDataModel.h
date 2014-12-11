//
//  ScoreDataModel.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/11.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreDataModel : NSObject

@property(strong,nonatomic)NSString *id;

@property(strong,nonatomic)NSString *fen;

@property(strong,nonatomic)NSString *pic2;

@property(strong,nonatomic)NSString *price_xiaoshou;

@property(strong,nonatomic)NSString *title;

+(ScoreDataModel *)getScoreData:(NSDictionary *)dictionary;

@end
