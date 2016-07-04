//
//  NSObject+Category.h
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)

//归档解档时忽视的属性,让对象自己设置
- (NSArray *)ignoredNames;
//归档
- (void)encode:(NSCoder *)aCoder;
//解档
- (void)decode:(NSCoder *)aDecoder;


@end
