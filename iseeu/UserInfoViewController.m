//
//  UserInfoViewController.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/29.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "UserInfoViewController.h"

@implementation UserInfoViewController

@synthesize _aboutTableView;

@synthesize _tableArray;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"个人中心";
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [leftButton setFrame:CGRectMake(0.0, 0.0, 50.0, 40.0)];
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"allreturn"] forState:UIControlStateNormal];
        
        [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    return self;
    
}

-(void)viewDidLoad{

    [self.view setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 180.0)];
    
    [imageView setImage:[UIImage imageNamed:@"personal_infobalack"]];
    
    [self.view addSubview:imageView];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [loginButton setFrame:CGRectMake((self.view.frame.size.width-100)/2, 150.0, 100.0, 30.0)];
    
    [loginButton setBackgroundImage:[UIImage imageNamed:@"nolongin_submmit"] forState:UIControlStateNormal];
    
    [loginButton addTarget:self action:@selector(pushLoginView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
    
    UIImageView *newShare = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, imageView.frame.origin.y+imageView.frame.size.height+10.0, self.view.frame.size.width-20.0, 45.0)];
    
    [newShare setImage:[UIImage imageNamed:@"new_share"]];
    
    [self.view addSubview:newShare];
    
    _tableArray = [NSArray arrayWithObjects:@"关于Iseeu",@"更多", nil];
    
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(newShare.frame.origin.x, newShare.frame.origin.y+newShare.frame.size.height+10.0, newShare.frame.size.width, 90.0)];
    
    _aboutTableView.delegate = self;
    
    _aboutTableView.dataSource = self;
    
    [self.view addSubview:_aboutTableView];
    
}

-(void)goBack{

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)pushLoginView{

    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_tableArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdetify = @"aboutCell";
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_tableArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%i",indexPath.row);
    
}

@end
