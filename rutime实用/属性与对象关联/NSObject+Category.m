//
//  NSObject+Category.m
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>
@implementation NSObject (Category)

char nameKey;

- (void)setName:(NSString *)name {
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
    //参数：对象，属性地址，属性值，参数类型
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &nameKey);
}

@end
