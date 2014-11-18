//
//  CartDetail.m
//  iseeu
//
//  Created by 朱孟乐 on 14/11/17.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "CartDetail.h"

@implementation CartDetail
//商品ID
@synthesize id;
//商品类型
@synthesize shoptype_id;
//商品的名称
@synthesize titleName;
//商品的编号
@synthesize pianhao;
//商品的关键字
@synthesize keywords;
//商品的品牌
@synthesize brand_id;
//商品的计量单位
@synthesize danwei_id;
//商品的内容
@synthesize content;
//商品的是否上架销售
@synthesize shangjia;
//商品的销售价
@synthesize price_xiaoshou;
//商品的成本价
@synthesize price_cenben;
//商品的市场价
@synthesize price_shichang;
//商品的货号
//商品的重量
@synthesize zhong;
//商品的积分
@synthesize fen;
//商品的直径
@synthesize zhijin;
//商品的镜片厚度
@synthesize hou;
//商品的含水量
@synthesize hang;
//商品的效果类型
@synthesize xiaoguo;
//商品的使用周期
@synthesize zhouqi;
//商品的可选度数
@synthesize dushu;
//商品的基弧
@synthesize jihu;
//商品的颜色
@synthesize yanse;
//商品的价格
@synthesize price;
//发布时间
@synthesize time ;
//商品的首页的模特的展示图片
//	@synthesize pic;
//商品的美瞳图片
@synthesize pic2;
//商品的简介图片
@synthesize pic3;
//商品出售数量
@synthesize shu;
////////////////////////////////
//商品的可选度数
@synthesize dushu_id;
//商品的含水量
@synthesize hang_id;

@synthesize is_xin;

@synthesize jifen;

//商品的基弧
@synthesize jihu_id;

//商品的首页的模特的展示图片
@synthesize pic;

@synthesize ren;

@synthesize shopfeilei_id;
//商品的颜色
@synthesize yanse_id;

//商品的效果类型
@synthesize xiaoguo_id;
//商品的直径
@synthesize zhijin_id;
//商品的使用周期
@synthesize zhouqi_id;

+(CartDetail *)getCartDetail:(NSDictionary *)dictionary{

    CartDetail *cartDetail = [[CartDetail alloc] init];
    
    [cartDetail setId:[dictionary objectForKey:@"id"]];
    
    [cartDetail setShoptype_id:[dictionary objectForKey:@"shoptype_id"]];
    
    [cartDetail setTitleName:[dictionary objectForKey:@"title"]];
    
    [cartDetail setPianhao:[dictionary objectForKey:@"pianhao"]];
    
    [cartDetail setKeywords:[dictionary objectForKey:@"keywords"]];
    
    [cartDetail setBrand_id:[dictionary objectForKey:@"brand_id"]];
    
    [cartDetail setDanwei_id:[dictionary objectForKey:@"danwei_id"]];
    
    [cartDetail setContent:[dictionary objectForKey:@"content"]];
    
    [cartDetail setShangjia:[dictionary objectForKey:@"shangjia"]];
    
    [cartDetail setPrice_xiaoshou:[dictionary objectForKey:@"price_xiaoshou"]];
    
    [cartDetail setPrice_cenben:[dictionary objectForKey:@"price_cenben"]];
    
    [cartDetail setPrice_shichang:[dictionary objectForKey:@"price_shichang"]];
    
    [cartDetail setZhong:[dictionary objectForKey:@"zhong"]];
    
    [cartDetail setFen:[dictionary objectForKey:@"fen"]];
    
    [cartDetail setZhijin:[dictionary objectForKey:@"zhijin"]];
    
    [cartDetail setHou:[dictionary objectForKey:@"hou"]];
    
    [cartDetail setHang:[dictionary objectForKey:@"hang"]];
    
    [cartDetail setXiaoguo:[dictionary objectForKey:@"xiaoguo"]];
    
    [cartDetail setZhouqi:[dictionary objectForKey:@"zhouqi"]];
    
    [cartDetail setDushu:[dictionary objectForKey:@"dushu"]];
    
    [cartDetail setJihu:[dictionary objectForKey:@"jihu"]];
    
    [cartDetail setYanse:[dictionary objectForKey:@"yanse"]];
    
    [cartDetail setPrice:[dictionary objectForKey:@"price"]];
    
    [cartDetail setTime:[dictionary objectForKey:@"time"]];
    //商品的首页的模特的展示图片
    //	@synthesize pic;
    
    [cartDetail setPic2:[dictionary objectForKey:@"pic2"]];
    
    [cartDetail setPic3:[dictionary objectForKey:@"pic3"]];
    
    [cartDetail setShu:[dictionary objectForKey:@"shu"]];
    ///////////////////////////////////////////////////////////
    
    [cartDetail setDushu_id:[dictionary objectForKey:@"dushu_id"]];
    
    [cartDetail setHang_id:[dictionary objectForKey:@"hang_id"]];
    
    [cartDetail setIs_xin:[dictionary objectForKey:@"is_xin"]];
    
    [cartDetail setJifen:[dictionary objectForKey:@"jifen"]];
    
    //商品的基弧
    [cartDetail setJihu_id:[dictionary objectForKey:@"jihu_id"]];
    
    //商品的首页的模特的展示图片
    [cartDetail setPic:[dictionary objectForKey:@"pic"]];
    
    [cartDetail setRen:[dictionary objectForKey:@"ren"]];
    
    [cartDetail setShopfeilei_id:[dictionary objectForKey:@"shopfeilei_id"]];
    //商品的颜色
    [cartDetail setYanse_id:[dictionary objectForKey:@"yanse_id"]];
    
    //商品的效果类型
    [cartDetail setXiaoguo_id:[dictionary objectForKey:@"xiaoguo_id"]];
    //商品的直径
    [cartDetail setZhijin_id:[dictionary objectForKey:@"zhijin_id"]];
    //商品的使用周期
    [cartDetail setZhouqi_id:[dictionary objectForKey:@"zhouqi_id"]];
    
    return cartDetail;
    
}
@end
