//
//  FootView.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/13.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FootPushViewDelegate.h"

@interface FootView : UIView

@property(strong,nonatomic)id<FootPushViewDelegate> viewDelegate;

@property(nonatomic)int _activeView;

@end
