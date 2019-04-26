//
//  fmdbModel.h
//  MeiLinDaoJia
//
//  Created by bjovov on 16/1/13.
//  Copyright (c) 2016年 ovov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface fmdbModel : NSObject<UIAlertViewDelegate>

+(fmdbModel*)defaultDbModel;

//没有数据时插入数据
-(void)insertDictory:(NSDictionary*)dictionry;

//有数据时插入单个数据
-(void)insertdic:(NSDictionary*)dic;

//删除数据
-(void)deleteData;

//删除单个数据
-(void)deleteFromID:(NSString*)str;

//获取所有数据
-(NSArray*)selectWithType;

//获取所有的id
-(NSArray*)selectAllId;

//获取所有的状态
-(NSArray*)selectAllMessageState;

//根据id修改消息的状态
-(void)stateChange:(NSString*)str;

//插入数组
-(void)insertArray:(NSArray*)array;

//将商品的id和商品的分类id添加到库中
-(void)insertProductId:(NSString*)productId andClassId:(NSString*)classId;

//根据商品的分类Id查找具体的商品id
-(NSArray*)seleltIdFromClassId:(NSString*)classId;

#pragma mark 环信
//插入环信的账号头像。。
-(void)insertHuanXin:(NSDictionary*)dic;

//查找单个的环信
-(void)selectHuanxin:(NSDictionary*)dic;

//查找所有的环信
-(NSArray*)selectAllHuanxin;

#pragma mark 购物车
//点击添加时查找数据库中是否有某个商品
-(BOOL)selectProduct:(NSString*)str;

//查找数据库中所有的商品
-(NSArray*)selectAllProduct;

//查找某个商品的数量
-(NSString*)selectNumOfProduct:(NSString*)str;

//点击添加时没有就插入某个商品
-(void)insertProductToShop:(NSDictionary*)dic;
//添加商品数量
-(void)addProductNum:(NSString*)str;


//直接更改商品数量的
-(void)ChangeNUM:(NSString *)goods_id :(NSString *)goods_num;


//减少商品数量
-(void)reducePrductNum:(NSString*)str;
//从数据中删除某个商品
-(void)delegateProduct:(NSString*)str;
//查找所有的数量
-(NSString*)allNumOfProduct;
//删除所有的商品
-(void)deleteAllProduct;
//插入购买的商品
-(void)insertBuyProduct:(NSDictionary*)dic;
//删除购买的商品
-(void)delegateBuyProduct:(NSString*)str;
//查找购买的商品
-(NSArray*)selectBuyProduct;
//查找某个商品
-(NSDictionary*)selectOneProduct:(NSString*)str;




-(void)insert:(NSString*)str;
-(NSString*)selectCout:(NSString*)str;
//改状态
-(void)addNum:(NSString*)str;
//查找
-(NSString*)selectCout12:(NSString*)str;


@end
