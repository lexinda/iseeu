//
//  NextSpecialSellingView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/15.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "NextSpecialSellingView.h"

@implementation NextSpecialSellingView

@synthesize _imageArray;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (_imageArray != nil) {
        
        CGFloat x = 0.0;
        
        CGFloat width = (rect.size.width-15.0)/_imageArray.count;
        
        for (int i=0; i<_imageArray.count; i++) {
            
            HomeModel *homeModel = (HomeModel *)[_imageArray objectAtIndex:i];
            
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMAGEURL,homeModel.pic]];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0.0, width, rect.size.height)];
            
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"NextSpecialSellingTopImage%i",i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"加载NextSpecialSellingTopImage！");
            }];
            
            [self addSubview:imageView];
            
            x=x+width+5.0;
            
        }
        
    }
    
}


@end
