//
//  CartActionDetail.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FMDB/FMDB.h>

@interface CartActionDetail : NSObject

+(FMDatabase *)getDb;

-(int)deleteCartRow:(FMDatabase *)db withId:(int)id;

-(int)insertCartRow:(FMDatabase *)db withDictionary:(NSDictionary *)dictionary;

@end
