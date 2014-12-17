//
//  EyeColorViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeColorViewController.h"

#define MINDISTANCE 1.0f

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

@synthesize _radius;

@synthesize rectFaceDetect;

@synthesize _leftCenterPoint;

@synthesize _rightCenterPoint;

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
    
    _steepName = @"one";
    
     _radius = 30.0f;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
    [[self view] addGestureRecognizer:pan];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    UIImage *image=[UIImage imageNamed:@"image1.jpg"];
    
    self.imageView=[[UIImageView alloc]initWithImage:image];
    
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
    
    [self.scrollView setZoomScale:3.0];
    
    self.oldScale = [NSNumber numberWithFloat:self.scrollView.zoomScale];
    
    [self.view addSubview:self.scrollView];
    
    [self faceDetect:self.imageView.image];
    
}

-(void)NextConvertEye{

    if ([_steepName isEqualToString:@"one"]) {
        _steepName = @"two";
    }else if([_steepName isEqualToString:@"two"]) {
        _steepName = @"three";
    }else if([_steepName isEqualToString:@"three"]) {
        _steepName = @"four";
    }
    
    if ([_steepName isEqualToString:@"two"]) {
        
        [self.eyeView removeFromSuperview];
        
        [self.upView removeFromSuperview];
        
        [self.rightView removeFromSuperview];
        
        [self.leftView removeFromSuperview];
        
        [self.downView removeFromSuperview];
        
        [self.centerView removeFromSuperview];
        
        _eyeCircleView = [[EyeCircleView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
        
        [_eyeCircleView setBackgroundColor:[UIColor clearColor]];
        
        _eyeCircleView.alpha=0.1;
        
        [_eyeCircleView setCenterPoint:CGPointMake(_leftCenterPoint.x*[self.oldScale floatValue], _leftCenterPoint.y*[self.oldScale floatValue])];
        
        [_eyeCircleView setRadius:_radius];
        
        [self.scrollView addSubview:_eyeCircleView];
        
        UISlider *eyeSlider = [[UISlider alloc] initWithFrame:CGRectMake(-80.0, 200.0, 200.0, 20.0)];
        
        [eyeSlider setTransform:[self transformForExpandDirection]];
        
        [self.view addSubview:eyeSlider];
        
        eyeSlider.minimumValue = 1.0;
        
        eyeSlider.value = _radius;
        
        eyeSlider.maximumValue = 100.0;
        
        [eyeSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
    }else if ([_steepName isEqualToString:@"three"]) {
        
        
        
    }else if ([_steepName isEqualToString:@"four"]) {
        
        
        
    }
    
}

-(IBAction)sliderChanged:(id)sender{
    
    UISlider *mySlider = (UISlider *)sender;
    
    _radius = mySlider.value;
    
    [_eyeCircleView setRadius:_radius];
    
    [_eyeCircleView setNeedsDisplay];
    
    NSLog(@"SliderValue %f",mySlider.value);
    
}

- (CGAffineTransform)transformForExpandDirection {
    
        return CGAffineTransformMakeRotation(-M_PI/2.f);
}

-(void)drawRect{
    
    [self.scrollView setContentOffset:CGPointMake(_leftCenterPoint.x+80.0, _leftCenterPoint.y)];
    
    self.centerPoint = _leftCenterPoint;
    
    self.realCenterPoint = self.centerPoint;
    
    self.upPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y-12);
    
    self.realUpPoint = self.upPoint;
    
    self.rightPoint = CGPointMake(self.centerPoint.x+21, self.centerPoint.y);
    
    self.realRightPoint = self.rightPoint;
    
    self.downPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y+11);
    
    self.realDownPoint = self.downPoint;
    
    self.leftPoint = CGPointMake(self.centerPoint.x-22, self.centerPoint.y);
    
    self.realLeftPoint = self.leftPoint;
    
    NSLog(@"%f,%f",self.centerPoint.x,self.centerPoint.y);
    
    self.commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.commitButton setFrame:CGRectMake(10.0, 30.0, 60.0, 10.0)];
    
    [self.commitButton setTitle:@"试戴" forState:UIControlStateNormal];
    
    [self.commitButton addTarget:self action:@selector(showSelectView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.commitButton];
    
    self.draw = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.draw setFrame:CGRectMake(10.0, 50.0, 60.0, 10.0)];
    
    [self.draw setTitle:@"调整" forState:UIControlStateNormal];
    
    [self.draw addTarget:self action:@selector(drawRect) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:self.draw];
    
    self.resizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.resizeButton setFrame:CGRectMake(10.0, 70.0, 60.0, 10.0)];
    
    [self.resizeButton setTitle:@"重绘" forState:UIControlStateNormal];
    
    [self.resizeButton addTarget:self action:@selector(resize) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:self.resizeButton];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [nextButton setFrame:CGRectMake(self.view.frame.size.width-40.0, self.view.frame.size.height-64-49-40.0, 10, 20.0)];
    
    [nextButton setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    
    [nextButton addTarget:self action:@selector(NextConvertEye) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
    //眼部的图片跟缩放的最大倍数相同
    self.eyeView = [[EyeView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
    
    self.eyeView.alpha=0.2;
    
    self.eyeView.tag = 6;
    
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
    
//    point = CGPointMake(point.x*[self.oldScale floatValue], point.y*[self.oldScale floatValue]);
    
    NSLog(@"%f,%f",point.x,point.y);
    
    CGFloat x = 0.0f;
    
    if (_gestureStartPoint.x>0) {
        
        x = point.x-_gestureStartPoint.x;
        
    }
    
    CGFloat y = 0.0f;
    
    if (_gestureStartPoint.y>0) {
        
        y = point.y-_gestureStartPoint.y;
        
    }
    
    _gestureStartPoint = point;
    
//    NSLog(@"start%f,start%f,%f,%f",_gestureStartPoint.x,_gestureStartPoint.y,x,y);
//    
    NSLog(@"_originPointName:%@",_originPointName);
    
    CGPoint relativeCenterPoint = CGPointMake(self.realCenterPoint.x*[self.oldScale floatValue], self.realCenterPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue]);
    
    CGPoint center = CGPointMake(self.scrollView.frame.size.width/2, self.scrollView.frame.size.height/2);
    
    CGFloat height = 40.0f;
    
    NSLog(@"%f,%f",center.x,center.y);
    
    if ([_steepName isEqualToString:@"one"]) {
        
        if (point.x<center.x) {
            
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
                
            }else if(point.y>center.y-height&&point.y<center.y+height){
                
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
            
        }else if (point.x>center.x){
            
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
                
            }else if(point.y>center.y-height&&point.y<center.y+height){
                
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
        
    }else if([_steepName isEqualToString:@"two"]){
    
        self.centerPoint = CGPointMake(self.centerPoint.x+x, self.centerPoint.y+y);
        
        [_eyeCircleView setCenterPoint:self.centerPoint];
        
        [_eyeCircleView setRadius:_radius];
        
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
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    [self.upView setHidden:NO];
    
    [self.rightView setHidden:NO];
    
    [self.downView setHidden:NO];
    
    [self.leftView setHidden:NO];
    
    [self.centerView setHidden:NO];
    
    [self.eyeView setHidden:NO];
    
    self.oldScale = [NSNumber numberWithFloat:scale];
    
    //不缩放时定位中心点后，缩放时点不会改变
    
    CGPoint relativeCenterPoint = CGPointMake(self.realCenterPoint.x*scale, self.realCenterPoint.y*scale);
    
    [self.upView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y-12, 20, 20)];
    
    [self.rightView setFrame:CGRectMake(self.centerPoint.x+21, self.centerPoint.y, 20, 20)];
    
    [self.leftView setFrame:CGRectMake(self.centerPoint.x-22, self.centerPoint.y, 20, 20)];
    
    [self.downView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y+11, 20, 20)];
    
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
    
    if (self.selectImageView != nil) {
        
        [self showSelectView];
        
    }
    
}

-(void)getPath:(UIBezierPath *)paths{
    
    self.path = paths;
    
}

-(void)showSelectView{
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    
    UIBezierPath *testPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    
    [testPath appendPath:[UIBezierPath bezierPathWithOvalInRect:(CGRect){{100, 100}, 100, 100}]];
    shape.fillRule = kCAFillRuleEvenOdd;
    shape.path = testPath.CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
//    [self.upView setHidden:YES];
//    
//    [self.rightView setHidden:YES];
//    
//    [self.downView setHidden:YES];
//    
//    [self.leftView setHidden:YES];
//    
//    [self.centerView setHidden:YES];
//    
//    [self.eyeView setHidden:YES];
//    
//    if (self.selectImageView !=nil) {
//        [self.selectImageView removeFromSuperview];
//    }
//    
//    UIImage *meitongImage = [UIImage imageNamed:@"metong1"];
//    
//    CGFloat imageViewWidth = self.realRightPoint.x*[self.oldScale floatValue]-self.realLeftPoint.x*[self.oldScale floatValue];
//    
//    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, imageViewWidth, imageViewWidth)];
//    
//    self.selectImageView.image = meitongImage;
//    
//    CGPoint imageCenter = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue]+(self.realRightPoint.x*[self.oldScale floatValue]-self.realLeftPoint.x*[self.oldScale floatValue])/2,self.realUpPoint.y*[self.oldScale floatValue]+(self.realDownPoint.y*[self.oldScale floatValue]-self.realUpPoint.y*[self.oldScale floatValue])/2);
//    
//    self.selectImageView.center = imageCenter ;
//    
//    //相对于selectImageView;
//    CGPoint leftSelectPoint = CGPointMake(0, self.selectImageView.frame.size.height/2);
//    //实际点
//    CGPoint imageRealLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue],self.realLeftPoint.y*[self.oldScale floatValue]);
//    
//    CGPoint imageRealUpPoint = CGPointMake(imageRealLeftPoint.x+imageViewWidth/2, imageRealLeftPoint.y-imageViewWidth/2);
//    
//    CGPoint imageRealDownPoint = CGPointMake(imageRealLeftPoint.x+imageViewWidth/2, imageRealLeftPoint.y+imageViewWidth/2);
//    
//    CGPoint upSelectPoint = CGPointMake(self.selectImageView.frame.size.width/2,0-(imageRealUpPoint.y-self.realUpPoint.y*[self.oldScale floatValue]));
//    
//    CGPoint rightSelectPoint = CGPointMake(self.selectImageView.frame.size.width, self.selectImageView.frame.size.height/2);
//    
//    CGPoint downSelectPoint = CGPointMake(self.selectImageView.frame.size.width/2+(imageRealDownPoint.x-self.realDownPoint.x*[self.oldScale floatValue]),self.selectImageView.frame.size.height-(imageRealDownPoint.y-self.realDownPoint.y*[self.oldScale floatValue]));
//    
//    UIBezierPath *paths = [UIBezierPath bezierPath];
//    
//    [paths moveToPoint:leftSelectPoint];
//    
//    [paths addQuadCurveToPoint:rightSelectPoint controlPoint:upSelectPoint];
//    
//    UIBezierPath *path1 = [UIBezierPath bezierPath];
//    
//    [path1 moveToPoint:rightSelectPoint];
//    
//    [path1 addQuadCurveToPoint:leftSelectPoint controlPoint:downSelectPoint];
//    
//    [paths appendPath:path1];
//    
//    [paths stroke];
//    
//    CAShapeLayer* shape = [CAShapeLayer layer];
//    
//    shape.fillColor = [[UIColor redColor] CGColor];
//    
//    shape.path = paths.CGPath;
//    
//    [self.selectImageView.layer setMask: shape];
//    
//    [self.scrollView.layer addSublayer:self.selectImageView.layer];
    
}

-(void)resize{
    
    [self.upView setHidden:NO];
    
    [self.rightView setHidden:NO];
    
    [self.downView setHidden:NO];
    
    [self.leftView setHidden:NO];
    
    [self.centerView setHidden:NO];
    
    [self.eyeView setHidden:NO];
    
    if (self.selectImageView !=nil) {
        [self.selectImageView removeFromSuperview];
    }
    
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
        //旋转180，仅y
        CGRect aRect = f.bounds;
        aRect.origin.y = self.scrollView.bounds.size.height - aRect.size.height - aRect.origin.y;//self.bounds.size
        
//        UIView *vv = [[UIView alloc]initWithFrame:aRect];
//        vv.tag = 100;
//        [vv setTransform:CGAffineTransformMakeScale(1, -1)];
//        vv.backgroundColor = [UIColor redColor];
//        vv.alpha = 0.6;
//        [self.scrollView addSubview:vv];
        
        self.rectFaceDetect = aRect;
        
        
        NSLog(@"%@",NSStringFromCGRect(f.bounds));
        if (f.hasLeftEyePosition){
            printf("Left eye %g %g\n", f.leftEyePosition.x, f.leftEyePosition.y);
            
            _leftCenterPoint = CGPointMake(f.leftEyePosition.x, self.scrollView.bounds.size.height-f.leftEyePosition.y);
            
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
            
            _rightCenterPoint = CGPointMake(f.rightEyePosition.x, f.rightEyePosition.y);

        }
        if (f.hasMouthPosition)
        {
            printf("Mouth %g %g\n", f.mouthPosition.x, f.mouthPosition.y);
            
        }
    }
    
    [self drawRect];
    
}

@end
