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

//归档
- (void)encode:(NSCoder *)aCoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        //获取类中所有属性与属性数量
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //循环遍历取出每一个属性名
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            //通过属性名取出Value并归档处理
            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
        }
        //别忘了释放内存
        free(ivars);
        //此时C若为NSObject类，则不满足While循环条件
        //While循环结束
        c = [c superclass];
    }
}




//解档
- (void)decode:(NSCoder *)aDecoder {
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c &&c != [NSObject class]) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            //取出value并赋值给当前对象
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        //别忘了释放内存
        free(ivars);
        //此时C若为NSObject类，则不满足While循环条件
        //While循环结束
        c = [c superclass];
    }
    
}
@end
