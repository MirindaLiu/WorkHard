//
//  JsonToNull.m
//  Blog
//
//  Created by Mirinda on 17/5/31.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "JsonToNull.h"

@implementation JsonToNull

+(id)backNullObj
{
    NSDictionary* entity =  [JsonToNull dictionaryWithJsonString:@"{\"Address\": \"abc\",\"Area\": \"\",\"BindMobile\": 18758363317,\"CityName\": 123}"];
    return  [entity objectForKey:@"Area"];
}


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

@end
