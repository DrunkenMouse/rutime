//
//  dog.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cat.h"

@interface dog : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) double price;
// 属性是一个对象
@property (nonatomic,strong) cat *cat;


@end
