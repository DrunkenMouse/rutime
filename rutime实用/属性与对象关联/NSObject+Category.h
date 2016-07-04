//
//  NSObject+Category.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

/**
 *  在延展类中无法创建属性，是因为不会生成对应的属性
 *  但可以声明，所以只声明一个属性，重写其set、get方法
 *  随后通过runtime将自定义创建的一个属性与当前对象关联
 *  返回或修改时都是操作自定义创建的属性
 */
@property(nonatomic,copy)NSString *name;


@end
