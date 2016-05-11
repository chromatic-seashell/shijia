//
//  NSDictionary+JSON.m
//  shijia
//
//  Created by apple on 16/5/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

/** 根据JSON字符串返回一个字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

/** 根据bundle中的一个JSON文件名称获取字典 */
+ (NSDictionary *)dictionaryWithJsonFilename:(NSString *)fileName ofType:(NSString *)ext{

    NSString *path=[[NSBundle  mainBundle] pathForResource:fileName   ofType:ext];
    NSString *dataStr = [NSString  stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    return [NSDictionary  dictionaryWithJsonString:dataStr];

}


@end
