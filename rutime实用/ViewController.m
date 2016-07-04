//
//  ViewController.m
//  rutime实用
//
//  Created by 王奥东 on 16/7/4.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+JSONCategory.h"
#import "person.h"
#import "user.h"
#import "books.h"
#import "dog.h"
#import "cat.h"


@interface ViewController ()

@end

@implementation ViewController

-(void)model{
    //json解析
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model.json" ofType:nil];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    user *users = [user objectWithDict:json];
    books *book = users.books[0];
    
    NSLog(@"%@,%@",users,book.name);
    
}
-(void)archiver{
    //归档
    
    person *per = [[person alloc]init];
    per.name = @"name";
    per.testOne = @"testOne";
    per.testTwo = @"testTwo";
    
    //docPath,即为存储文件夹路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //拼接上数据文件的存储路径
    NSString *path = [docPath stringByAppendingPathComponent:@"private.data"];
    //对nameOne进行归档
    [NSKeyedArchiver archiveRootObject:per toFile:path];
    
    
    
    //解档
    //先获取存储文件夹的路径
    NSString *docPathAgain = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //拼接上数据文件的存储路径
    NSString *pathAgain = [docPathAgain stringByAppendingPathComponent:@"private.data"];
    person *personAgain = [NSKeyedUnarchiver unarchiveObjectWithFile:pathAgain];
    //因为声明里没有name属性，所以name属性不会打印
    //因为忽略方法里有testTwo，所以testTwo得属性被忽略了
    NSLog(@"%@,%@,%@",personAgain.testOne,personAgain.testTwo,personAgain.name);
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self model];
}


@end
