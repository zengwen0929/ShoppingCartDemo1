//
//  BWYShoppingCarTableViewCell.m
//  BWYShoppingCar
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import "BWYShoppingCarTableViewCell.h"

@implementation BWYShoppingCarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellsView];
    }
    return self;
}

/**
* cell上的控件添加 纯代码的 frame适配
* 想用xib和autolaout的 但是不利于后期更改
*/

- (void)creatCellsView
{
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_normal@2x.png"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_pressed@2x.png"] forState:UIControlStateSelected];
    //原来选择框框太小经常点不到 就想了这个方法 放大按钮 不放大图片
    [_selectedButton setImageEdgeInsets:UIEdgeInsetsMake(35, 10, 35, 10)];
    _selectedButton.frame = CGRectMake(0, 0, 40, 90);
    _selectedButton.tag = 101;
    [_selectedButton addTarget:self action:@selector(isselectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectedButton];
    
    _GoodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_selectedButton.frame.origin.x + 40, 10, 70, 70)];
    _GoodsImageView.layer.cornerRadius = 10;
    [self.contentView addSubview:_GoodsImageView];
    
    _goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(_GoodsImageView.frame.origin.x + 80, 10, [UIScreen mainScreen].bounds.size.width - 50 - _GoodsImageView.frame.origin.x - 70 - 10, 30)];
    _goodsNameLable.textAlignment = NSTextAlignmentLeft;
    _goodsNameLable.font = [UIFont systemFontOfSize:14];
    _goodsNameLable.textColor = [UIColor blackColor];
    _goodsNameLable.numberOfLines = 0;
    [self.contentView addSubview:_goodsNameLable];
    
    _goodsPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(_goodsNameLable.frame.origin.x, 55,[UIScreen mainScreen].bounds.size.width - 110 - _GoodsImageView.frame.origin.x - 70 - 10, 30)];
    _goodsPriceLable.textAlignment = NSTextAlignmentLeft;
    _goodsPriceLable.textColor = [UIColor redColor];
    _goodsPriceLable.font = [UIFont systemFontOfSize:13];
    _goodsPriceLable.numberOfLines = 0;
    [self.contentView addSubview:_goodsPriceLable];
    
    _deletButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deletButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 10, 30, 20);
    [_deletButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deletButton setTitle:@"删除" forState:UIControlStateHighlighted];
    [_deletButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _deletButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_deletButton addTarget:self action:@selector(deletButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _deletButton.tag = 102;
    [self.contentView addSubview:_deletButton];
    
    _subtractButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_subtractButton setImage:[UIImage imageNamed:@"carSubtractSelect.png"] forState:UIControlStateNormal];
    [_subtractButton setImage:[UIImage imageNamed:@"carSubtractNamol.png"] forState:UIControlStateSelected];
    [_subtractButton setImage:[UIImage imageNamed:@"carSubtractNamol.png"] forState:UIControlStateHighlighted];
    [_subtractButton setImageEdgeInsets:UIEdgeInsetsMake(15, 10, 15, 5)];
    _subtractButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 40, 35, 50);
    _subtractButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _subtractButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_subtractButton addTarget:self action:@selector(subStractButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _subtractButton.tag = 105;
    [self.contentView addSubview:_subtractButton];
    
    _goodsCountTextfield = [[UITextField alloc]initWithFrame:CGRectMake(_subtractButton.frame.origin.x + 37, _subtractButton.frame.origin.y + 15, 36, 20)];
    _goodsCountTextfield.borderStyle = 3;
    _goodsCountTextfield.textColor = [UIColor blackColor];
    _goodsCountTextfield.textAlignment = NSTextAlignmentCenter;
    _goodsCountTextfield.font = [UIFont systemFontOfSize:14];
    _goodsCountTextfield.enabled = NO;
    [self.contentView addSubview:_goodsCountTextfield];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.frame = CGRectMake(_goodsCountTextfield.frame.origin.x + 36 + 2, _goodsCountTextfield.frame.origin.y - 15, 35, 50);
    [_addButton setImageEdgeInsets:UIEdgeInsetsMake(15, 5, 15, 10)];
    [_addButton setImage:[UIImage imageNamed:@"carAddSelect.png"] forState:UIControlStateNormal];
    [_addButton setImage:[UIImage imageNamed:@"carAddNamol.png"] forState:UIControlStateSelected];
    [_addButton setImage:[UIImage imageNamed:@"carAddNamol.png"] forState:UIControlStateHighlighted];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _addButton.tag = 106;
    [self.contentView addSubview:_addButton];
}

/**
* 对获得的数据进行处理
*/

- (void)customDataWithModel:(BWYShoppingCarModel *)model
{
    _model = model;
    _GoodsImageView.image = [UIImage imageNamed:model.goodsImage];
    _goodsNameLable.text = [NSString stringWithFormat:@"%@",model.goodsName];
    _goodsNameLable.text = model.goodsName;
    
    //修改价格项字体的颜色（一个label中的文字显示不同颜色）
    NSString * str = [NSString stringWithFormat:@"价格:￥%@",model.goodsPrice];
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = [[attributedStr string] rangeOfString:@"价格:"];
    NSRange reviseRange = NSMakeRange(range.location, range.length);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:reviseRange];
    [_goodsPriceLable setAttributedText:attributedStr];
    
    if (model.goodsCount < 1) {
        _goodsCountTextfield.text = @"1";
    }else{
    _goodsCountTextfield.text = [NSString stringWithFormat:@"%ld",(long)model.goodsCount];
    }
    if (model.isSelected == YES) {
        _selectedButton.selected = YES;
        [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_pressed@2x.png"] forState:UIControlStateSelected];
    }else
    {
        _selectedButton.selected = NO;
        [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_normal@2x.png"] forState:UIControlStateNormal];
    }
}

/**
* cell上的选择 删除 增加 减少按钮都需通过代理实现效果 
*（block应该也行，我没试过，block不是太会）
*/

- (void)isselectButtonClick:(UIButton *)button
{
    
    if (button.selected == YES) {
      [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_normal@2x.png"] forState:UIControlStateNormal];
        
    }else
    {
        [_selectedButton setImage:[UIImage imageNamed:@"radiobuttons_pressed@2x.png"] forState:UIControlStateSelected];
    }
    button.selected = !button.selected;
    _model.isSelected = !_model.isSelected;
    [self.delegate isSelect:self andModel:_model];
}

- (void)deletButtonAction:(UIButton *)button
{
    [self.delegate isDelet:self andDeletButtonTag:button.tag];
}

- (void)subStractButtonAction:(UIButton *)button
{
    if (_model.isSelected) {
        [self.delegate goodsCount:self andButtonTag:button.tag];
    }
}

- (void)addButtonAction:(UIButton *)button
{
    if (_model.isSelected) {
        [self.delegate goodsCount:self andButtonTag:button.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
