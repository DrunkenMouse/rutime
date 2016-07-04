//
//  NSObject+JSONCategory.m
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "NSObject+JSONCategory.h"
#import <objc/runtime.h>

@implementation NSObject (JSONCategory)

//通过runtime进行赋值
- (void)setDict:(NSDictionary *)dict {
    
    //先获取当前类
    Class c = self.class;
    //只要类存在并且不是系统的NSObject类
    while (c &&c != [NSObject class]) {
        //获取类中的所有成员变量与成员变量的数量
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        //循环遍历每个成员变量
        for (int i = 0; i < outCount; i++) {
            //获取成员变量名名
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 去掉下划线 _
            key = [key substringFromIndex:1];
            // 取出字典的值
            id value = dict[key];
            
            // 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil而报错
            // 所以结束此次循环
            if (value == nil) {
                continue;
            }
            
            // 获得成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            // 如果属性是对象类型,对象类型都是以@开始
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                // 那么截取对象的名字（比如@"Dog"，截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                // 排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                    // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    //调用自定义的方法去循环遍历数据中此对象的字典
                    value = [class objectWithDict:value];
                    
                }else if ([type isEqualToString:@"NSArray"]) {
                    
                    // 如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSArray *array = (NSArray *)value;
                    // 用来保存得到值后的模型
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    // 获取到每个模型的类型
                    id class ;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        
                        NSString *classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    }else {
                        
                        NSLog(@"数组内模型是未知类型");
                        return;
                    }
                    // 将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        [mArray addObject:[class objectWithDict:value[i]]];
                    }
                    
                    value = mArray;
                }
            }
            
            // 将字典中的值设置到模型上
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

//直接调用此方法
+ (instancetype )objectWithDict:(NSDictionary *)dict {
    NSObject *obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}


@end
