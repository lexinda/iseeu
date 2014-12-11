//
//  CartDetailTableViewCell.h
//  ;
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"

#import <FMDB/FMDB.h>

#import "CartActionDetail.h"

#import "DeleteReloadCartDetail.h"

@interface CartDetailTableViewCell : UITableViewCell

@property(strong,nonatomic)UITextField *_numberField;

@property(strong,nonatomic)UILabel *_priceLabel;

@property(strong,nonatomic)NSDictionary *_data;

@property(strong,nonatomic)UIButton *_cutButton;

@property(strong,nonatomic)UIButton *_addButton;

@property(strong,nonatomic)UILabel *_titleLabel;

@property(strong,nonatomic)id<DeleteReloadCartDetail> _reloadDelegate;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCartDetail:(NSDictionary *)dictionary;

@end
