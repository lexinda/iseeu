//
//  AppDelegate.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/12.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PPRevealSideViewController/PPRevealSideViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)PPRevealSideViewController *_revealSideViewController;

@end

