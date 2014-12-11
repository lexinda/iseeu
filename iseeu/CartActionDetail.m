//
//  CartActionDetail.m
//  iseeu
//
//  Created by 朱孟乐 on 14/12/8.
//  Copyright (c) 2014年 朱孟乐. All rights reserved.
//

#import "CartActionDetail.h"

@implementation CartActionDetail

+(FMDatabase *)getDb
{
    static FMDatabase *_db = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"address.db"];
        
        _db = [FMDatabase databaseWithPath:dbPath];
        
        [_db setShouldCacheStatements:YES];
        
    });
    return _db;
}

-(int)deleteCartRow:(FMDatabase *)db withId:(int)id{
    
    int result = 0;
    
    if(![db open]){
        
        [db open];
        
    }
    
    NSString *deleteStr = [NSString stringWithFormat:@"delete from cart where id =%i",id];
    
    if([db executeUpdate:deleteStr]){
        result = 1;
    }
    
    [db close];
    
    return result;

}

-(int)insertCartRow:(FMDatabase *)db withDictionary:(NSDictionary *)dictionary{
    
    int result = 0;
    
    if(![db open]){
        
        [db open];
        
    }
    
    if(![db tableExists:@"cart"])
    {
        [db executeUpdate:@"create table cart(id INTEGER PRIMARY KEY, title TEXT, number INTEGER,price TEXT,pic TEXT) "];
        
        NSLog(@"创建完成");
    }
    
    NSString *queryStr = [NSString stringWithFormat:@"select count(*) from cart where id = %@",[dictionary objectForKey:@"id"]];
    
    
    NSUInteger count = [db intForQuery:queryStr];
    
    if (count>0) {
        
        NSString *queryStr = [NSString stringWithFormat:@"select * from cart where id = %@",[dictionary objectForKey:@"id"]];
        
        FMResultSet *rs = [db executeQuery:queryStr];
        
        NSInteger number=0;
        
        while ([rs next]) {
            
            number = [rs intForColumn:@"number"];
            
        }

        
        NSString *numberValue = [dictionary objectForKey:@"number"];
        
        NSInteger numParam = [numberValue intValue]+number;
        
        NSString *updateStr = [NSString stringWithFormat:@"update cart set number = %ld where id=%@",(long)numParam,[dictionary objectForKey:@"id"]];
        
        if([db executeUpdate:updateStr]){
        
            result = 1;
            
        }
        
    }else{
        
        NSString *insertStr = [NSString stringWithFormat:@"insert into cart(id,title,number,price,pic) values('%@','%@','%@','%@','%@')",[dictionary objectForKey:@"id"],[dictionary objectForKey:@"title"],[dictionary objectForKey:@"number"],[dictionary objectForKey:@"price"],[dictionary objectForKey:@"pic"]];
        
        if([db executeUpdate:insertStr]){
        
            result = 1;
            
        }
    
    }
    
    [db close];
    
    return result;
    
}

@end
