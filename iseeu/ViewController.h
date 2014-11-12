//
//  ViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/12.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MBProgressHUD.h>

@interface ViewController : UIViewController<MBProgressHUDDelegate>

@property(strong,nonatomic)MBProgressHUD *_hud;

@end

