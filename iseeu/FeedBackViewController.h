//
//  FeedBackViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 15/1/10.
//  Copyright (c) 2015年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking/AFNetworking.h>

@interface FeedBackViewController : UIViewController<UITextViewDelegate>

@property(strong,nonatomic)UIImageView *_userPhoto;

@property(strong,nonatomic)UITextView *_feedBackText;

@property(strong,nonatomic)NSString *_uid;

@end
