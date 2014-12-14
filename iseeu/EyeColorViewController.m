//
//  EyeColorViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/14.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "EyeColorViewController.h"

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
    
    self.oldScale = [NSNumber numberWithFloat:self.scrollView.minimumZoomScale];
    
    [self.scrollView setBouncesZoom:NO];
    
    self.centerPoint = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    self.realCenterPoint = self.centerPoint;
    
    self.upPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y-52);
    
    self.realUpPoint = self.upPoint;
    
    self.rightPoint = CGPointMake(self.centerPoint.x+51, self.centerPoint.y);
    
    self.realRightPoint = self.rightPoint;
    
    self.downPoint = CGPointMake(self.centerPoint.x, self.centerPoint.y+51);
    
    self.realDownPoint = self.downPoint;
    
    self.leftPoint = CGPointMake(self.centerPoint.x-52, self.centerPoint.y);
    
    self.realLeftPoint = self.leftPoint;
    
    NSLog(@"%f,%f",self.centerPoint.x,self.centerPoint.y);
    
    [self drawRect];
    
    [self.centerView setHidden:NO];
    
    [self.scrollView addSubview:self.upView];
    
    [self.scrollView addSubview:self.rightView];
    
    [self.scrollView addSubview:self.downView];
    
    [self.scrollView addSubview:self.leftView];
    
    [self.scrollView addSubview:self.centerView];
    
    [self.view addSubview:self.scrollView];
    
    self.commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.commitButton setFrame:CGRectMake(10.0, 30.0, 60.0, 10.0)];
    
    [self.commitButton setTitle:@"试戴" forState:UIControlStateNormal];
    
    [self.commitButton addTarget:self action:@selector(showSelectView) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:self.commitButton];
    
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
}

-(void)drawRect{
    
    //眼部的图片跟缩放的最大倍数相同
    self.eyeView = [[EyeView alloc] initWithFrame:CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width*5, self.scrollView.frame.size.height*5)];
    
    self.eyeView.tag = 6;
    
    [self.eyeView setCenterPoint:CGPointMake(self.realCenterPoint.x*[self.oldScale floatValue], self.realCenterPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setUpPoint:CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setRightPoint:CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setDownPoint:CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setLeftPoint:CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue])];
    
    [self.eyeView setViewDelegate:self];
    
    [self.eyeView setBackgroundColor:[UIColor clearColor]];
    
    [self.scrollView addSubview:self.eyeView];
    
    [self.upView removeFromSuperview];
    [self.rightView removeFromSuperview];
    
    [self.leftView removeFromSuperview];
    
    [self.downView removeFromSuperview];
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*[self.oldScale floatValue], self.realUpPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*[self.oldScale floatValue], self.realRightPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*[self.oldScale floatValue], self.realDownPoint.y*[self.oldScale floatValue]);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue], self.realLeftPoint.y*[self.oldScale floatValue]);
    
    self.upView = [self getView:1 withCenter:relativeUpPoint];
    
    self.rightView = [self getView:2 withCenter:relativeRightPoint];
    
    self.leftView = [self getView:3 withCenter:relativeLeftPoint];
    
    self.downView = [self getView:4 withCenter:relativeDownPoint];
    
    self.centerView = [self getView:5 withCenter:self.centerPoint];
    
    [self.centerView setHidden:YES];
    
    [self.scrollView addSubview:self.upView];
    
    [self.scrollView addSubview:self.rightView];
    
    [self.scrollView addSubview:self.downView];
    
    [self.scrollView addSubview:self.leftView];
    
    [self.scrollView addSubview:self.centerView];
    
}

-(UIView *)getView:(int)tag
         withCenter:(CGPoint)centerPoint{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"number_bg"]]];
    //left
    if (tag == 3) {
        
        CGPoint leftPoint = CGPointMake(centerPoint.x-20.0, centerPoint.y);
        
        [view setCenter:leftPoint];
    
    }else if(tag==2){//right
        
        CGPoint rightPoint = CGPointMake(centerPoint.x+20.0, centerPoint.y);
        
        [view setCenter:rightPoint];
        
    }else{
        
        [view setCenter:centerPoint];
        
    }
    
    view.tag = tag;
    
//    [view setBackgroundColor:[UIColor redColor]];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
    
    [view addGestureRecognizer:longPress];
    
    return view;
    
    
}

//长按调用的方法
- (void)longAction:(UILongPressGestureRecognizer *)recognizer
{
    UIView *view = (UIView *)recognizer.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {//长按开始
        
        startPoint = [recognizer locationInView:recognizer.view];
        
        NSLog(@"one%f,%f",startPoint.x,startPoint.y);
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {//长按移动
        
        UIView *view = recognizer.view;
        
        CGPoint newPoint = [recognizer locationInView:recognizer.view];
        
        NSLog(@"two%f,%f",newPoint.x,newPoint.y);
        
        CGFloat deltaX = newPoint.x - startPoint.x;
        
        CGFloat deltaY = newPoint.y - startPoint.y;
        
        CGPoint point = CGPointMake(view.center.x + deltaX, view.center.y + deltaY);
        
        NSLog(@"three%f,%f",point.x,point.y);
        
        if (view.tag==1) {
            
            self.upPoint = point;
            
            self.realUpPoint = CGPointMake(self.upPoint.x/[self.oldScale floatValue], self.upPoint.y/[self.oldScale floatValue]);
            
            [self.upView setCenter:self.upPoint];
            
            [self.eyeView setUpPoint:point];
            
            [self.eyeView setNeedsDisplay];
            
        }else if (view.tag==2) {
            
            self.rightPoint = point;
            
            self.realRightPoint = CGPointMake(self.rightPoint.x/[self.oldScale floatValue], self.rightPoint.y/[self.oldScale floatValue]);
            
            [self.rightView setCenter:CGPointMake(self.rightPoint.x, self.rightPoint.y)];
            
            [self.eyeView setRightPoint:point];
            
            [self.eyeView setNeedsDisplay];
            
        }else if (view.tag==3) {
            
            self.leftPoint = point;
            
            self.realLeftPoint = CGPointMake(self.leftPoint.x/[self.oldScale floatValue], self.leftPoint.y/[self.oldScale floatValue]);
            
            [self.leftView setCenter:CGPointMake(self.leftPoint.x, self.leftPoint.y)];
            
            [self.eyeView setLeftPoint:point];
            
            [self.eyeView setNeedsDisplay];
            
        }else if (view.tag==4) {
            
            self.downPoint = point;
            
            self.realDownPoint = CGPointMake(self.downPoint.x/[self.oldScale floatValue], self.downPoint.y/[self.oldScale floatValue]);
            
            [self.downView setCenter:self.downPoint];
            
            [self.eyeView setDownPoint:point];
            
            [self.eyeView setNeedsDisplay];
            
        }else if (view.tag==5) {
            
            NSLog(@"%f,%f",self.imageView.center.x,self.imageView.center.y);
            
            self.centerPoint = point;
            
            self.realCenterPoint = CGPointMake(self.centerPoint.x/[self.oldScale floatValue], self.centerPoint.y/[self.oldScale floatValue]);
            
            self.realUpPoint = CGPointMake(self.centerPoint.x/[self.oldScale floatValue], (self.centerPoint.y-52)/[self.oldScale floatValue]);
            
            self.realRightPoint = CGPointMake((self.centerPoint.x+51)/[self.oldScale floatValue], self.centerPoint.y/[self.oldScale floatValue]);
            
            self.realLeftPoint = CGPointMake((self.centerPoint.x-52)/[self.oldScale floatValue], self.centerPoint.y/[self.oldScale floatValue]);
            
            self.realDownPoint = CGPointMake(self.centerPoint.x/[self.oldScale floatValue], (self.centerPoint.y+51)/[self.oldScale floatValue]);
            
            NSLog(@"%f,%f",self.centerPoint.x,self.centerPoint.y);
            
            [self.centerView setCenter:self.centerPoint];
            
            [self.upView setCenter:CGPointMake(self.centerPoint.x, self.centerPoint.y-52)];
            
            [self.rightView setCenter:CGPointMake(self.centerPoint.x+51, self.centerPoint.y)];
            
            [self.leftView setCenter:CGPointMake(self.centerPoint.x-52, self.centerPoint.y)];
            
            [self.downView setCenter:CGPointMake(self.centerPoint.x, self.centerPoint.y+51)];
            
            [self.eyeView setUpPoint:CGPointMake(self.centerPoint.x, self.centerPoint.y-52)];
            
            [self.eyeView setRightPoint:CGPointMake(self.centerPoint.x+51, self.centerPoint.y)];
            
            [self.eyeView setLeftPoint:CGPointMake(self.centerPoint.x-52, self.centerPoint.y)];
            
            [self.eyeView setDownPoint:CGPointMake(self.centerPoint.x, self.centerPoint.y+51)];
            
            [self.eyeView setCenterPoint:self.centerPoint];
            
            [self.eyeView setViewDelegate:self];
            
            [self.eyeView setNeedsDisplay];
            
        }
    }
    //        else if (recognizer.state == UIGestureRecognizerStateEnded) {//长按结束
    //        [UIView animateWithDuration:0.3 animations:^{
    //            imageView.transform = CGAffineTransformIdentity;
    //            if (!isContain) {
    //                imageView.center = originPoint;
    //            }
    //        }];
    //    }
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
    
    [self.centerView setHidden:NO];
    
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
    [self.upView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y-52, 40, 40)];
    
    [self.rightView setFrame:CGRectMake(self.centerPoint.x+51, self.centerPoint.y, 5, 5)];
    
    [self.leftView setFrame:CGRectMake(self.centerPoint.x-52, self.centerPoint.y, 5, 5)];
    
    [self.downView setFrame:CGRectMake(self.centerPoint.x, self.centerPoint.y+51, 5, 5)];
    
    CGPoint relativeUpPoint = CGPointMake(self.realUpPoint.x*scale, self.realUpPoint.y*scale);
    
    CGPoint relativeRightPoint = CGPointMake(self.realRightPoint.x*scale, self.realRightPoint.y*scale);
    
    CGPoint relativeDownPoint = CGPointMake(self.realDownPoint.x*scale, self.realDownPoint.y*scale);
    
    CGPoint relativeLeftPoint = CGPointMake(self.realLeftPoint.x*scale, self.realLeftPoint.y*scale);
    
    [self.centerView setFrame:CGRectMake(relativeCenterPoint.x, relativeCenterPoint.y, 5, 5)];
    
    [self.upView setFrame:CGRectMake(relativeUpPoint.x, relativeUpPoint.y, 40, 40)];
    
    [self.rightView setFrame:CGRectMake(relativeRightPoint.x, relativeRightPoint.y, 5, 5)];
    
    [self.leftView setFrame:CGRectMake(relativeLeftPoint.x, relativeLeftPoint.y, 5, 5)];
    
    [self.downView setFrame:CGRectMake(relativeDownPoint.x, relativeDownPoint.y, 5, 5)];
    
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
    
    NSLog(@"upPath");
    
    self.path = paths;
    
}

-(void)showSelectView{
    
    [self.upView setHidden:YES];
    
    [self.rightView setHidden:YES];
    
    [self.downView setHidden:YES];
    
    [self.leftView setHidden:YES];
    
    [self.centerView setHidden:YES];
    
    [self.eyeView setHidden:YES];
    
    if (self.selectImageView !=nil) {
        [self.selectImageView removeFromSuperview];
    }
    
    UIImage *meitongImage = [UIImage imageNamed:@"metong1"];
    
    CGFloat imageViewWidth = self.realRightPoint.x*[self.oldScale floatValue]-self.realLeftPoint.x*[self.oldScale floatValue];
    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, imageViewWidth, imageViewWidth)];
    
    self.selectImageView.image = meitongImage;
    
    CGPoint imageCenter = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue]+(self.realRightPoint.x*[self.oldScale floatValue]-self.realLeftPoint.x*[self.oldScale floatValue])/2,self.realUpPoint.y*[self.oldScale floatValue]+(self.realDownPoint.y*[self.oldScale floatValue]-self.realUpPoint.y*[self.oldScale floatValue])/2);
    
    self.selectImageView.center = imageCenter ;
    
    //相对于selectImageView;
    CGPoint leftSelectPoint = CGPointMake(0, self.selectImageView.frame.size.height/2);
    //实际点
    CGPoint imageRealLeftPoint = CGPointMake(self.realLeftPoint.x*[self.oldScale floatValue],self.realLeftPoint.y*[self.oldScale floatValue]);
    
    CGPoint imageRealUpPoint = CGPointMake(imageRealLeftPoint.x+imageViewWidth/2, imageRealLeftPoint.y-imageViewWidth/2);
    
    CGPoint imageRealDownPoint = CGPointMake(imageRealLeftPoint.x+imageViewWidth/2, imageRealLeftPoint.y+imageViewWidth/2);
    
    CGPoint upSelectPoint = CGPointMake(self.selectImageView.frame.size.width/2,0-(imageRealUpPoint.y-self.realUpPoint.y*[self.oldScale floatValue]));
    
    CGPoint rightSelectPoint = CGPointMake(self.selectImageView.frame.size.width, self.selectImageView.frame.size.height/2);
    
    CGPoint downSelectPoint = CGPointMake(self.selectImageView.frame.size.width/2+(imageRealDownPoint.x-self.realDownPoint.x*[self.oldScale floatValue]),self.selectImageView.frame.size.height-(imageRealDownPoint.y-self.realDownPoint.y*[self.oldScale floatValue]));
    
    UIBezierPath *paths = [UIBezierPath bezierPath];
    
    [paths moveToPoint:leftSelectPoint];
    
    [paths addQuadCurveToPoint:rightSelectPoint controlPoint:upSelectPoint];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:rightSelectPoint];
    
    [path1 addQuadCurveToPoint:leftSelectPoint controlPoint:downSelectPoint];
    
    [paths appendPath:path1];
    
    [paths stroke];
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    
    shape.fillColor = [[UIColor redColor] CGColor];
    
    shape.path = paths.CGPath;
    
    [self.selectImageView.layer setMask: shape];
    
    [self.scrollView.layer addSublayer:self.selectImageView.layer];
    
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


@end
