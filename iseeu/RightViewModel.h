//
//  RightViewModel.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/23.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RightViewModel : NSObject

@property(strong,nonatomic)NSString *id;

@property(strong,nonatomic)NSString *name;

+(RightViewModel *)getRightViewModel:(NSDictionary *)dictionary;

@end
