//
//  CartDetail.h
//  iseeu
//
//  Created by 朱孟乐 on 14/11/17.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartDetail : NSObject

//商品ID
@property(strong,nonatomic)NSString *id;
//商品类型
@property(strong,nonatomic)NSString *shoptype_id;
//商品的名称
@property(strong,nonatomic)NSString *titleName;
//商品的编号
@property(strong,nonatomic)NSString *pianhao;
//商品的关键字
@property(strong,nonatomic)NSString *keywords;
//商品的品牌
@property(strong,nonatomic)NSString *brand_id;
//商品的计量单位
@property(strong,nonatomic)NSString *danwei_id;
//商品的内容
@property(strong,nonatomic)NSString *content;
//商品的是否上架销售
@property(strong,nonatomic)NSString *shangjia;
//商品的销售价
@property(strong,nonatomic)NSString *price_xiaoshou;
//商品的成本价
@property(strong,nonatomic)NSString *price_cenben;
//商品的市场价
@property(strong,nonatomic)NSString *price_shichang;
//商品的货号
//商品的重量
@property(strong,nonatomic)NSString *zhong;
//商品的积分
@property(strong,nonatomic)NSString *fen;
//商品的直径
@property(strong,nonatomic)NSString *zhijin;
//商品的镜片厚度
@property(strong,nonatomic)NSString *hou;
//商品的含水量
@property(strong,nonatomic)NSString *hang;
//商品的效果类型
@property(strong,nonatomic)NSString *xiaoguo;
//商品的使用周期
@property(strong,nonatomic)NSString *zhouqi;
//商品的可选度数
@property(strong,nonatomic)NSString *dushu;
//商品的基弧
@property(strong,nonatomic)NSString *jihu;
//商品的颜色
@property(strong,nonatomic)NSString *yanse;
//商品的价格
@property(strong,nonatomic)NSString *price;
//发布时间
@property(strong,nonatomic)NSString *time ;
//商品的首页的模特的展示图片
//	@property(strong,nonatomic)NSString *pic;
//商品的美瞳图片
@property(strong,nonatomic)NSString *pic2;
//商品的简介图片
@property(strong,nonatomic)NSString *pic3;
//商品出售数量
@property(strong,nonatomic)NSString *shu;
/////////////////////////////////////////////////
//商品的可选度数
@property(strong,nonatomic)NSString *dushu_id;
//商品的含水量
@property(strong,nonatomic)NSString *hang_id;

@property(strong,nonatomic)NSString *is_xin;

@property(strong,nonatomic)NSString *jifen;

//商品的基弧
@property(strong,nonatomic)NSString *jihu_id;

//商品的首页的模特的展示图片
@property(strong,nonatomic)NSString *pic;

@property(strong,nonatomic)NSString *ren;

@property(strong,nonatomic)NSString *shopfeilei_id;
//商品的颜色
@property(strong,nonatomic)NSString *yanse_id;

//商品的效果类型
@property(strong,nonatomic)NSString *xiaoguo_id;
//商品的直径
@property(strong,nonatomic)NSString *zhijin_id;
//商品的使用周期
@property(strong,nonatomic)NSString *zhouqi_id;

+(CartDetail *)getCartDetail:(NSDictionary *)dictionary;

@end
