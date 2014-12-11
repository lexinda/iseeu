//
//  DeleteReloadCartDetail.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeleteReloadCartDetail <NSObject>

-(void)reloadCartDetail:(int)deleteResult;

-(void)cutCartDetail:(int)number whith:(float)price;

-(void)addCartDetail:(int)number whith:(float)price;

@end
