//
//  BannerView.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/13.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView

@synthesize _scrollView;

@synthesize _index;

@synthesize _pageControl;

@synthesize _imageArray;

-(void)drawRect:(CGRect)rect{

    _index = 0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    [_scrollView setBackgroundColor:[UIColor whiteColor]];
    
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    
    [_scrollView setShowsVerticalScrollIndicator:NO];
    
    _scrollView.contentSize = CGSizeMake(rect.size.width*_imageArray.count, rect.size.height);
    
    CGFloat x = 0.0;
    
    if (_imageArray != nil) {
        
        for (int i=0; i<_imageArray.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0.0, rect.size.width, rect.size.height)];
            
            HomeModel *homeModel = (HomeModel *)[_imageArray objectAtIndex:i];
            
            NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVER_IMAGEURL,homeModel.pic]];
            
            [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"bannerImage%i",i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                NSLog(@"加载bannerimage！");
            }];
            
            [_scrollView addSubview:imageView];
            
            x+=rect.size.width;
            
        }
        
        [self addSubview:_scrollView];
        
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(swapImage) userInfo:nil repeats:YES];
        
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((rect.size.width-100.0)/2, rect.size.height-30.0, 100.0, 30.0)];
    
    _pageControl.numberOfPages = 5;
    
    [self addSubview:_pageControl];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth=self.frame.size.width;
    
    int currentPage=floor((_scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    
    _pageControl.currentPage=currentPage;
    
}

-(void)swapImage{

    if (_index>4) {
        
        _index=0;
        
    }else{
        
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width*_index, 0.0) animated:YES];
        
        _index++;
        
    }
    
}

@end
