//
//  ViewController.m
//  BWYShoppingCar
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import "ViewController.h"
#import "BWYShoppingCarTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BWYShoppingCarDelegate>
{
    UITableView * _shoppingCarTableView;
    NSMutableArray * _shoppingCarDataArray;
    UIButton * allButton;
    UILabel * moneyLable;
    float priceNumber;
    UIImageView * _backGrundImageView;
    UIButton * balanceButton;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"我的购物车";
    
    _shoppingCarDataArray = [[NSMutableArray alloc]init];
    //添加购物车界面控件
    [self createTableViews];
    
    priceNumber = 0.0;
    
    //设置购物车的模拟数据
    for (int i = 0; i < 10; i++) {
        NSMutableDictionary * dataDic = [[NSMutableDictionary alloc]init];
        NSString * nameStr = [NSString stringWithFormat:@"商品名称%d",i];
        NSString * priceStr = [NSString stringWithFormat:@"%.1f",199.0 + i];
        [dataDic setValue:nameStr forKey:@"goodsName"];
        [dataDic setValue:priceStr forKey:@"goodsPrice"];
        [dataDic setValue:@"zhiang.jpg" forKey:@"goodsImage"];
        [dataDic setValue:@"1" forKey:@"goodsCount"];
        BWYShoppingCarModel * model = [BWYShoppingCarModel modelWithDictionary:dataDic];
        [_shoppingCarDataArray addObject:model];
        [_shoppingCarTableView reloadData];
    }
    
    [_shoppingCarTableView reloadData];
    [_shoppingCarTableView registerClass:[BWYShoppingCarTableViewCell class] forCellReuseIdentifier:@"BWYShoppingCarTableViewCell"];
    [_shoppingCarTableView reloadData];

    //购车内商品数量为零 显示默认图
    [self isArrayCountEqualZero];
}

- (void)createTableViews
{
    _shoppingCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    _shoppingCarTableView.delegate = self;
    _shoppingCarTableView.dataSource = self;
    [self.view addSubview:_shoppingCarTableView];
    
    //在数据很少的时候 避免显示多余的分割线
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [_shoppingCarTableView setTableFooterView:v];
    
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 1)];
    lineLable.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineLable];
    
    //全选按钮
    allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(10, self.view.frame.size.height - 37, 24, 24);
    [allButton setImage:[UIImage imageNamed:@"radiobuttons_normal@2x.png"] forState:UIControlStateNormal];
    [allButton setImage:[UIImage imageNamed:@"radiobuttons_pressed@2x.png"] forState:UIControlStateSelected];
    allButton.titleLabel.font = [UIFont systemFontOfSize:14];
    allButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    allButton.selected = NO;
    [self.view addSubview:allButton];
    
    
    UILabel * quanxuanLable = [[UILabel alloc]initWithFrame:CGRectMake(allButton.frame.origin.x + 28, allButton.frame.origin.y - 3, 30, 30)];
    quanxuanLable.text = @"全选";
    quanxuanLable.font = [UIFont systemFontOfSize:14];
    quanxuanLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:quanxuanLable];
    
    moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0 - 80, allButton.frame.origin.y, 160, 25)];
    moneyLable.textColor = [UIColor redColor];
    NSString * textStr = @"合计:￥0.00";
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSRange range = [[attributedStr string]rangeOfString:@"合计:"];
    NSRange lastRange = NSMakeRange(range.location, range.length);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:lastRange];
    [moneyLable setAttributedText:attributedStr];
    moneyLable.font = [UIFont systemFontOfSize:14];
    moneyLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyLable];
    
    //结算按钮
    balanceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    balanceButton.frame = CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - 45, 70, 40);
    balanceButton.backgroundColor = [UIColor colorWithRed:239/255.0 green:161/255.0 blue:50/255.0 alpha:0.5];
    [balanceButton setTitle:@"结算" forState:UIControlStateNormal];
    [balanceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    balanceButton.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
    //字体祖后面加-Bold就是加粗 加-Oblique就是倾斜
    [balanceButton addTarget:self action:@selector(balanceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:balanceButton];
    
    _backGrundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0 - 120, self.view.frame.size.height/2.0 - 130, 240, 260)];
    _backGrundImageView.image = [UIImage imageNamed:@"购物车空"];
    _backGrundImageView.hidden = YES;
    [self.view addSubview:_backGrundImageView];
    
}

- (void)balanceButtonClick:(UIButton *)button
{
    NSString * moneyStr = moneyLable.text;
    NSArray * array = [moneyStr componentsSeparatedByString:@"合计:￥"];
    NSString * carStr;
    NSString * messegeStr;
    if (array.count == 2 && [[array objectAtIndex:1] intValue] < 0.00000001) {
        NSLog(@"请先选择商品");
        carStr = @"请先选择商品!";
        messegeStr = @"么么哒";
    }else
    {
        NSLog(@"去结算");
        messegeStr = @"GO";
        carStr = [NSString stringWithFormat:@"总计:%d元",[[array objectAtIndex:1] intValue]];
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:messegeStr message:carStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _shoppingCarDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BWYShoppingCarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BWYShoppingCarTableViewCell"];
    if (!cell) {
        cell = [[BWYShoppingCarTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"BWYShoppingCarTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BWYShoppingCarModel * model = [_shoppingCarDataArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell customDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BWYShoppingCarModel * modal = [_shoppingCarDataArray objectAtIndex:indexPath.row];
    DetailViewController * detailVC = [[DetailViewController alloc]init];
    detailVC.detailImageName = modal.goodsImage;
    detailVC.detailPriceStr = modal.goodsPrice;
    detailVC.detailGoodsNameStr = modal.goodsName;
    detailVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        detailVC.providesPresentationContextTransitionStyle = YES;
        detailVC.definesPresentationContext = YES;
        detailVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:detailVC animated:YES completion:^{
            
        }];
    }else
    {
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:detailVC animated:YES completion:^{
            
        }];
    }
}

//选中按钮点击代理
- (void)isSelect:(UITableViewCell *)cell andModel:(BWYShoppingCarModel *)model
{
    //计算价格
    [self numerationPrice];
    if (model.isSelected == NO) {
        allButton.selected = NO;
    }
    [_shoppingCarTableView reloadData];
}

//侧滑删除按钮
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//侧滑删除按钮 执行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_shoppingCarDataArray removeObjectAtIndex:indexPath.row];
    [_shoppingCarTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //判断购物车内商品数量是否为零
    [self isArrayCountEqualZero];
    //重新计算价格
    [self numerationPrice];
}

//删除按钮点击代理
- (void)isDelet:(UITableViewCell *)cell andDeletButtonTag:(NSInteger)deletTag
{
    NSIndexPath * indexPath = [_shoppingCarTableView indexPathForCell:cell];
    [_shoppingCarDataArray removeObjectAtIndex:indexPath.row];
    [_shoppingCarTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //判断购物车内商品数量是否为零
    [self isArrayCountEqualZero];
    //重新计算价格
    [self numerationPrice];
}

- (void)isArrayCountEqualZero
{
    if (_shoppingCarDataArray.count == 0) {
        _shoppingCarTableView.hidden = YES;
        _backGrundImageView.hidden = NO;
        [balanceButton setBackgroundColor:[UIColor lightGrayColor]];
        //购物车内没有商品时结算按钮不能点击
        balanceButton.enabled = NO;
        //全选按钮也不可点
        allButton.enabled = NO;
    }else
    {
        _shoppingCarTableView.hidden = NO;
        _backGrundImageView.hidden = YES;
        [balanceButton setBackgroundColor:[UIColor redColor]];
        balanceButton.enabled = YES;
        allButton.enabled = YES;
    }
}

//增加 减少按钮点击代理
- (void)goodsCount:(UITableViewCell *)cell andButtonTag:(NSInteger)AddOrSubTag
{
    NSIndexPath * indexPath = [_shoppingCarTableView indexPathForCell:cell];
    switch (AddOrSubTag) {
        case 105:
        {
            BWYShoppingCarModel * model = [_shoppingCarDataArray objectAtIndex:indexPath.row];
            if (model.goodsCount > 1) {
                model.goodsCount--;
            }
            break;
        }
           case 106:
        {
            BWYShoppingCarModel * model = [_shoppingCarDataArray objectAtIndex:indexPath.row];
            if (model.goodsCount < 99) {
                model.goodsCount++;
            }
            break;
        }
        default:
            break;
    }
    //重新计算价格
    [self numerationPrice];
    [_shoppingCarTableView reloadData];
}

//全选按钮点击
- (void)allButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    for (int i = 0; i < _shoppingCarDataArray.count; i++) {
        BWYShoppingCarModel * model = [_shoppingCarDataArray objectAtIndex:i];
        model.isSelected = button.selected;
    }
    //重新计算价格
    [self numerationPrice];
    [_shoppingCarTableView reloadData];
}

//计算总价
- (void)numerationPrice
{
    for (int i = 0; i < _shoppingCarDataArray.count; i++) {
        BWYShoppingCarModel * model = [_shoppingCarDataArray objectAtIndex:i];
        if (model.isSelected) {
            priceNumber = priceNumber + model.goodsCount * [model.goodsPrice intValue];
        }
    }
    NSString * moneyStr = [NSString stringWithFormat:@"合计:￥%0.2f",priceNumber];
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:moneyStr];
    NSRange range = [[attributedStr string]rangeOfString:@"合计:"];
    NSRange lastRange = NSMakeRange(range.location, range.length);
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:lastRange];
    [moneyLable setAttributedText:attributedStr];
//    moneyLable.text = [NSString stringWithFormat:@"合计:￥%0.2f",priceNumber];
    priceNumber = 0.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
