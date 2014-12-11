//
//  SpecialSellingView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/15.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "SpecialSellingView.h"

@implementation SpecialSellingView

@synthesize _imageArray;

@synthesize _delegate;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (_imageArray != nil) {
        
        CGFloat y = 10.0;
        
        for (int i=0; i<_imageArray.count; i++) {
            
            UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0.0, y, rect.size.width, 20.0)];
            
            [separateView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
            
            [self addSubview:separateView];
            
            HomeModel *homeModel = (HomeModel *)[_imageArray objectAtIndex:i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, separateView.frame.origin.y+separateView.frame.size.height+5.0, rect.size.width, 120.0)];
            
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_URL,homeModel.pic]];
            
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"SpecialSellingImage%i",i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"加载SpecialSellingImage!");
            }];
            
            imageView.tag = [homeModel.id intValue];
            
            imageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
            
            [imageView addGestureRecognizer:singleTap];
            
            [self addSubview:imageView];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, imageView.frame.origin.y+imageView.frame.size.height, rect.size.width, 20.0)];
            
            [title setText:[NSString stringWithFormat:@"%@",homeModel.title]];
            
            [self addSubview:title];
            
            UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(0.0, title.frame.origin.y+title.frame.size.height, 100.0, 20.0)];
            
            [price setText:[NSString stringWithFormat:@"￥%@",homeModel.price_xiaoshou]];
            
            [self addSubview:price];
            
            UIButton *shoppingCart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            [shoppingCart setFrame:CGRectMake(rect.size.width-30.0, price.frame.origin.y-10.0, 30.0, 30.0)];
            
            [shoppingCart addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
            
            [shoppingCart setTag:i];
            
            [shoppingCart setBackgroundImage:[UIImage imageNamed:@"home_shopping"] forState:UIControlStateNormal];
            
            [self addSubview:shoppingCart];
            
            y+=195.0;
            
        }
        
    }
    
    
}

-(void)onClickImage:(UITapGestureRecognizer *)sender{
    
    UIImageView *imageView = (UIImageView *)sender.view;
    
    NSLog(@"图片%li被点击!",(long)imageView.tag);
    
    [_delegate pushGoodsDetail:[NSNumber numberWithInt:(int)imageView.tag]];
}

-(void)addCart:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    HomeModel *homeModel = (HomeModel *)[_imageArray objectAtIndex:button.tag];
    
    CartActionDetail *cartActionDetail = [[CartActionDetail alloc] init];
    
    FMDatabase *db = [CartActionDetail getDb];
    
    NSDictionary *dictionary = @{@"id":homeModel.id,@"title":homeModel.title,@"number":@"1",@"price":homeModel.price_xiaoshou,@"pic":homeModel.pic};
    
    [cartActionDetail insertCartRow:db withDictionary:dictionary];
    
    [_delegate pushCartView];
    
    NSLog(@"按钮%@被点击!",homeModel.id);

}


@end
