//
//  BWYShoppingCarTableViewCell.h
//  BWYShoppingCar
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWYShoppingCarModel.h"

@protocol BWYShoppingCarDelegate <NSObject>

- (void)isSelect:(UITableViewCell *)cell andModel:(BWYShoppingCarModel *)model;
- (void)goodsCount:(UITableViewCell *)cell andButtonTag:(NSInteger)AddOrSubTag;
- (void)isDelet:(UITableViewCell *)cell andDeletButtonTag:(NSInteger)deletTag;
@end


@interface BWYShoppingCarTableViewCell : UITableViewCell<UITextFieldDelegate>
{
    BWYShoppingCarModel * _model;
}
@property (nonatomic,strong)UIImageView * GoodsImageView;
@property (nonatomic,strong)UILabel * goodsNameLable;
@property (nonatomic,strong)UILabel * goodsPriceLable;
@property (nonatomic,strong)UITextField * goodsCountTextfield;
@property (nonatomic,strong)UIButton * selectedButton;
@property (nonatomic,strong)UIButton * deletButton;
@property (nonatomic,strong)UIButton * subtractButton;
@property (nonatomic,strong)UIButton * addButton;
@property (nonatomic,assign)id<BWYShoppingCarDelegate>delegate;

- (void)customDataWithModel:(BWYShoppingCarModel *)model;

@end
