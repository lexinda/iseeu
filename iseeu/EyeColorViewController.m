//
//  EyeColorViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeColorViewController.h"

#define LEFTPADDIGN 12.0f

#define RIGHTPADDIGN 11.0f

#define UPPADDIGN 6.0f

#define DOWNPADDIGN 5.0f

@implementation EyeColorViewController

@synthesize startPoint;

@synthesize upView;

@synthesize rightView;

@synthesize downView;

@synthesize leftView;

@synthesize centerView;

@synthesize centerPoint;

@synthesize eyeView;

@synthesize scrollView;

@synthesize imageView;

@synthesize leftPoint;

@synthesize rightPoint;

@synthesize upPoint;

@synthesize downPoint;

@synthesize oldScale;

@synthesize realCenterPoint;

@synthesize realUpPoint;

@synthesize realRightPoint;

@synthesize realDownPoint;

@synthesize realLeftPoint;

@synthesize commitButton;

@synthesize resizeButton;

@synthesize path;

@synthesize shapeLayer;

@synthesize selectImageView;

@synthesize draw;

@synthesize _gestureStartPoint;

@synthesize _originPointName;

@synthesize _steepName;

@synthesize _eyeCircleView;

@synthesize _leftCenterPoint;

@synthesize _rightCenterPoint;

@synthesize _mousePoint;

@synthesize _eyeSlider;

@synthesize _leftDictionary;

@synthesize _leftEyeDictionary;

@synthesize _rightDictionary;

@synthesize _rightEyeDictionary;

@synthesize _leftImageView;

@synthesize _leftEyeView;

@synthesize _eyeViewAlpha;

@synthesize _rightImageView;

@synthesize _rightEyeView;

@synthesize _radius;

@synthesize _leftRadius;

@synthesize _rightRadius;

@synthesize _colorEyeImage;

@synthesize _slider;

@synthesize _defaultImageStr;

@synthesize _footView;

@synthesize _colorEyeScrollView;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        self.title = @"试戴";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }
    
    return self;
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:mainView];
    
    _colorEyeImage = [NSArray arrayWithObjects:@"2.png",@"3.png",@"4.png",@"5.png",@"6.png",@"eye1.png", nil];
    
    _eyeViewAlpha = 1.0f;
    
    _steepName = @"one";
    
    _radius = 13.0;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
    [mainView addGestureRecognizer:pan];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    _defaultImageStr = @"try1111.png";
    
    UIImage *image=[UIImage imageNamed:@"try1111.png"];
    
    self.imageView=[[UIImageView alloc]initWithFrame:self.scrollView.frame];
    
    self.imageView.image = image;
    
     NSLog(@"%f,%f",image.size.width,image.size.height);
    
    UIImage *newImg = [self scaleImage:imageView.image];//图片根据imgV的frame进行重新缩放生成
    
    NSLog(@"%f,%f",newImg.size.width,newImg.size.height);
    self.imageView.image = newImg;
    //
    
    NSLog(@"%f,%f",self.imageView.center.x,self.imageView.center.y);
    
    self.imageView.tag = 7;
    
    //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
    [self.scrollView addSubview:self.imageView];
    
    //设置UIScrollView的滚动范围和图片的真实尺寸一致
    self.scrollView.contentSize=image.size;
    
    //设置实现缩放
    //设置代理scrollview的代理对象
    self.scrollView.delegate=self;
    
    //设置最大伸缩比例
    self.scrollView.maximumZoomScale=5.0;
    
    //设置最小伸缩比例
    self.scrollView.minimumZoomScale=1.0;
    
    [self.scrollView setBouncesZoom:NO];
    
    self.scrollView.alwaysBounceHorizontal = NO;
    
    self.scrollView.alwaysBounceVertical = NO;
    
    [self.scrollView setScrollEnabled:NO];
    
    [self.scrollView setZoomScale:2.0];
    
    self.oldScale = [NSNumber numberWithFloat:self.scrollView.zoomScale];
    
    [mainView addSubview:self.scrollView];
    
    [self changeEyeView];
    
}

-(void)changeEyeView{
    
    [self faceDetectOne:self.imageView.image];
    
}

-(void)getFaceEyeViewAndTool{
    
    [self faceDetect:self.imageView.image];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [nextButton setFrame:CGRectMake(self.view.frame.size.width-50.0, 0.0, 40, _footView.frame.size.height)];
    
    [nextButton setTitle:@"next" forState:UIControlStateNormal];
    
    [nextButton addTarget:self action:@selector(NextConvertEye) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:nextButton];

}

//将图片进行缩放重新生成
- (UIImage *) scaleImage:(UIImage *)image{
    if (image) {
        CGSize newSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    return nil;
}

-(void)NextConvertEye{

    if ([_steepName isEqualToString:@"one"]) {
        _steepName = @"two";
    }else if([_steepName isEqualToString:@"two"]) {
        _steepName = @"three";
    }else if([_steepName isEqualToString:@"three"]) {
        _steepName = @"four";
    }else if([_steepName isEqualToString:@"four"]){
        _steepName = @"five";
    }
    
    if ([_steepName isEqualToString:@"two"]) {
        
        _radius = 13.0f;
        
        _leftRadius = _radius*0.5*[self.oldScale floatValue];
        
        _leftDictionary = @{@"center":[NSValue valueWithCGPoint:self.realCenterPoint],@"left":[NSValue valueWithCGPoint:self.realLeftPoint],@"right":[NSValue valueWithCGPoint:self.realRightPoint],@"up":[NSValue valueWithCGPoint:self.realUpPoint],@"down":[NSValue valueWithCGPoint:self.realDownPoint]};
        
        [self.eyeView removeFromSuperview];
        
        [self.upView removeFromSuperview];
        
        [self.rightView removeFromSuperview];
        
        [self.leftView removeFromSuperview];
        
        [self.downView removeFromSuperview];
        
        [self.centerView removeFromSuperview];
        
        _eyeCircleView = [[EyeCircleView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
        
        [_eyeCircleView setBackgroundColor:[UIColor clearColor]];
        
        _eyeCircleView.alpha=0.3;
        
        [_eyeCircleView setCenterPoint:CGPointMake(_leftCenterPoint.x*[self.oldScale floatValue], _leftCenterPoint.y*[self.oldScale floatValue])];
        
        [_eyeCircleView setTag:8];
        
        [_eyeCircleView setRadius:_radius*0.5*[self.oldScale floatValue]];
        
        [self.scrollView addSubview:_eyeCircleView];
        
        _eyeSlider = [[UISlider alloc] initWithFrame:CGRectMake(-80.0, 200.0, 200.0, 20.0)];
        
        [_eyeSlider setTransform:[self transformForExpandDirection]];
        
        [self.view addSubview:_eyeSlider];
        
        _eyeSlider.minimumValue = 0.0f;
        
        _eyeSlider.value = 0.5;
        
        _eyeSlider.maximumValue = 1.0f;
        
        [_eyeSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
    }else if ([_steepName isEqualToString:@"three"]) {
        
        _leftEyeDictionary = @{@"center":[NSValue valueWithCGPoint:self.realCenterPoint],@"radius":[NSNumber numberWithFloat:_leftRadius/[self.oldScale floatValue]]};
        
        [_eyeCircleView removeFromSuperview];
        
        [_eyeSlider removeFromSuperview];
        
        [self drawRect];
        
    }else if ([_steepName isEqualToString:@"four"]) {
        
        _radius = 13.0f;
        
        _rightRadius = _radius*0.5*[self.oldScale floatValue];
        
        _rightDictionary = @{@"center":[NSValue valueWithCGPoint:self.realCenterPoint],@"left":[NSValue valueWithCGPoint:self.realLeftPoint],@"right":[NSValue valueWithCGPoint:self.realRightPoint],@"up":[NSValue valueWithCGPoint:self.realUpPoint],@"down":[NSValue valueWithCGPoint:self.realDownPoint]};
        
        [self.eyeView removeFromSuperview];
        
        [self.upView removeFromSuperview];
        
        [self.rightView removeFromSuperview];
        
        [self.leftView removeFromSuperview];
        
        [self.downView removeFromSuperview];
        
        [self.centerView removeFromSuperview];
        
        _eyeCircleView = [[EyeCircleView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
        
        [_eyeCircleView setTag:9];
        
        [_eyeCircleView setBackgroundColor:[UIColor clearColor]];
        
        _eyeCircleView.alpha=0.3;
        
        [_eyeCircleView setCenterPoint:CGPointMake(_rightCenterPoint.x*[self.oldScale floatValue], _rightCenterPoint.y*[self.oldScale floatValue])];
        
        [_eyeCircleView setRadius:_radius*0.5*[self.oldScale floatValue]];
        
        [self.scrollView addSubview:_eyeCircleView];
        
        _eyeSlider = [[UISlider alloc] initWithFrame:CGRectMake(-80.0, 200.0, 200.0, 20.0)];
        
        [_eyeSlider setTransform:[self transformForExpandDirection]];
        
        [self.view addSubview:_eyeSlider];
        
        _eyeSlider.minimumValue = 0.0f;
        
        _eyeSlider.value = 0.5;
        
        _eyeSlider.maximumValue = 1.0f;
        
        [_eyeSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
    }else if([_steepName isEqualToString:@"five"]){
        
        [_eyeSlider removeFromSuperview];
        
        [_eyeCircleView removeFromSuperview];
    
        _rightEyeDictionary = @{@"center":[NSValue valueWithCGPoint:self.realCenterPoint],@"radius":[NSNumber numberWithFloat:_rightRadius/[self.oldScale floatValue]]};
        
        NSLog(@"left%@",_leftDictionary);
        
        NSLog(@"leftEye%@",_leftEyeDictionary);
        
        NSLog(@"right%@",_rightDictionary);
        
        NSLog(@"rightEye%@",_rightEyeDictionary);
        
        [self.scrollView setContentOffset:CGPointMake(_mousePoint.x*[self.oldScale floatValue]-self.view.frame.size.width/2, _mousePoint.y)];
        
        [self addEyeImageView];
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, self.view.frame.size.height-64-49-40, 200.0, 20.0)];
        
        [self.view addSubview:_slider];
        
        _slider.minimumValue = 0.0f;
        
        [_slider setValue:1.0f];
        
        _slider.maximumValue = 1.0f;
        
        [_slider addTarget:self action:@selector(imageEyeChanged:) forControlEvents:UIControlEventValueChanged];
        
        for (UIView *view in [_footView subviews]) {
            [view removeFromSuperview];
        }
        
        UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [takePhoto setFrame:CGRectMake(10.0f, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
        
        UIImage *takePhotoImage = [UIImage imageNamed:@"try_photo.png"];
        
        [takePhoto setBackgroundImage:takePhotoImage forState:UIControlStateNormal];
        
        [takePhoto setTag:2000];
        
        [takePhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:takePhoto];
        
        UIButton *libraryPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [libraryPhoto setFrame:CGRectMake(takePhoto.frame.size.width+10.0f, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
        
        UIImage *libraryPhotoImage = [UIImage imageNamed:@"try_photos.png"];
        
        [libraryPhoto setBackgroundImage:libraryPhotoImage forState:UIControlStateNormal];
        
        [libraryPhoto setTag:2001];
        
        [libraryPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:libraryPhoto];
        
        UIButton *commitPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [commitPhoto setFrame:CGRectMake(self.view.frame.size.width-10.0*2-takePhoto.frame.size.width*2, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
        
        UIImage *commitPhotoImage = [UIImage imageNamed:@"try_summbit.png"];
        
        [commitPhoto setBackgroundImage:commitPhotoImage forState:UIControlStateNormal];
        
        [commitPhoto setTag:2002];
        
        [commitPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:commitPhoto];
        
        UIButton *cancelPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [cancelPhoto setFrame:CGRectMake(self.view.frame.size.width-10.0-takePhoto.frame.size.width, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
        
        UIImage *cancelPhotoImage = [UIImage imageNamed:@"try_cancel.png"];
        
        [cancelPhoto setBackgroundImage:cancelPhotoImage forState:UIControlStateNormal];
        
        [cancelPhoto setTag:2003];
        
        [cancelPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:cancelPhoto];
        
        [_footView setBackgroundColor:[UIColor whiteColor]];
        
        [self.view addSubview:_footView];
        
        _colorEyeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-49.0-45.0, self.view.frame.size.width, 45.0)];
        
        [_colorEyeScrollView setBackgroundColor:[UIColor clearColor]];
        
        CGFloat x = 0.0f;
        
        for (int i = 0; i<_colorEyeImage.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            [button setBackgroundImage:[UIImage imageNamed:[_colorEyeImage objectAtIndex:i]] forState:UIControlStateNormal];
            
            [button setFrame:CGRectMake(x, 0.0f, 45.0f, 45.0f)];
            
            [button setTag:1000+i];
            
            [button addTarget:self action:@selector(colorImageEyeChanged:) forControlEvents:UIControlEventTouchUpInside];
            
            [_colorEyeScrollView addSubview:button];
            
            x+=45.0f+20;
            
        }
        
        [self.view addSubview:_colorEyeScrollView];
        
        [_colorEyeScrollView setContentSize:CGSizeMake(x+45.0f, _colorEyeScrollView.frame.size.height)];
        
    }
    
}

-(void)imageEyeChanged:(id)sender{
    
     UISlider *mySlider = (UISlider *)sender;
    
    _eyeViewAlpha = mySlider.value;
    
    [_leftEyeView setAlpha:_eyeViewAlpha];
    
    [_rightEyeView setAlpha:_eyeViewAlpha];

}

-(void)colorImageEyeChanged:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    NSLog(@"%li",(long)button.tag);
    
    NSString *colorImageStr = [_colorEyeImage objectAtIndex:button.tag-1000];
    
    [_leftImageView setImage:[UIImage imageNamed:colorImageStr]];
    
    [_rightImageView setImage:[UIImage imageNamed:colorImageStr]];
    
}

-(void)sliderChanged:(id)sender{
    
    UISlider *mySlider = (UISlider *)sender;
    
    if (mySlider.tag == 8) {
        
        [_eyeCircleView setCenterPoint:CGPointMake(_leftCenterPoint.x*[self.oldScale floatValue], _leftCenterPoint.y*[self.oldScale floatValue])];
        
        _leftRadius = _radius*mySlider.value*[self.oldScale floatValue];
        
    }else if(mySlider.tag == 9){
        
        [_eyeCircleView setCenterPoint:CGPointMake(_rightCenterPoint.x*[self.oldScale floatValue], _rightCenterPoint.y*[self.oldScale floatValue])];
        
        _rightRadius = _radius*mySlider.value*[self.oldScale floatValue];
    
    }
    
    [_eyeCircleView setRadius:_radius*mySlider.value*[self.oldScale floatValue]];
    
    [_eyeCircleView setNeedsDisplay];
    
    NSLog(@"SliderValue %f",mySlider.value);
    
}

- (CGAffineTransform)transformForExpandDirection {
    
        return CGAffineTransformMakeRotation(-M_PI/2.f);
}

-(void)drawRect{
    
    int tag = 0;
    
    if ([_steepName isEqualToString:@"one"]) {
        
        tag = 6;
        
        [self.scrollView setContentOffset:CGPointMake(_leftCenterPoint.x*[self.oldScale floatValue]-self.view.frame.size.width/2, _leftCenterPoint.y)];
        
        self.centerPoint = _leftCenterPoint;
        
    }else if([_steepName isEqualToString:@"three"]){
        
        tag = 7;
        
        [self.scrollView setContentOffset:CGPointMake(_rightCenterPoint.x*[self.oldScale floatValue]-self.view.frame.size.width/2, _rightCenterPoint.y)];
        
        self.centerPoint = _rightCenterPoint;
        
    }
    
    self.realCenterPoint = self.centerPoint;
    
    self.upPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y-UPPADDIGN);
    
    self.realUpPoint = self.upPoint;
    
    self.rightPoint = CGPointMake(self.centerPoint.x+RIGHTPADDIGN, self.centerPoint.y);
    
    self.realRightPoint = self.rightPoint;
    
    self.downPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y+DOWNPADDIGN);
    
    self.realDownPoint = self.downPoint;
    
    self.leftPoint = CGPointMake(self.centerPoint.x-LEFTPADDIGN, self.centerPoint.y);
    
    self.realLeftPoint = self.leftPoint;
    
    NSLog(@"%f,%f",self.centerPoint.x,self.centerPoint.y);
    
    //眼部的图片跟缩放的最大倍数相同
    self.eyeView = [[EyeView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
    
    self.eyeView.alpha=0.3;
    
    self.eyeView.tag = tag;
    
    [self.eyeView setCenterPoint:CGPointMake(self.realCenterPoint.x*[self.oldScale floatValue], self.realCenterPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setUpPoint:CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setRightPoint:CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setDownPoint:CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setLeftPoint:CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setViewDelegate:self];
    
    [self.eyeView setBackgroundColor:[UIColor clearColor]];
    
    [self.scrollView addSubview:self.eyeView];
    
    CGPoint relativeCenterPoint = CGPointMake(self.realCenterPoint.x*[self.oldScale floatValue], self.realCenterPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue]);
    
    self.upView = [self getView:1 withCenter:relativeUpPoint];
    
    self.rightView = [self getView:2 withCenter:relativeRightPoint];
    
    self.leftView = [self getView:3 withCenter:relativeLeftPoint];
    
    self.downView = [self getView:4 withCenter:relativeDownPoint];
    
    self.centerView = [self getView:5 withCenter:relativeCenterPoint];
    
    [self.centerView setHidden:YES];
    
    [self.scrollView addSubview:self.upView];
    
    [self.scrollView addSubview:self.rightView];
    
    [self.scrollView addSubview:self.downView];
    
    [self.scrollView addSubview:self.leftView];
    
    [self.scrollView addSubview:self.centerView];
    
}

-(UIView *)getView:(int)tag
         withCenter:(CGPoint)centerPoint{
    
    CGPoint point = CGPointMake(centerPoint.x, centerPoint.y);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"number"]]];
    
    [view setCenter:point];
    
    view.tag = tag;
    
    return view;
    
    
}

//滑动调用的方法
- (void)longAction:(UILongPressGestureRecognizer *)recognizer
{
    
    CGPoint point = [recognizer locationInView:recognizer.view];
    
    NSLog(@"点击x%f,点击y%f",point.x,point.y);
    
    CGFloat x = 0.0f;
    
    if (_gestureStartPoint.x>0) {
        
        x = (point.x-_gestureStartPoint.x)/[self.oldScale floatValue];
        
    }
    
    CGFloat y = 0.0f;
    
    if (_gestureStartPoint.y>0) {
        
        y = (point.y-_gestureStartPoint.y)/[self.oldScale floatValue];
        
    }
    
    _gestureStartPoint = point;
    
    CGPoint relativeCenterPoint = CGPointMake(self.realCenterPoint.x*[self.oldScale floatValue], self.realCenterPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue]);
    
    CGPoint center = CGPointMake(self.scrollView.frame.size.width/2, self.scrollView.frame.size.height/2-(self.scrollView.frame.size.height/2/3));
    
    NSLog(@"x%f,y%f",center.x,center.y);
    
    CGFloat height = 50.0f;
    
    if ([_steepName isEqualToString:@"one"]||[_steepName isEqualToString:@"three"]) {
        
        if (point.x<center.x-height) {
            
            if (![_originPointName isEqualToString:@"leftPoint"]) {
                
                _gestureStartPoint = CGPointMake(0.0f, 0.0f);
                
                x = 0.0f;
                
                y = 0.0f;
                
            }
            
            CGPoint newLeftPoint = CGPointMake(relativeLeftPoint.x+x, relativeLeftPoint.y+y);
            
            self.realLeftPoint = CGPointMake(self.realLeftPoint.x+x, self.realLeftPoint.y+y);
            
            [self.leftView setCenter:newLeftPoint];
            
            [self.eyeView setLeftPoint:newLeftPoint];
            
            [self.eyeView setNeedsDisplay];
            
            _originPointName = @"leftPoint";
            
        }else if (point.x>center.x+height){
        
            if (![_originPointName isEqualToString:@"rightPoint"]) {
                
                _gestureStartPoint = CGPointMake(0.0f, 0.0f);
                
                x = 0.0f;
                
                y = 0.0f;
                
            }
            
            CGPoint newRightPoint = CGPointMake(relativeRightPoint.x+x, relativeRightPoint.y+y);
            
            self.realRightPoint = CGPointMake(self.realRightPoint.x+x, self.realRightPoint.y+y);
            
            [self.rightView setCenter:newRightPoint];
            
            [self.eyeView setRightPoint:newRightPoint];
            
            [self.eyeView setNeedsDisplay];
            
            _originPointName = @"rightPoint";
            
        }else{
            
            if (point.y<center.y-height) {
                
                if (![_originPointName isEqualToString:@"upPoint"]) {
                    
                    _gestureStartPoint = CGPointMake(0.0f, 0.0f);
                    
                    x = 0.0f;
                    
                    y = 0.0f;
                    
                }
                
                CGPoint newUpPoint = CGPointMake(relativeUpPoint.x+x, relativeUpPoint.y+y);
                
                self.realUpPoint = CGPointMake(self.realUpPoint.x+x, self.realUpPoint.y+y);
                
                [self.upView setCenter:newUpPoint];
                
                [self.eyeView setUpPoint:newUpPoint];
                
                [self.eyeView setNeedsDisplay];
                
                _originPointName = @"upPoint";
                
            }else if(point.y>center.y+height){
                
                if (![_originPointName isEqualToString:@"downPoint"]) {
                    
                    _gestureStartPoint = CGPointMake(0.0f, 0.0f);
                    
                    x = 0.0f;
                    
                    y = 0.0f;
                    
                }
                
                CGPoint newDownPoint = CGPointMake(relativeDownPoint.x+x, relativeDownPoint.y+y);
                
                self.realDownPoint = CGPointMake(self.realDownPoint.x+x, self.realDownPoint.y+y);
                
                [self.downView setCenter:newDownPoint];
                
                [self.eyeView setDownPoint:newDownPoint];
                
                [self.eyeView setNeedsDisplay];
                
                _originPointName = @"downPoint";
                
            }
        
        }
        
    }else if([_steepName isEqualToString:@"two"]||[_steepName isEqualToString:@"four"]){
    
        CGPoint newCenterPoint = CGPointMake(relativeCenterPoint.x+x, relativeCenterPoint.y+y);
        
        self.realCenterPoint = CGPointMake(self.realCenterPoint.x+x, self.realCenterPoint.y+y);
        
        [_eyeCircleView setCenterPoint:newCenterPoint];
        
        if ([_steepName isEqualToString:@"two"]) {
            
            [_eyeCircleView setRadius:_leftRadius];
            
        }else if([_steepName isEqualToString:@"four"]){
            
            [_eyeCircleView setRadius:_rightRadius];
        }
        
        [_eyeCircleView setNeedsDisplay];
        
    }
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    [self.upView setHidden:YES];
    
    [self.rightView setHidden:YES];
    
    [self.downView setHidden:YES];
    
    [self.leftView setHidden:YES];
    
    [self.centerView setHidden:YES];
    
    [self.eyeView setHidden:YES];
    
    [self.selectImageView setHidden:YES];
    
    [_eyeCircleView setHidden:YES];
    
    [_leftEyeView removeFromSuperview];
    
    _leftEyeView = nil;
    
    [_leftImageView removeFromSuperview];
    
    _leftImageView = nil;
    
    [_rightEyeView removeFromSuperview];
    
    _rightEyeView = nil;
    
    [_rightImageView removeFromSuperview];
    
    _rightImageView = nil;
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [self.upView setHidden:NO];
    
    [self.rightView setHidden:NO];
    
    [self.downView setHidden:NO];
    
    [self.leftView setHidden:NO];
    
    [self.centerView setHidden:YES];
    
    [self.eyeView setHidden:NO];
    
    [_eyeCircleView setHidden:NO];
    
    self.oldScale = [NSNumber numberWithFloat:scale];
    
    //不缩放时定位中心点后，缩放时点不会改变
    
    CGPoint relativeCenterPoint = CGPointMake(self.realCenterPoint.x*scale, self.realCenterPoint.y*scale);
    
    [self.upView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y-UPPADDIGN, 20, 20)];
    
    [self.rightView setFrame:CGRectMake(self.centerPoint.x+RIGHTPADDIGN, self.centerPoint.y, 20, 20)];
    
    [self.leftView setFrame:CGRectMake(self.centerPoint.x-LEFTPADDIGN, self.centerPoint.y, 20, 20)];
    
    [self.downView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y+DOWNPADDIGN, 20, 20)];
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*scale, self.realUpPoint.y*scale);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*scale, self.realRightPoint.y*scale);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*scale, self.realDownPoint.y*scale);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*scale, self.realLeftPoint.y*scale);
    
    [self.centerView setCenter:CGPointMake(relativeCenterPoint.x, relativeCenterPoint.y)];
    
    [self.upView setCenter:CGPointMake(relativeUpPoint.x, relativeUpPoint.y)];
    
    [self.rightView setCenter:CGPointMake(relativeRightPoint.x, relativeRightPoint.y)];
    
    [self.leftView setCenter:CGPointMake(relativeLeftPoint.x, relativeLeftPoint.y)];
    
    [self.downView setCenter:CGPointMake(relativeDownPoint.x, relativeDownPoint.y)];
    
    [self.eyeView setUpPoint:CGPointMake(relativeUpPoint.x, relativeUpPoint.y)];
    
    [self.eyeView setRightPoint:CGPointMake(relativeRightPoint.x, relativeRightPoint.y)];
    
    [self.eyeView setLeftPoint:CGPointMake(relativeLeftPoint.x, relativeLeftPoint.y)];
    
    [self.eyeView setDownPoint:CGPointMake(relativeDownPoint.x, relativeDownPoint.y)];
    
    [self.eyeView setCenterPoint:relativeCenterPoint];
    
    [self.eyeView setViewDelegate:self];
    
    [self.eyeView setNeedsDisplay];
    
    [_eyeCircleView setCenterPoint:relativeCenterPoint];
    
    [_eyeCircleView setRadius:10*[self.oldScale floatValue]];
    
    [_eyeCircleView setNeedsDisplay];
    
    [self addEyeImageView];
    
    
    
}

-(void)getPath:(UIBezierPath *)paths{
    
    self.path = paths;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    _gestureStartPoint = CGPointMake(0.0f, 0.0f);
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    _gestureStartPoint = CGPointMake(0.0f, 0.0f);
    
}

#pragma mark - 人脸检测方法
- (void)faceDetect:(UIImage *)aImage
{
    
    //Create a CIImage version of your photo
    CIImage* image = [CIImage imageWithCGImage:aImage.CGImage];
    
    //create a face detector
    //此处是CIDetectorAccuracyHigh，若用于real-time的人脸检测，则用CIDetectorAccuracyLow，更快
    NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:opts];
    
    //Pull out the features of the face and loop through them
    NSArray* features = [detector featuresInImage:image];
    
    if ([features count]==0) {
        NSLog(@">>>>> 人脸监测【失败】啦 ～！！！");
        
    }
    NSLog(@">>>>> 人脸监测【成功】～！！！>>>>>> ");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self markAfterFaceDetect:features];
    });
    
}

//人脸标识
-(void)markAfterFaceDetect:(NSArray *)features
{
    
    if ([features count]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败"
                                                       message:@"眼部定位失败，您可以换另外一张图片"
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    for (CIFaceFeature *f in features)
    {
        
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition){
            printf("Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
            
            NSLog(@"%f",self.scrollView.bounds.size.height);
            
            if ([_defaultImageStr isEqualToString:@"try1111.png"]) {
                _leftCenterPoint = CGPointMake(f.leftEyePosition.x-6.0f,self.imageView.image.size.height-f.leftEyePosition.y-2.0f);
            }else{
            
                _leftCenterPoint = CGPointMake(f.leftEyePosition.x,self.imageView.image.size.height-f.leftEyePosition.y);
                
            }
            
            
            
//            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
//            vv.tag = 100;
//            //旋转180，仅y
//            CGPoint newCenter =  f.leftEyePosition;
//            newCenter.y = self.scrollView.bounds.size.height-newCenter.y;
//            vv.center = newCenter;
//            
//            vv.backgroundColor = [UIColor yellowColor];
//            [vv setTransform:CGAffineTransformMakeScale(1, -1)];
//            vv.alpha = 0.6;
//            [self.scrollView addSubview:vv];

        }
        if (f.hasRightEyePosition)
        {
            printf("Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
            
            _rightCenterPoint = CGPointMake(f.rightEyePosition.x, self.scrollView.bounds.size.height-f.rightEyePosition.y);

        }
        if (f.hasMouthPosition)
        {
            printf("Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
            
            _mousePoint = CGPointMake(f.mouthPosition.x, self.scrollView.bounds.size.height-f.mouthPosition.y);
            
        }
    }
    
    [self drawRect];
    
}

#pragma mark - 人脸检测方法
- (void)faceDetectOne:(UIImage *)aImage
{
    
    //Create a CIImage version of your photo
    CIImage* image = [CIImage imageWithCGImage:aImage.CGImage];
    
    //create a face detector
    //此处是CIDetectorAccuracyHigh，若用于real-time的人脸检测，则用CIDetectorAccuracyLow，更快
    NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:opts];
    
    //Pull out the features of the face and loop through them
    NSArray* features = [detector featuresInImage:image];
    
    if ([features count]==0) {
        NSLog(@">>>>> 人脸监测【失败】啦 ～！！！");
        
    }
    NSLog(@">>>>> 人脸监测【成功】～！！！>>>>>> ");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self markAfterFaceDetectOne:features];
    });
    
}

//人脸标识
-(void)markAfterFaceDetectOne:(NSArray *)features
{
    
    if ([features count]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"失败"
                                                       message:@"眼部定位失败，您可以换另外一张图片"
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    for (CIFaceFeature *f in features)
    {
        
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition){
            printf("Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
            
            NSLog(@"%f",self.scrollView.bounds.size.height);
            
            if ([_defaultImageStr isEqualToString:@"try1111.png"]) {
                _leftCenterPoint = CGPointMake(f.leftEyePosition.x-6.0f,self.imageView.image.size.height-f.leftEyePosition.y-2.0f);
            }else{
                
                _leftCenterPoint = CGPointMake(f.leftEyePosition.x,self.imageView.image.size.height-f.leftEyePosition.y);
                
            }
            
            
            
            //            UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            //            vv.tag = 100;
            //            //旋转180，仅y
            //            CGPoint newCenter =  f.leftEyePosition;
            //            newCenter.y = self.scrollView.bounds.size.height-newCenter.y;
            //            vv.center = newCenter;
            //
            //            vv.backgroundColor = [UIColor yellowColor];
            //            [vv setTransform:CGAffineTransformMakeScale(1, -1)];
            //            vv.alpha = 0.6;
            //            [self.scrollView addSubview:vv];
            
        }
        if (f.hasRightEyePosition)
        {
            printf("Right eye %g %g\n", f.rightEyePosition.x, f.rightEyePosition.y);
            
            _rightCenterPoint = CGPointMake(f.rightEyePosition.x, self.scrollView.bounds.size.height-f.rightEyePosition.y);
            
        }
        if (f.hasMouthPosition)
        {
            printf("Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
            
            _mousePoint = CGPointMake(f.mouthPosition.x, self.scrollView.bounds.size.height-f.mouthPosition.y);
            
        }
    }
    
    _leftDictionary = @{@"center":[NSValue valueWithCGPoint:CGPointMake(158, 124)],@"left":[NSValue valueWithCGPoint:CGPointMake(146, 124)],@"right":[NSValue valueWithCGPoint:CGPointMake(175, 128.75)],@"up":[NSValue valueWithCGPoint:CGPointMake(160.5, 115.5)],@"down":[NSValue valueWithCGPoint:CGPointMake(159.75, 130.75)]};
    
    _leftEyeDictionary = @{@"center":[NSValue valueWithCGPoint:CGPointMake(159.5, 122.5)],@"radius":[NSNumber numberWithFloat:6.5]};
    
    _rightDictionary = @{@"center":[NSValue valueWithCGPoint:CGPointMake(215, 132)],@"left":[NSValue valueWithCGPoint:CGPointMake(201.5, 133)],@"right":[NSValue valueWithCGPoint:CGPointMake(226, 132)],@"up":[NSValue valueWithCGPoint:CGPointMake(214.5, 124.5)],@"down":[NSValue valueWithCGPoint:CGPointMake(213.75, 138.5)]};
    
    _rightEyeDictionary = @{@"center":[NSValue valueWithCGPoint:CGPointMake(211.25, 131.25)],@"radius":[NSNumber numberWithFloat:6.5]};
    
    NSLog(@"%f",_mousePoint.x*[self.oldScale floatValue]-self.view.frame.size.width/2);
    
    [self.scrollView setContentOffset:CGPointMake(_mousePoint.x*[self.oldScale floatValue]-self.view.frame.size.width/2, _mousePoint.y)];
    
    [self addEyeImageView];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, self.view.frame.size.height-64-49-40, 200.0, 20.0)];
    
    [self.view addSubview:_slider];
    
    _slider.minimumValue = 0.0f;
    
    [_slider setValue:1.0f];
    
    _slider.maximumValue = 1.0f;
    
    [_slider addTarget:self action:@selector(imageEyeChanged:) forControlEvents:UIControlEventValueChanged];
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-49.0, self.view.frame.size.width, 49.0)];
    
    UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [takePhoto setFrame:CGRectMake(10.0f, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
    
    UIImage *takePhotoImage = [UIImage imageNamed:@"try_photo.png"];
    
    [takePhoto setBackgroundImage:takePhotoImage forState:UIControlStateNormal];
    
    [takePhoto setTag:2000];
    
    [takePhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:takePhoto];
    
    UIButton *libraryPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [libraryPhoto setFrame:CGRectMake(takePhoto.frame.size.width+10.0f, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
    
    UIImage *libraryPhotoImage = [UIImage imageNamed:@"try_photos.png"];
    
    [libraryPhoto setBackgroundImage:libraryPhotoImage forState:UIControlStateNormal];
    
    [libraryPhoto setTag:2001];
    
    [libraryPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:libraryPhoto];
    
    UIButton *commitPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [commitPhoto setFrame:CGRectMake(self.view.frame.size.width-10.0*2-takePhoto.frame.size.width*2, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
    
    UIImage *commitPhotoImage = [UIImage imageNamed:@"try_summbit.png"];
    
    [commitPhoto setBackgroundImage:commitPhotoImage forState:UIControlStateNormal];
    
    [commitPhoto setTag:2002];
    
    [commitPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:commitPhoto];
    
    UIButton *cancelPhoto = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [cancelPhoto setFrame:CGRectMake(self.view.frame.size.width-10.0-takePhoto.frame.size.width, 0.0f, (self.view.frame.size.width-60-20)/4, _footView.frame.size.height)];
    
    UIImage *cancelPhotoImage = [UIImage imageNamed:@"try_cancel.png"];
    
    [cancelPhoto setBackgroundImage:cancelPhotoImage forState:UIControlStateNormal];
    
    [cancelPhoto setTag:2003];
    
    [cancelPhoto addTarget:self action:@selector(getPhoto:) forControlEvents:UIControlEventTouchUpInside];
    
    [_footView addSubview:cancelPhoto];
    
    [_footView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_footView];
    
    _colorEyeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.view.frame.size.height-49.0-45.0, self.view.frame.size.width, 45.0)];
    
    [_colorEyeScrollView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat x = 0.0f;
    
    for (int i = 0; i<_colorEyeImage.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [button setBackgroundImage:[UIImage imageNamed:[_colorEyeImage objectAtIndex:i]] forState:UIControlStateNormal];
        
        [button setFrame:CGRectMake(x, 0.0f, 45.0f, 45.0f)];
        
        [button setTag:1000+i];
        
        [button addTarget:self action:@selector(colorImageEyeChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        [_colorEyeScrollView addSubview:button];
        
        x+=45.0f+20;
        
    }
    
    [self.view addSubview:_colorEyeScrollView];
    
    [_colorEyeScrollView setContentSize:CGSizeMake(x+45.0f, _colorEyeScrollView.frame.size.height)];
    
}

-(void)addEyeImageView{
    
    //leftImageView
    
    NSValue *leftValue = [_leftDictionary objectForKey:@"left"];
    
    CGPoint left = CGPointMake([leftValue CGPointValue].x*[self.oldScale floatValue], [leftValue CGPointValue].y*[self.oldScale floatValue]) ;
    
    NSValue *rightValue = [_leftDictionary objectForKey:@"right"];
    
    CGPoint right = CGPointMake([rightValue CGPointValue].x*[self.oldScale floatValue], [rightValue CGPointValue].y*[self.oldScale floatValue]);
    
    NSValue *upValue = [_leftDictionary objectForKey:@"up"];
    
    CGPoint up = CGPointMake([upValue CGPointValue].x*[self.oldScale floatValue], [upValue CGPointValue].y*[self.oldScale floatValue]);
    
    NSValue *downValue = [_leftDictionary objectForKey:@"down"];
    
    CGPoint down = CGPointMake([downValue CGPointValue].x*[self.oldScale floatValue], [downValue CGPointValue].y*[self.oldScale floatValue]);
    
    CGFloat width = right.x-left.x;
    
    NSNumber *radiusValue = [_leftEyeDictionary objectForKey:@"radius"];
    
    CGFloat height = [radiusValue floatValue]*2*[self.oldScale floatValue];
    
    NSValue *centerValue = [_leftEyeDictionary objectForKey:@"center"];
    
    CGPoint center = CGPointMake([centerValue CGPointValue].x*[self.oldScale floatValue], [centerValue CGPointValue].y*[self.oldScale floatValue]);
    
    _leftEyeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, height)];
    
    [_leftEyeView setAlpha:_eyeViewAlpha];
    
    CGFloat upMargin = center.y-height/2;
    
    CGFloat leftMargin = center.x-width/2;
    
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, height, height)];
    
    [_leftImageView setCenter:_leftEyeView.center];
    
    [_leftImageView setImage:[UIImage imageNamed:@"2.png"]];
    
    [_leftEyeView addSubview:_leftImageView];
    
    [_leftEyeView setCenter:center];
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    
    shape.fillColor = [[UIColor redColor] CGColor];
    
    CGPoint upBerzierPoint = CGPointMake(up.x-leftMargin, up.y-upMargin);
    
    CGPoint leftBerzierPoint = CGPointMake(left.x-leftMargin, left.y-upMargin);
    
    CGPoint rightBerzierPoint = CGPointMake(right.x-leftMargin, right.y-upMargin);
    
    CGPoint downBerzierPoint = CGPointMake(down.x-leftMargin, down.y-upMargin);
    
    UIBezierPath *pathLeft = [UIBezierPath bezierPath];
    
    [pathLeft moveToPoint:leftBerzierPoint];
    
    float upControlX = upBerzierPoint.x * 2 - ((leftBerzierPoint.x + rightBerzierPoint.x) / 2);
    float upControlY = upBerzierPoint.y * 2 - ((leftBerzierPoint.y + rightBerzierPoint.y) / 2);

    
    [pathLeft addQuadCurveToPoint:rightBerzierPoint controlPoint:CGPointMake(upControlX, upControlY)];
    
    UIBezierPath *pathLeft1 = [UIBezierPath bezierPath];
    
    [pathLeft1 moveToPoint:rightBerzierPoint];
    
    float downControlX = downBerzierPoint.x * 2 - ((leftBerzierPoint.x + rightBerzierPoint.x) / 2);
    float downControlY = downBerzierPoint.y * 2 - ((leftBerzierPoint.y + rightBerzierPoint.y) / 2);

    
    [pathLeft1 addQuadCurveToPoint:leftBerzierPoint controlPoint:CGPointMake(downControlX, downControlY)];
    
    [pathLeft appendPath:pathLeft1];
    
    shape.path = pathLeft.CGPath;
    
    shape.lineWidth = 1;
    
    [_leftEyeView.layer setMask:shape];
    
    [self.scrollView.layer addSublayer:_leftEyeView.layer];
    
    //rightImageView
    
    NSValue *rightLeftValue = [_rightDictionary objectForKey:@"left"];
    
    CGPoint rightLeft = CGPointMake([rightLeftValue CGPointValue].x*[self.oldScale floatValue], [rightLeftValue CGPointValue].y*[self.oldScale floatValue]);
    
    NSValue *rightRightValue = [_rightDictionary objectForKey:@"right"];
    
    CGPoint rightRight = CGPointMake([rightRightValue CGPointValue].x*[self.oldScale floatValue], [rightRightValue CGPointValue].y*[self.oldScale floatValue]);
    
    NSValue *rightUpValue = [_rightDictionary objectForKey:@"up"];
    
    CGPoint rightUp = CGPointMake([rightUpValue CGPointValue].x*[self.oldScale floatValue], [rightUpValue CGPointValue].y*[self.oldScale floatValue]);
    
    NSValue *rightDownValue = [_rightDictionary objectForKey:@"down"];
    
    CGPoint rightDown = CGPointMake([rightDownValue CGPointValue].x*[self.oldScale floatValue], [rightDownValue CGPointValue].y*[self.oldScale floatValue]);
    
    CGFloat rightWidth = rightRight.x-rightLeft.x;
    
    NSNumber *rightRadiusValue = [_rightEyeDictionary objectForKey:@"radius"];
    
    CGFloat rightHeight = [rightRadiusValue floatValue]*2*[self.oldScale floatValue];
    
    NSValue *rightCenterValue = [_rightEyeDictionary objectForKey:@"center"];
    
    CGPoint rightCenter = CGPointMake([rightCenterValue CGPointValue].x*[self.oldScale floatValue], [rightCenterValue CGPointValue].y*[self.oldScale floatValue]);
    
    _rightEyeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, rightWidth, rightHeight)];
    
    [_rightEyeView setAlpha:_eyeViewAlpha];
    
    CGFloat rightUpMargin = rightCenter.y-rightHeight/2;
    
    CGFloat rightLeftMargin = rightCenter.x-rightWidth/2;
    
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, rightHeight, rightHeight)];
    
    [_rightImageView setCenter:_rightEyeView.center];
    
    [_rightImageView setImage:[UIImage imageNamed:@"2.png"]];
    
    [_rightEyeView addSubview:_rightImageView];
    
    [_rightEyeView setCenter:rightCenter];
    
    CAShapeLayer* rightShape = [CAShapeLayer layer];
    
    rightShape.fillColor = [[UIColor redColor] CGColor];
    
    CGPoint rightUpBerzierPoint = CGPointMake(rightUp.x-rightLeftMargin, rightUp.y-rightUpMargin);
    
    CGPoint rightLeftBerzierPoint = CGPointMake(rightLeft.x-rightLeftMargin, rightLeft.y-rightUpMargin);
    
    CGPoint rightRightBerzierPoint = CGPointMake(rightRight.x-rightLeftMargin, rightRight.y-rightUpMargin);
    
    CGPoint rightDownBerzierPoint = CGPointMake(rightDown.x-rightLeftMargin, rightDown.y-rightUpMargin);
    
    UIBezierPath *rightPathLeft = [UIBezierPath bezierPath];
    
    [rightPathLeft moveToPoint:rightLeftBerzierPoint];
    
    float rightUpControlX = rightUpBerzierPoint.x * 2 - ((rightLeftBerzierPoint.x + rightRightBerzierPoint.x) / 2);
    float rightUpControlY = rightUpBerzierPoint.y * 2 - ((rightLeftBerzierPoint.y + rightRightBerzierPoint.y) / 2);
    
    [rightPathLeft addQuadCurveToPoint:rightRightBerzierPoint controlPoint:CGPointMake(rightUpControlX, rightUpControlY)];
    
    UIBezierPath *rightPathLeft1 = [UIBezierPath bezierPath];
    
    [rightPathLeft1 moveToPoint:rightRightBerzierPoint];
    
    float rightDownControlX = rightDownBerzierPoint.x * 2 - ((rightLeftBerzierPoint.x + rightRightBerzierPoint.x) / 2);
    float rightDownControlY = rightDownBerzierPoint.y * 2 - ((rightLeftBerzierPoint.y + rightRightBerzierPoint.y) / 2);
    
    [rightPathLeft1 addQuadCurveToPoint:rightLeftBerzierPoint controlPoint:CGPointMake(rightDownControlX, rightDownControlY)];
    
    [rightPathLeft appendPath:rightPathLeft1];
    
    rightShape.path = rightPathLeft.CGPath;
    
    rightShape.lineWidth = 1;
    
    [_rightEyeView.layer setMask:rightShape];
    
    [self.scrollView.layer addSublayer:_rightEyeView.layer];

}

-(void)pushViewController:(int)type{
    
    if (type==0) {
        
        BOOL isHave = NO;
        
        ViewController *viewController = [[ViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:viewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:viewController animated:NO];
        }
        
    }
    
    if (type == 2) {
        
        BOOL isHave = NO;
        
        MarketViewController *marketViewController = [[MarketViewController alloc] init];
        
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:marketViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:marketViewController animated:NO];
        }
        
    }
    
    if (type == 3) {
        
        BOOL isHave = NO;
        
        CartDetailViewController *cartDetailViewController = [[CartDetailViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:cartDetailViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:cartDetailViewController animated:NO];
        }
        
    }
    
    if (type == 4) {
        BOOL isHave = NO;
        
        UserInfoViewController *userInfoViewController = [[UserInfoViewController alloc] init];
        
        for (UIViewController *uiViewController in self.navigationController.viewControllers) {
            if ([uiViewController isKindOfClass:userInfoViewController.class]) {
                isHave = YES;
                [self.navigationController popToViewController:uiViewController animated:NO];
            }
        }
        
        if (!isHave) {
            [self.navigationController pushViewController:userInfoViewController animated:NO];
        }
    }
    
}

- (void)getPhoto:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if ((button.tag-2000) == 0) {
        // 拍照
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    } else if ((button.tag-2000) == 1) {
        // 从相册中选取
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    }else if ((button.tag-2000) == 2) {
        // 从相册中选取
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             NSLog(@"Picker View Controller is presented");
                         }];
        
    }else if ((button.tag-2000) == 3) {
        
        _steepName = @"one";
        
        for (UIView *view in self.scrollView.subviews) {
            if (![view isKindOfClass:[self.imageView class]]) {
                [view removeFromSuperview];
            }
        }
        
        [_slider removeFromSuperview];
        
        _slider = nil;
        
        for (UIView *view in [_footView subviews]) {
            [view removeFromSuperview];
        }
        
        [_colorEyeScrollView removeFromSuperview];
        
        _colorEyeScrollView = nil;
        
//        for (UIView *view in self.scrollView.subviews) {
//            if (![view isKindOfClass:[self.imageView class]]) {
//                [view removeFromSuperview];
//            }
//        }
        
        [_leftEyeView removeFromSuperview];
        
        _leftEyeView = nil;
        
        [_rightEyeView removeFromSuperview];
        
        _rightEyeView = nil;
        
        [self getFaceEyeViewAndTool];
        
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        _steepName = @"one";
        
        for (UIView *view in self.scrollView.subviews) {
            if (![view isKindOfClass:[self.imageView class]]) {
                [view removeFromSuperview];
            }
        }
        
        [_slider removeFromSuperview];
        
        _slider = nil;
        
        for (UIView *view in [_footView subviews]) {
            [view removeFromSuperview];
        }
        
        [_colorEyeScrollView removeFromSuperview];
        
        _colorEyeScrollView = nil;
        
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        _defaultImageStr = @"";
        
        self.imageView.image = portraitImg;
        
        NSLog(@"%f,%f",portraitImg.size.width,portraitImg.size.height);
        
        UIImage *newImg = [self scaleImage:self.imageView.image];//图片根据imgV的frame进行重新缩放生成
        
        NSLog(@"%f,%f",newImg.size.width,newImg.size.height);
        
        self.imageView.image = newImg;
        
        [self getFaceEyeViewAndTool];
        
    }];
}

@end
