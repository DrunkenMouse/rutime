//
//  person.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSObject+Extension.h"
#import "NSObject+Category.h"

@interface person : NSObject<NSCoding>

//测试用的属性
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *testOne;
@property(nonatomic,copy)NSString *testTwo;

@end
