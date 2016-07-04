//
//  user.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dog.h"

@interface user : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) double height;
@property (nonatomic,assign) int age;

//属性是一个对象
@property (nonatomic,strong) dog *dog;
// 属性是一个数组
@property (nonatomic,strong) NSArray *books;


@end
