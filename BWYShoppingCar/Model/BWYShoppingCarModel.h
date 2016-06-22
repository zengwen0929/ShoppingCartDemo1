//
//  BWYShoppingCarModel.h
//  BWYShoppingCar
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWYShoppingCarModel : NSObject

@property (nonatomic,copy)NSString * goodsName;
@property (nonatomic,copy)NSString * goodsPrice;
@property (nonatomic,copy)NSString * goodsImage;
@property (nonatomic,assign) NSInteger goodsCount;
@property (nonatomic,assign)BOOL isSelected;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
