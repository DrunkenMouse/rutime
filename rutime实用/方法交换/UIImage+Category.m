//
//  UIImage+Category.m
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "UIImage+Category.h"
#import <objc/runtime.h>

@implementation UIImage (Category)
//通过runtime来书写UIImage分类
//在分类中实现一个自定义方法，方法中写要在系统方法中加入的语句，比如版本判断
+(UIImage *)AD_imageNamed:(NSString *)name{
    //版本判断
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
        //如果系统版本是7.0以上，使用另外一套文件名结尾是"_os7"的扁平化图片
        name = [name stringByAppendingString:@"_os7"];
    }
    //此时所调用的是替换掉的那个方法，如此案例中imageNamed:
    return [UIImage AD_imageNamed:name];
}


//分类中重写UIImage的load方法，实现方法的交换(只要能让其执行一次方法交换语句，Load再合适不过了)
+(void)load{
    
    //获取两个类的类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(AD_imageNamed:));
    
    //开始交换方法的实现
    method_exchangeImplementations(m1, m2);
}


@end
