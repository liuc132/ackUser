//
//  OilCardListTableViewCell.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "OilCardListTableViewCell.h"
#import "ackUserPCH.pch"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation OilCardListTableViewCell

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _backCellImageView = [UIImageView new];
    _backCellImageView.userInteractionEnabled = YES;
    _backCellImageView.layer.masksToBounds = YES;
    _backCellImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backCellImageView.image = [UIImage imageNamed:@"ackCoinAccount_oilCard_negative"];
    [self addSubview:_backCellImageView];
    [_backCellImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    
    _companyImageView = [UIImageView new];
    _companyImageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *oilCompanyLogo = [UIImage imageNamed:@"ackCoinAccount_oilCard_status"];
    _companyImageView.image = [oilCompanyLogo imageWithColor:[UIColor colorWithRed:254/255.0 green:248/255.0 blue:0.0 alpha:1.0]];
    [_backCellImageView addSubview:_companyImageView];
    [_companyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backCellImageView.top).offset(10);
        make.left.equalTo(_backCellImageView.left).offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    _oilCompanyNameLabel = [UILabel new];
    _oilCompanyNameLabel.textAlignment = NSTextAlignmentLeft;
    _oilCompanyNameLabel.text = @"国通石油";
    _oilCompanyNameLabel.textColor = [UIColor whiteColor];
    [_oilCompanyNameLabel setFont:[UIFont systemFontOfSize:10]];
    [_backCellImageView addSubview:_oilCompanyNameLabel];
    [_oilCompanyNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_companyImageView.right).offset(10);
        make.top.equalTo(_backCellImageView.top).offset(15);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _activeOilCardButton = [UIButton new];
    _activeOilCardButton.layer.cornerRadius = 4.0;
    _activeOilCardButton.layer.masksToBounds = YES;
    [_activeOilCardButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    _activeOilCardButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [_activeOilCardButton setTitle:@"激活" forState:UIControlStateNormal];
    [_activeOilCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _activeOilCardButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_backCellImageView addSubview:_activeOilCardButton];
    [_activeOilCardButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backCellImageView.right).offset(-10);
        make.top.equalTo(_backCellImageView.top).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
    }];
    
    UIView *oilCardSeparetedView = [UIView new];
    oilCardSeparetedView.backgroundColor = [UIColor whiteColor];
    [_backCellImageView addSubview:oilCardSeparetedView];
    [oilCardSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_backCellImageView.left);
        make.right.equalTo(_backCellImageView.right);
        make.height.equalTo(@1);
    }];
    
    _oilCardNumberLabel = [UILabel new];
    _oilCardNumberLabel.textAlignment = NSTextAlignmentCenter;
    _oilCardNumberLabel.text = @"5635****423";
    _oilCardNumberLabel.textColor = [UIColor whiteColor];
    [_oilCardNumberLabel setFont:[UIFont systemFontOfSize:20]];
    [_backCellImageView addSubview:_oilCardNumberLabel];
    [_oilCardNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(oilCardSeparetedView.top).offset(-5);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    
    _oilCompanyHotLineLabel = [UILabel new];
    _oilCompanyHotLineLabel.textAlignment = NSTextAlignmentLeft;
    _oilCompanyHotLineLabel.text = @"96556(国通热线)";
    _oilCompanyHotLineLabel.textColor = [UIColor whiteColor];
    [_oilCompanyHotLineLabel setFont:[UIFont systemFontOfSize:15]];
    [_backCellImageView addSubview:_oilCompanyHotLineLabel];
    [_oilCompanyHotLineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backCellImageView.left).offset(10);
        make.top.equalTo(oilCardSeparetedView.bottom).offset(25);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    _oilCardChargeButton = [UIButton new];
    _oilCardChargeButton.layer.cornerRadius = 4.0;
    _oilCardChargeButton.layer.masksToBounds = YES;
    [_oilCardChargeButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    _oilCardChargeButton.backgroundColor = [UIColor colorWithRed:159/255.0 green:208/255.0 blue:163/255.0 alpha:1.0];
    [_oilCardChargeButton setTitle:@"充值" forState:UIControlStateNormal];
    [_oilCardChargeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _oilCardChargeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_backCellImageView addSubview:_oilCardChargeButton];
    [_oilCardChargeButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backCellImageView.right).offset(-10);
        make.top.equalTo(oilCardSeparetedView.bottom).offset(20);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
    }];
    
    
    return self;
}







@end
