//
//  HomeDelegate.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/17.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeDelegate <NSObject>

-(void)pushGoodsDetail:(NSNumber *)sid;

-(void)pushClassificationViewController:(int)tag withSid:(int)sid;

@end
