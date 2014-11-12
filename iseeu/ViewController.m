//
//  ViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/12.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize _hud;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    
    [self.navigationController.view addSubview:_hud];
    
    _hud.delegate = self;
    
    [_hud setLabelText:@"加载中..."];
    
    [_hud showWhileExecuting:@selector(showHud) onTarget:self withObject:nil animated:YES];
    
}

-(void)showHud{

    sleep(3);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
