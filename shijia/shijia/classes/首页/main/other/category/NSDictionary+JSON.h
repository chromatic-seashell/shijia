//
//  NSDictionary+JSON.h
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

/** 根据JSON字符串返回一个字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 根据bundle中的一个JSON文件名称获取字典 */
+ (NSDictionary *)dictionaryWithJsonFilename:(NSString *)fileName  ofType:(NSString *)ext;

@end
