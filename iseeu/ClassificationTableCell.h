//
//  ClassificationTableCell.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/24.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassificationModel.h"

#import "UIImageView+WebCache.h"

@interface ClassificationTableCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withModel:(ClassificationModel *)_classificationModel;

@end
