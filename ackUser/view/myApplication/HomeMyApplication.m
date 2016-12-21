//
//  HomeMyApplication.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeMyApplication.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

#define MyAppVerticalWidth   (SCREEN_WIDTH - 320)/4

@implementation HomeMyApplication

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *myAppIconImageView = [UIImageView new];
    myAppIconImageView.contentMode = UIViewContentModeCenter;
    myAppIconImageView.image = [UIImage imageNamed:@"icon_home_myApplication"];
    [self addSubview:myAppIconImageView];
    [myAppIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *myApplicationNoteLabel = [UILabel new];
    myApplicationNoteLabel.text = @"我的应用";
    myApplicationNoteLabel.font = [UIFont systemFontOfSize:13];
    myApplicationNoteLabel.textAlignment = NSTextAlignmentLeft;
    myApplicationNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [self addSubview:myApplicationNoteLabel];
    [myApplicationNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(myAppIconImageView.right).offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _myAppAddView = [UIView new];
    [self addSubview:_myAppAddView];
    [_myAppAddView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@65);
        make.height.equalTo(@20);
    }];
    
    UIImageView *addApplicationRightArrowImageView = [UIImageView new];
    addApplicationRightArrowImageView.contentMode = UIViewContentModeCenter;
    addApplicationRightArrowImageView.image = [UIImage imageNamed:@"icon_home_addButton"];
    [_myAppAddView addSubview:addApplicationRightArrowImageView];
    [addApplicationRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_myAppAddView.right);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *addAppNoteLabel = [UILabel new];
    addAppNoteLabel.text = @"添加";
    addAppNoteLabel.font = [UIFont systemFontOfSize:10];
    addAppNoteLabel.textAlignment = NSTextAlignmentRight;
    addAppNoteLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_myAppAddView addSubview:addAppNoteLabel];
    [addAppNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(addApplicationRightArrowImageView.left);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    _queryViolationButton = [UIButton new];
    [_queryViolationButton setTitle:@"违章查询" forState:UIControlStateNormal];
    [_queryViolationButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_queryViolationButton setImage:[UIImage imageNamed:@"icon_home_queryViolation"] forState:UIControlStateNormal];
    [self addSubview:_queryViolationButton];
    [_queryViolationButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(myAppIconImageView.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_queryViolationButton];
    
    _trafficRadioButton = [UIButton new];
    [_trafficRadioButton setTitle:@"路况电台" forState:UIControlStateNormal];
    [_trafficRadioButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_trafficRadioButton setImage:[UIImage imageNamed:@"icon_home_trafficRadio"] forState:UIControlStateNormal];
    [self addSubview:_trafficRadioButton];
    [_trafficRadioButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_queryViolationButton.right).offset(MyAppVerticalWidth);
        make.top.equalTo(myAppIconImageView.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_trafficRadioButton];
    
    _highwayHelperButton = [UIButton new];
    [_highwayHelperButton setTitle:@"高速助手" forState:UIControlStateNormal];
    [_highwayHelperButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_highwayHelperButton setImage:[UIImage imageNamed:@"icon_home_highwayHelper"] forState:UIControlStateNormal];
    [self addSubview:_highwayHelperButton];
    [_highwayHelperButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_trafficRadioButton.right).offset(MyAppVerticalWidth);
        make.top.equalTo(myAppIconImageView.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_highwayHelperButton];
    
    _prepaidRechargeButton = [UIButton new];
    [_prepaidRechargeButton setTitle:@"话费充值" forState:UIControlStateNormal];
    [_prepaidRechargeButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_prepaidRechargeButton setImage:[UIImage imageNamed:@"icon_home_perpaidRecharge"] forState:UIControlStateNormal];
    [self addSubview:_prepaidRechargeButton];
    [_prepaidRechargeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_highwayHelperButton.right).offset(MyAppVerticalWidth);
        make.top.equalTo(myAppIconImageView.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_prepaidRechargeButton];
    
    _livingExpensesButton = [UIButton new];
    [_livingExpensesButton setTitle:@"生活缴费" forState:UIControlStateNormal];
    [_livingExpensesButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_livingExpensesButton setImage:[UIImage imageNamed:@"icon_home_livingExpense"] forState:UIControlStateNormal];
    [self addSubview:_livingExpensesButton];
    [_livingExpensesButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_prepaidRechargeButton.right).offset(MyAppVerticalWidth);
        make.top.equalTo(myAppIconImageView.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_livingExpensesButton];
    
    
    
    return self;
}




- (void)settingButtonImageAndTitlePositionWithButton:(UIButton *)sender
{
    [sender setTitleColor:[UIColor colorFromHexString:@"#2d2d2d" alpha:1.0] forState:UIControlStateNormal];
    
    CGSize titleSize = CGSizeMake(40.0, 20.0);
    CGSize imageSize = sender.imageView.bounds.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + 5);
    sender.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}


@end
