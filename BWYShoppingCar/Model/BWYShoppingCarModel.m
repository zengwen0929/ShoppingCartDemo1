//
//  BWYShoppingCarModel.m
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import "BWYShoppingCarModel.h"

@implementation BWYShoppingCarModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    BWYShoppingCarModel * model = [[BWYShoppingCarModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //容错处理
}

@end
