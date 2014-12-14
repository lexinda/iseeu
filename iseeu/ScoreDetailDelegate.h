//
//  ScoreDetailDelegate.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreDetailDelegate <NSObject>

-(void)cutScoreDetail:(int)number whith:(int)fen;

-(void)addScoreDetail:(int)number whith:(int)fen;

@end
