//
//  NSDictionary+Extension.h
//  RongGuanJia
//
//  Created by 东方融资网 on 16/1/6.
//  Copyright © 2016年 rongzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/**
 *  将字典转换为json
 */
- (NSString *)hnb_jsonString;

- (id)hnb_objectForKey:(id)key;

+ (NSMutableArray *)hnb_removeNullFromArray:(NSArray *)arr;
// 删除Dictionary中的NSNull
+ (NSMutableDictionary *)hnb_removeNullFromDictionary:(NSDictionary *)dic;
@end
