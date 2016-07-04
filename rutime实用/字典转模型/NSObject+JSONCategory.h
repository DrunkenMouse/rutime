//
//  NSObject+JSONCategory.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONCategory)
//runtime形式对字典进行赋值
- (void)setDict:(NSDictionary *)dict;
//供外界直接调用的方法
+ (instancetype )objectWithDict:(NSDictionary *)dict;
// 分析时若遇到数组，则需手动告知数组中都是什么类型的模型对象
- (NSString *)arrayObjectClass ;
@end
