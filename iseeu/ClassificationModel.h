//
//  ClassificationModel.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassificationModel : NSObject

@property(nonatomic)int id;

@property(strong,nonatomic)NSString *pic2;

@property(nonatomic)int ren;

@property(strong,nonatomic)NSString *title;

@property(strong,nonatomic)NSString *price_xiaoshou;

+(ClassificationModel *)getClassification:(NSDictionary *)dictionary;

@end
