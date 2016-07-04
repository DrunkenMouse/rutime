//
//  person.m
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "person.h"

@implementation person

-(NSArray *)ignoredNames{
    //忽略属性时，应是_开头，否则不会匹配到
    //所以testOne忽略了，testTwo没有
    return @[@"_testOne",@"testTwo"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self encode:aCoder];
}

@end
