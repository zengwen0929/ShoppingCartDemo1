//
//  DetailViewController.m
//  BWYShoppingCar
//
//  Created by zhiangkeji on 16/3/2.
//  Copyright © 2016年 zhiangkeji. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    UIImageView * _goodsImageView;
    UILabel * _priceLable;
    UILabel * _nameLable;
}
@end


@implementation DetailViewController

@synthesize detailGoodsNameStr,detailImageName,detailPriceStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self createViews];
}

- (void)createViews
{
    UIView * baseView = [[UIView alloc]initWithFrame:self.view.frame];
    baseView.backgroundColor = [UIColor colorWithRed:238/255.0 green:236/255.0 blue:236/255.0 alpha:0.5];
    [self.view addSubview:baseView];
    
    //添加毛玻璃效果
    UIToolbar * toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height/2.0)];
    toolBar.barStyle = 0;
    [baseView addSubview:toolBar];
    
    UILabel * VCNameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, baseView.frame.size.width, 44)];
    VCNameLable.text = @"商品详情";
    VCNameLable.textAlignment = NSTextAlignmentCenter;
    VCNameLable.textColor = [UIColor blackColor];
    VCNameLable.font = [UIFont fontWithName:@"Zapfino" size:18.0];
    VCNameLable.backgroundColor = [UIColor clearColor];
    [baseView addSubview:VCNameLable];
    
    UIView * backGroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 74 - 50)];
    backGroundView.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0];
    backGroundView.layer.cornerRadius = 10;
    [baseView addSubview:backGroundView];
    
    UIButton * gobackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gobackButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2.0 - 20, [UIScreen mainScreen].bounds.size.height - 45, 40, 40);
    gobackButton.layer.cornerRadius = 20;
    gobackButton.backgroundColor = [UIColor clearColor];
    [gobackButton setImage:[UIImage imageNamed:@"deletedImage_meitu_3.png"] forState:UIControlStateNormal];
    [gobackButton setImage:[UIImage imageNamed:@"deletedImage_meitu_3.png"] forState:UIControlStateSelected];
    [gobackButton setImage:[UIImage imageNamed:@"deletedImage_meitu_3.png"] forState:UIControlStateHighlighted];
    [gobackButton addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:gobackButton];
    
    _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, backGroundView.frame.size.width - 50, (backGroundView.frame.size.width - 50)/5.0 * 3.2)];
    _goodsImageView.image = [UIImage imageNamed:detailImageName];
    [backGroundView addSubview:_goodsImageView];
    
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(25, _goodsImageView.frame.origin.y + _goodsImageView.frame.size.height + 20, 200, 45)];
    _nameLable.text = [NSString stringWithFormat:@"商品名称:%@",detailGoodsNameStr];
    _nameLable.textAlignment = NSTextAlignmentLeft;
    _nameLable.textColor = [UIColor whiteColor];
    [backGroundView addSubview:_nameLable];
    
    _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(_nameLable.frame.origin.x, _nameLable.frame.origin.y + 45 + 10, _nameLable.frame.size.width, 45)];
    _priceLable.text = [NSString stringWithFormat:@"商品价格:%@",detailPriceStr];
    _priceLable.textAlignment = NSTextAlignmentLeft;
    _priceLable.textColor = [UIColor whiteColor];
    [backGroundView addSubview:_priceLable];
}

- (void)goback{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
