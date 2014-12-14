//
//  ScoreCellModelDelegate.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ScoreDataModel.h"

@protocol ScoreCellModelDelegate <NSObject>

-(void)pushTableViewModel:(ScoreDataModel *)scoreDataModel;

@end
