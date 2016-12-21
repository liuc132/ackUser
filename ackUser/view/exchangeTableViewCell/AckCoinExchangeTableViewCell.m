//
//  AckCoinExchangeTableViewCell.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AckCoinExchangeTableViewCell.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@interface AckCoinExchangeTableViewCell ()


@end

@implementation AckCoinExchangeTableViewCell

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _exchangeItemImageView = [UIImageView new];
    _exchangeItemImageView.contentMode = UIViewContentModeScaleAspectFill;
    _exchangeItemImageView.image = [UIImage imageNamed:@"ackCoinAccount_exchangeDetail"];
    [self addSubview:_exchangeItemImageView];
    [_exchangeItemImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _exchangeNameLabel = [UILabel new];
    _exchangeNameLabel.textAlignment = NSTextAlignmentLeft;
    _exchangeNameLabel.numberOfLines = 0;
    _exchangeNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _exchangeNameLabel.text = @"提现到银行卡(4523)";
    [_exchangeNameLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_exchangeNameLabel];
    [_exchangeNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_exchangeItemImageView.right).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@130);
        make.height.equalTo(@50);
    }];
    
    _exchangeTimeLabel = [UILabel new];
    _exchangeTimeLabel.textAlignment = NSTextAlignmentLeft;
    _exchangeTimeLabel.text = @"2016-08-24 10:12:08";
    _exchangeTimeLabel.textColor = [UIColor lightGrayColor];
    [_exchangeTimeLabel setFont:[UIFont systemFontOfSize:10]];
    [self addSubview:_exchangeTimeLabel];
    [_exchangeTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_exchangeItemImageView.right).offset(10);
        make.top.equalTo(_exchangeNameLabel.bottom).offset(10);
        make.width.equalTo(@130);
        make.height.equalTo(@20);
    }];
    
    _exchangeCurrentItemCashLabel = [UILabel new];
    _exchangeCurrentItemCashLabel.textAlignment = NSTextAlignmentCenter;
    _exchangeCurrentItemCashLabel.text = @"+30000";
    [_exchangeCurrentItemCashLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_exchangeCurrentItemCashLabel];
    [_exchangeCurrentItemCashLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_exchangeNameLabel.right).offset(10);
        make.top.equalTo(self.top).offset(30);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _exchangeStatusLabel = [UILabel new];
    _exchangeStatusLabel.textAlignment = NSTextAlignmentCenter;
    _exchangeStatusLabel.text = @"(充值中)";
    [_exchangeStatusLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_exchangeStatusLabel];
    [_exchangeStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_exchangeNameLabel.right).offset(10);
        make.top.equalTo(_exchangeCurrentItemCashLabel.top).offset(15);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _exchangeCurItemTotalLabel = [UILabel new];
    _exchangeCurItemTotalLabel.textAlignment = NSTextAlignmentCenter;
    _exchangeCurItemTotalLabel.text = @"70000";
    _exchangeCurItemTotalLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    [_exchangeCurItemTotalLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:_exchangeCurItemTotalLabel];
    [_exchangeCurItemTotalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    
    
    
    
    
    
    return self;
}






/**
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/

@end
