//
//  ModifyAddressViewController.h
//  iseeu
//
//  Created by 朱孟乐 on 14/12/7.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FMDB/FMDB.h>

#import "Address.h"

#import <AFNetworking/AFNetworking.h>

#import <MBProgressHUD/MBProgressHUD.h>

@interface ModifyAddressViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@property(strong,nonatomic)UITextField *_addressField;

@property(strong,nonatomic)UITextView *_addressText;

@property(strong,nonatomic)FMDatabase *_db;

@property(strong,nonatomic)NSString *_uid;

@property(strong,nonatomic)UIPickerView *_pickerView;

@property(strong,nonatomic)NSMutableArray *_provinceIdArray;

@property(strong,nonatomic)NSMutableArray *_cityIdArray;

@property(nonatomic)int _provinceIdRow;

@property(nonatomic)int _cityIdRow;

@property(strong,nonatomic)NSString *_provinceId;

@property(strong,nonatomic)NSString *_cityId;

@property(strong,nonatomic)UIToolbar *_toolbarCancelDone;

@property(strong,nonatomic)MBProgressHUD *_hud;

@end
