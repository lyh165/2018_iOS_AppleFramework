//
//  NSDictionary+LYH_JSONLog.m
//  LYH_EducationOnLive
//
//  Created by lee on 2018/8/23.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import "NSDictionary+LYH_JSONLog.h"

@implementation NSDictionary (LYH_JSONLog)
//#if DEBUG
- (NSString *)lyh_jsonLog_descriptionWithLocale:(nullable id)locale{
    
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}
//#endif

@end
