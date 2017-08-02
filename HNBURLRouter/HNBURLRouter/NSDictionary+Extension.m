//
//  NSDictionary+Extension.m
//  RongGuanJia
//
//  Created by 东方融资网 on 16/1/6.
//  Copyright © 2016年 rongzi. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

//剔除字典的key 和 value为空的情况
+ (instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt{
    
    NSMutableArray *validKeys = [NSMutableArray new];
    NSMutableArray *validObjs = [NSMutableArray new];
    
    for (NSUInteger i = 0; i < cnt; i ++) {
        if (objects[i] && keys[i])
        {
            [validKeys addObject:keys[i]];
            [validObjs addObject:objects[i]];
        }
    }
    
    return [self dictionaryWithObjects:validObjs forKeys:validKeys];
}

#pragma mark - 公开方法
- (NSString *)hnb_jsonString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) return nil;
    NSString *json = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
    return json;
}

- (id)hnb_objectForKey:(id)key {
    if ([[self objectForKey:key] isKindOfClass:[NSNull class]]){
        return nil;
    }
    else {
        return [self objectForKey:key];
    }
}

+ (NSMutableArray *)hnb_removeNullFromArray:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        NSValue *value = arr[i];
        // 删除NSDictionary中的NSNull，再添加进数组
        if ([value isKindOfClass:NSDictionary.class]) {
            [marr addObject:[self hnb_removeNullFromDictionary:(NSDictionary *)value]];
        }
        // 删除NSArray中的NSNull，再添加进数组
        else if ([value isKindOfClass:NSArray.class]) {
            [marr addObject:[self hnb_removeNullFromArray:(NSArray *)value]];
        }
        // 剩余的非NSNull类型的数据添加进数组
        else if (![value isKindOfClass:NSNull.class]) {
            [marr addObject:value];
        }
    }
    return marr;
}
// 删除Dictionary中的NSNull
+ (NSMutableDictionary *)hnb_removeNullFromDictionary:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *strKey in dic.allKeys) {
        NSValue *value = dic[strKey];
        // 删除NSDictionary中的NSNull，再保存进字典
        if ([value isKindOfClass:NSDictionary.class]) {
            mdic[strKey] = [self hnb_removeNullFromDictionary:(NSDictionary *)value];
        }
        // 删除NSArray中的NSNull，再保存进字典
        else if ([value isKindOfClass:NSArray.class]) {
            mdic[strKey] = [self hnb_removeNullFromArray:(NSArray *)value];
        }
        // 剩余的非NSNull类型的数据保存进字典
        else if (![value isKindOfClass:NSNull.class]) {
            mdic[strKey] = dic[strKey];
        }
    }
    return mdic;
}

@end
