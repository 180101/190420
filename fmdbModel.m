//
//  fmdbModel.m
//  MeiLinDaoJia
//
//  Created by bjovov on 16/1/13.
//  Copyright (c) 2016年 ovov. All rights reserved.
//

#import "fmdbModel.h"
#import "FMDatabase.h"
@implementation fmdbModel

{
    FMDatabase * fmdb;
}

+(fmdbModel*)defaultDbModel
{
    static fmdbModel * model = nil;
    if (model == nil) {
        model = [[fmdbModel alloc]init];
    }
    return model;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        NSString * path = [NSHomeDirectory() stringByAppendingString:@"/Documents/PRODUCT.db"];
        fmdb = [[FMDatabase alloc]initWithPath:path];
        BOOL isOpen = [fmdb open];
        if (isOpen)
        {
            //创建消息中心的表
            NSString * sql = @"create table if not exists MESSAGE (messageId varchar(256),messageTitle varchar(256),messageContent varchar(256),messageTime varchar(256),messageState varchar(256))";
            BOOL isSuccess = [fmdb executeUpdate:sql];
            if (isSuccess)
            {
            }
            else
            {
            }
            
            //创建环信的表
            NSString * sql1 = @"create table if not exists HUANXIN (chat_account varchar(256),nickname varchar(256),avatar varchar(256))";
            BOOL isSuccess1 = [fmdb executeUpdate:sql1];
            if (isSuccess1)
            {
                NSLog(@"表格创建成功");
            }
            else
            {
                NSLog(@"表格创建失败");
            }
            
            //创建购物车的表
            NSString * sql2 = @"create table if not exists SHOPCAR (productId varchar(256),in_sum varchar(256),img varchar(256),name varchar(256),price varchar(256),expiration_date varchar(256),standard1 varchar(256),numCount varchar(256))";
            BOOL isSuccess2 = [fmdb executeUpdate:sql2];
            if (isSuccess2)
            {
                NSLog(@"购物车创建成功");
            }
            else
            {
                NSLog(@"购物车创建失败");
            }
            
            
            //创建要购买的表
//            NSString * sql3 = @"create table if not exists BUYPRODUCT (productId varchar(256),in_sum varchar(256),img varchar(256),name varchar(256),price varchar(256),expiration_date varchar(256),standard1 varchar(256),numCount varchar(256))";
//            BOOL isSuccess3 = [fmdb executeUpdate:sql3];
//            if (isSuccess3)
//            {
//                NSLog(@"购买商品创建成功");
//            }
//            else
//            {
//                NSLog(@"购买商品创建失败");
//            }
            
            
     
                NSString * sql4 = @"create table if not exists XIAOX (productId varchar(256),numCount varchar(256))";
                BOOL isSuccess3 = [fmdb executeUpdate:sql4];
                if (isSuccess3)
                {
                    NSLog(@"购买商品创建成功");
                }
                else
                {
                    NSLog(@"购买商品创建失败");
                }
     
            
        }
        else
        {
        }
    }
    return self;
}

#pragma mark 消息中心
//插入所有的数据
-(void)insertDictory:(NSDictionary*)dictionry
{
//    NSDictionary * dic1 = dictionry[@"return_data"];
//    
//    NSLog(@"%@",dic1);
    
    NSArray * array =  dictionry[@"return_data"];
    for (NSDictionary*dic in array)
    {
        NSString * sql = @"insert into MESSAGE (messageId,messageTitle,messageContent,messageTime,messageState) values (?,?,?,?,?)";
        NSString * messageId = [NSString stringWithFormat:@"%@",dic[@"msg_id"]];
        NSString * messageTitle = dic[@"msg_name"];
        NSString * messageContent = dic[@"msg_content"];
        NSString * messageTime = dic[@"post_time"];
        NSString * messageState = @"0";
        
        BOOL isSuccess = [fmdb executeUpdate:sql,messageId,messageTitle,messageContent,messageTime,messageState];
        if (isSuccess)
        {
//            NSLog(@"商品插入成功");
        }
        else
        {
//            NSLog(@"商品插入失败");
        }
    }
}
//插入数组
-(void)insertArray:(NSArray*)array
{
    for (NSDictionary*dic in array)
    {
        NSString * sql = @"insert into MESSAGE (messageId,messageTitle,messageContent,messageTime,messageState) values (?,?,?,?,?)";
        NSString * messageId = [NSString stringWithFormat:@"%@",dic[@"msg_id"]];
        NSString * messageTitle = dic[@"msg_name"];
        NSString * messageContent = dic[@"msg_content"];
        NSString * messageTime = dic[@"post_time"];
        NSString * messageState = @"0";
        
        BOOL isSuccess = [fmdb executeUpdate:sql,messageId,messageTitle,messageContent,messageTime,messageState];
        if (isSuccess)
        {
        }
        else
        {
        }
    }
}
//插入单个的数据
-(void)insertdic:(NSDictionary*)dic
{
    NSString * sql = @"insert into MESSAGE (messageId,messageTitle,messageContent,messageTime,messageState) values (?,?,?,?,?)";
    NSString * messageId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    NSString * messageTitle = dic[@"title"];
    NSString * messageContent = dic[@"content"];
    NSString * messageTime = dic[@"add_time"];
    NSString * messageState = @"0";
    
    BOOL isSuccess = [fmdb executeUpdate:sql,messageId,messageTitle,messageContent,messageTime,messageState];
    if (isSuccess) {
    }
    else
    {
    }
}
//查找所有的数据
-(NSArray*)selectWithType
{
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    NSString * sql = @"select * from MESSAGE";
    FMResultSet * set = [fmdb executeQuery:sql];
    while ([set next])
    {
        NSString * messageId = [set stringForColumn:@"messageId"];
        NSString * messageTitle = [set stringForColumn:@"messageTitle"];
        NSString * messageContent = [set stringForColumn:@"messageContent"];
        NSString * messageTime = [set stringForColumn:@"messageContent"];
        NSString * messageState = [set stringForColumn:@"messageState"];
        
        if (messageId.length ==0) {
            messageId =@"";
        }
        if (messageTitle.length ==0) {
            messageTitle =@"";
        }
        if (messageContent.length ==0) {
            messageContent =@"";
        }
        if (messageTime.length ==0) {
            messageTime =@"";
        }
        if (messageState.length ==0) {
            messageState =@"";
        }        
        
        NSDictionary * dic = @{@"id":messageId,@"title":messageTitle,@"content":messageContent,@"add_time":messageTime,@"messageState":messageState};
        [muArray addObject:dic];
    }
    return muArray;
}

//查找所有的id
-(NSArray*)selectAllId
{
    NSString * sql = @"select messageId from MESSAGE";
    NSMutableArray * muarray = [[NSMutableArray alloc]init];
    FMResultSet * set = [fmdb executeQuery:sql];
    while ([set next])
    {
        
        NSString * messageId = [set stringForColumn:@"messageId"];
        NSLog(@"%@",messageId);
        if ([messageId isEqualToString:@"(null)"]) {
            
        }else{
         [muarray addObject:messageId];
        }
      
    }
    return muarray;
}
//查找所有的状态
-(NSArray*)selectAllMessageState
{
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    NSString * sql = @"select messageState from MESSAGE";
    FMResultSet * set = [fmdb executeQuery:sql];
    while ([set next])
    {
        NSString * messageState = [set stringForColumn:@"messageState"];
        [muArray addObject:messageState];
    }
    return muArray;
}

//删除所有的数据
-(void)deleteData
{
  NSString * sql = @"delete from MESSAGE";
    BOOL isSuccess = [fmdb executeUpdate:sql];
    if (isSuccess)
    {
    }
    else
    {
    }
    
    
}

//根据id删除数据
-(void)deleteFromID:(NSString*)str
{
  NSString *sql = @"delete from MESSAGE where messageId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,str];
    if (issuccess) {
    }
    else
    {
    }
}




//改变是否读取的状态
-(void)stateChange:(NSString *)str
{
    NSString * sql = @"update MESSAGE set messageState = ? where messageId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,@"1",str];
    if (issuccess)
    {
    }
    else
    {
    }
}


#pragma mark 环信

//插入环信的账号头像。。
-(void)insertHuanXin:(NSDictionary*)dic
{
    NSString * sql = @"insert into HUANXIN (chat_account,nickname,avatar) values (?,?,?)";
    NSString * chat_account = dic[@"chat_account"];
    NSString * nickname = dic[@"nickname"];
    NSString * avatar = dic[@"avatar"];
    //    NSString * messageState = @"0";
    
    BOOL isSuccess = [fmdb executeUpdate:sql,chat_account,nickname,avatar];
    if (isSuccess) {
        NSLog(@"插入成功");
    }
    else
    {
        NSLog(@"插入失败");
    }
    
}
//判断数据库中是否有这个账号(用来插入到数据库中)
-(void)selectHuanxin:(NSDictionary*)dic
{
    BOOL isOrNot = NO;
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    NSString * sql = @"select chat_account from HUANXIN";
    FMResultSet * set = [fmdb executeQuery:sql];
    while ([set next])
    {
        NSString * messageState = [set stringForColumn:@"chat_account"];
        [muArray addObject:messageState];
    }
    
    NSString * str = [NSString stringWithFormat:@"%@",dic[@"chat_account"]];
    if (muArray.count)
    {
        for (NSString * string in muArray)
        {
            if ([string isEqualToString:str])
            {
                isOrNot = YES;
            }
        }
    }
    else
    {
        
    }
    
    if (isOrNot)
    {
        
    }
    else
    {
        [self insertHuanXin:dic];
    }
}


//查找所有的环信
-(NSArray*)selectAllHuanxin
{
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    NSString * sql = @"select * from HUANXIN";
    FMResultSet * set = [fmdb executeQuery:sql];
    
    while ([set next])
    {
        NSMutableDictionary * mudic = [[NSMutableDictionary alloc]init];
        [mudic setObject:[set stringForColumn:@"chat_account"] forKey:@"chat_account"];
        [mudic setObject:[set stringForColumn:@"avatar"] forKey:@"avatar"];
        [mudic setObject:[set stringForColumn:@"nickname"] forKey:@"nickname"];
        [muArray addObject:mudic];
        
    }
    return muArray;
}

#pragma mark 购物车
//点击添加时查找数据库中是否有某个商品
-(BOOL)selectProduct:(NSString*)str
{
    NSString * spl = @"select * from SHOPCAR where productId = ?";
    FMResultSet * set = [fmdb executeQuery:spl,str];
    while ([set next])
    {
       return YES;
    }
    return NO;
}

//查找数据库中所有的商品
-(NSArray*)selectAllProduct
{
 NSString * sql = @"select * from SHOPCAR";
    FMResultSet * set = [fmdb executeQuery:sql];
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    while ([set next])
    {
        NSMutableDictionary * mudic = [[NSMutableDictionary alloc]init];
        [mudic setObject:[set stringForColumn:@"productId"] forKey:@"productId"];
        [mudic setObject:[set stringForColumn:@"in_sum"] forKey:@"in_sum"];
        [mudic setObject:[set stringForColumn:@"img"] forKey:@"img"];
        [mudic setObject:[set stringForColumn:@"name"] forKey:@"name"];
        [mudic setObject:[set stringForColumn:@"price"] forKey:@"price"];
        [mudic setObject:[set stringForColumn:@"expiration_date"] forKey:@"expiration_date"];
        [mudic setObject:[set stringForColumn:@"standard1"] forKey:@"standard1"];
        [mudic setObject:[set stringForColumn:@"numCount"] forKey:@"numCount"];
        [muArray addObject:mudic];
        
    }
    return muArray;
}

//查找某个商品的数量
-(NSString*)selectNumOfProduct:(NSString*)str
{
    NSString * num;
    NSString * sql = @"select numCount from SHOPCAR where productId = ?";
    FMResultSet * set = [fmdb executeQuery:sql,str];
    while ([set next])
    {
       num = [set stringForColumn:@"numCount"];
    }
    return num;
}
-(void)insertProductToShop:(NSDictionary*)dic
{
    NSString * str = [NSString stringWithFormat:@"%@",dic[@"goods_data_id"]];
    NSString * str2 = [NSString stringWithFormat:@"%@",dic[@"in_sum"]];
    NSString * str3 = [NSString stringWithFormat:@"%@",dic[@"goods_thumb"]];
    NSString * str4 = [NSString stringWithFormat:@"%@",dic[@"goods_name"]];
    NSString * str5 = [NSString stringWithFormat:@"%@",dic[@"market_price"]];
    NSString * str6 = [NSString stringWithFormat:@"%@",dic[@"expiration_date"]];
    NSString * str7 = [NSString stringWithFormat:@"%@",dic[@"standard"]];
    NSString * str8 = @"1";
    
    NSString * sql = @"insert into SHOPCAR (productId,in_sum,img,name,price,expiration_date,standard1,numCount) values (?,?,?,?,?,?,?,?)";
    BOOL issuccess = [fmdb executeUpdate:sql,str,str2,str3,str4,str5,str6,str7,str8];
    if (issuccess)
    {
        NSLog(@"插入商品成功");
    }
    else
    {
        NSLog(@"插入商品失败");
    }

}
//添加商品数量
-(void)addProductNum:(NSString*)str
{
    NSString * num = [self selectNumOfProduct:str];//商品当前数量
    int productNum;
    productNum = num.intValue;
    productNum++;
    NSString * string = [NSString stringWithFormat:@"%d",productNum];
    
    NSString * sql = @"update SHOPCAR set numCount = ? where productId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,string,str];
    if (issuccess)
    {
        NSLog(@"数量添加成功");
    }
    else
    {
        NSLog(@"数量添加失败");
    }
}
-(void)ChangeNUM:(NSString *)goods_num :(NSString *)goods_id
{
    
    NSString * sql = @"update SHOPCAR set numCount = ? where productId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,goods_num,goods_id];
    if (issuccess)
    {
        NSLog(@"数量添加成功");
    }
    else
    {
        NSLog(@"数量添加失败");
    }
    
}


//减少商品数量
-(void)reducePrductNum:(NSString*)str
{
  NSString * num = [self selectNumOfProduct:str];//商品当前数量
    if ([num isEqualToString:@"1"])//只有一个时将商品从数据库中移除
    {
        [self delegateProduct:str];
    }
    else
    {
        int productNum;
        productNum = num.intValue;
        productNum--;
        NSString * string = [NSString stringWithFormat:@"%d",productNum];
        
        NSString * sql = @"update SHOPCAR set numCount = ? where productId = ?";
        BOOL issuccess = [fmdb executeUpdate:sql,string,str];
        if (issuccess)
        {
            NSLog(@"数量减少成功");
        }
        else
        {
            NSLog(@"数量减少失败");
        }
    }
}
//从数据中删除某个商品
-(void)delegateProduct:(NSString*)str
{
    NSString * sql = @"delete from SHOPCAR where productId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,str];
    if (issuccess)
    {
        NSLog(@"删除商品成功");
    }
    else
    {
        NSLog(@"删除商品失败");
    }
}

//查找所有的数量
-(NSString*)allNumOfProduct
{
    NSString *allNum = [[NSString alloc]init];
    NSString * sql = @"select numCount from SHOPCAR";
    FMResultSet * set = [fmdb executeQuery:sql];
    int num = 0;
    while ([set next])
    {
        NSString * str = [set stringForColumn:@"numCount"];
        num += str.intValue;
    }
    allNum = [NSString stringWithFormat:@"%d",num];
    return allNum;
}
//删除所有的商品
-(void)deleteAllProduct
{
    NSString * sql = @"delete from SHOPCAR";
    BOOL isSuccess = [fmdb executeUpdate:sql];
    if (isSuccess)
    {
        NSLog(@"购物车删除成功");
    }
    else
    {
         NSLog(@"购物车删除失败");
    }
}

//插入购买的商品
-(void)insertBuyProduct:(NSDictionary*)dic
{
    NSString * str = [NSString stringWithFormat:@"%@",dic[@"id"]];
    NSString * str2 = [NSString stringWithFormat:@"%@",dic[@"in_sum"]];
    NSString * str3 = [NSString stringWithFormat:@"%@",dic[@"img"]];
    NSString * str4 = [NSString stringWithFormat:@"%@",dic[@"name"]];
    NSString * str5 = [NSString stringWithFormat:@"%@",dic[@"price"]];
    NSString * str6 = [NSString stringWithFormat:@"%@",dic[@"expiration_date"]];
    NSString * str7 = [NSString stringWithFormat:@"%@",dic[@"standard1"]];
    NSString * str8 = @"1";
    
    NSString * sql = @"insert into BUYPRODUCT (productId,in_sum,img,name,price,expiration_date,standard1,numCount) values (?,?,?,?,?,?,?,?)";
    BOOL issuccess = [fmdb executeUpdate:sql,str,str2,str3,str4,str5,str6,str7,str8];
    if (issuccess)
    {
        NSLog(@"插入购买商品成功");
    }
    else
    {
        NSLog(@"插入购买商品失败");
    }
}
//删除购买的商品
-(void)delegateBuyProduct:(NSString*)str
{
    NSString * sql = @"delete from BUYPRODUCT where productId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,str];
    if (issuccess)
    {
        NSLog(@"删除商品成功");
    }
    else
    {
        NSLog(@"删除商品失败");
    }
}
//查找购买的商品
-(NSArray*)selectBuyProduct
{
    NSString * sql = @"select * from BUYPRODUCT";
    FMResultSet * set = [fmdb executeQuery:sql];
    NSMutableArray * muArray = [[NSMutableArray alloc]init];
    while ([set next])
    {
        NSMutableDictionary * mudic = [[NSMutableDictionary alloc]init];
        [mudic setObject:[set stringForColumn:@"productId"] forKey:@"productId"];
        [mudic setObject:[set stringForColumn:@"in_sum"] forKey:@"in_sum"];
        [mudic setObject:[set stringForColumn:@"img"] forKey:@"img"];
        [mudic setObject:[set stringForColumn:@"name"] forKey:@"name"];
        [mudic setObject:[set stringForColumn:@"price"] forKey:@"price"];
        [mudic setObject:[set stringForColumn:@"expiration_date"] forKey:@"expiration_date"];
        [mudic setObject:[set stringForColumn:@"standard1"] forKey:@"standard1"];
        [mudic setObject:[set stringForColumn:@"numCount"] forKey:@"numCount"];
        [muArray addObject:mudic];
        
    }
    return muArray;
  
}

//查找某个商品
-(NSDictionary*)selectOneProduct:(NSString*)str
{
    NSString * sql = @"select * from SHOPCAR where productId = ?";
    FMResultSet * set = [fmdb executeQuery:sql,str];
   NSMutableDictionary * mudic = [[NSMutableDictionary alloc]init];
    while ([set next])
    {
        
        [mudic setObject:[set stringForColumn:@"productId"] forKey:@"productId"];
        [mudic setObject:[set stringForColumn:@"in_sum"] forKey:@"in_sum"];
        [mudic setObject:[set stringForColumn:@"img"] forKey:@"img"];
        [mudic setObject:[set stringForColumn:@"name"] forKey:@"name"];
        [mudic setObject:[set stringForColumn:@"price"] forKey:@"price"];
        [mudic setObject:[set stringForColumn:@"expiration_date"] forKey:@"expiration_date"];
        [mudic setObject:[set stringForColumn:@"standard1"] forKey:@"standard1"];
        [mudic setObject:[set stringForColumn:@"numCount"] forKey:@"numCount"];
    }
    return mudic;

}












#pragma mark 首页订单
//插入
-(void)insert:(NSString*)str
{
    NSString * str1 = [NSString stringWithFormat:@"%@",str];
    NSString * str2 = @"0";
    
    NSString * sql = @"insert into XIAOX (productId,numCount) values (?,?)";
    BOOL issuccess = [fmdb executeUpdate:sql,str1,str2];
    if (issuccess)
    {
        NSLog(@"插入id成功");
    }
    else
    {
        NSLog(@"插入id失败");
    }
}

//查找
-(NSString*)selectCout:(NSString*)str
{
    NSString * num;
    NSString * sql = @"select numCount from XIAOX where productId = ?";
    FMResultSet * set = [fmdb executeQuery:sql,str];
    while ([set next])
    {
        num = [set stringForColumn:@"numCount"];
    }
    
    return num;
}


//查找
-(NSString*)selectCout12:(NSString*)str
{
    NSString * num;
    num =@"0";
    NSString * sql = @"select numCount from XIAOX where productId = ?";
    FMResultSet * set = [fmdb executeQuery:sql,str];
    while ([set next])
    {
        num = @"1";
    }
    
    return num;
}


//改状态
-(void)addNum:(NSString*)str
{
    NSString * sql = @"update XIAOX set numCount = ? where productId = ?";
    BOOL issuccess = [fmdb executeUpdate:sql,@"1",str];
    if (issuccess)
    {
        NSLog(@"1成功");
    }
    else
    {
        NSLog(@"0失败");
    }
}


@end
