//
//  CreditLevelView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/3.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CreditLevelView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation CreditLevelView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *ackCoinAccountImageView = [UIImageView new];
    ackCoinAccountImageView.layer.masksToBounds = YES;
    ackCoinAccountImageView.contentMode = UIViewContentModeScaleAspectFill;
    ackCoinAccountImageView.image = [UIImage imageNamed:@"icon_personalCenter_backImage"];
    [self addSubview:ackCoinAccountImageView];
    [ackCoinAccountImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(-64);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    
    _creditTotalScoreButton = [UIButton new];
    _creditTotalScoreButton.layer.cornerRadius = 50.0;
    _creditTotalScoreButton.layer.masksToBounds = YES;
    _creditTotalScoreButton.layer.borderWidth = 2.0;
    _creditTotalScoreButton.adjustsImageWhenHighlighted = NO;
    _creditTotalScoreButton.layer.borderColor = [UIColor colorFromHexString:@"#feab4a" alpha:1.0].CGColor;
    _creditTotalScoreButton.titleLabel.numberOfLines = 0;
    _creditTotalScoreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    NSString *creditTotalScoreString = @"36000       当前积分";
    NSMutableAttributedString *creditTotalScoreAttrStr = [[NSMutableAttributedString alloc] initWithString:creditTotalScoreString];
    //setting font
    [creditTotalScoreAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(5, 11)];
    [creditTotalScoreAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 5)];
    [creditTotalScoreAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fca51b" alpha:1.0] range:NSMakeRange(0, 5)];
    [creditTotalScoreAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#83817d" alpha:1.0] range:NSMakeRange(5, 11)];
    //    ackCoinLeftButton.titleLabel.attributedText = ackCoinLeftAttrStr;
    [_creditTotalScoreButton setAttributedTitle:creditTotalScoreAttrStr forState:UIControlStateNormal];
    [_creditTotalScoreButton setTitle:creditTotalScoreString forState:UIControlStateNormal];
    [_creditTotalScoreButton setBackgroundImage:[UIImage imageNamed:@"icon_ackCoinAccountLeft_button"] forState:UIControlStateNormal];
    [self addSubview:_creditTotalScoreButton];
    [_creditTotalScoreButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).equalTo(@74);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    
    _creditLevelContentView = [UIView new];
    [self addSubview:_creditLevelContentView];
    [_creditLevelContentView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_creditTotalScoreButton.bottom).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@10);
    }];
    
    _creditLevelImageView0 = [UIImageView new];
    _creditLevelImageView0.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];
    _creditLevelImageView0.contentMode = UIViewContentModeCenter;
    [_creditLevelContentView addSubview:_creditLevelImageView0];
    [_creditLevelImageView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_creditLevelContentView.left).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _creditLevelImageView1 = [UIImageView new];
    _creditLevelImageView1.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];//到时候设置条件进行判断?:
    _creditLevelImageView1.contentMode = UIViewContentModeCenter;
    [_creditLevelContentView addSubview:_creditLevelImageView1];
    [_creditLevelImageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_creditLevelImageView0.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _creditLevelImageView2 = [UIImageView new];
    _creditLevelImageView2.image = [UIImage imageNamed:@"personalCenter_positiveLevel"];
    _creditLevelImageView2.contentMode = UIViewContentModeCenter;
    [_creditLevelContentView addSubview:_creditLevelImageView2];
    [_creditLevelImageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_creditLevelImageView1.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _creditLevelImageView3 = [UIImageView new];
    _creditLevelImageView3.image = [UIImage imageNamed:@"personalCenter_negativelevel"];
    _creditLevelImageView3.contentMode = UIViewContentModeCenter;
    [_creditLevelContentView addSubview:_creditLevelImageView3];
    [_creditLevelImageView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_creditLevelImageView2.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    _creditLevelImageView4 = [UIImageView new];
    _creditLevelImageView4.image = [UIImage imageNamed:@"personalCenter_negativelevel"];
    _creditLevelImageView4.contentMode = UIViewContentModeCenter;
    [_creditLevelContentView addSubview:_creditLevelImageView4];
    [_creditLevelImageView4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_creditLevelImageView3.right).offset(5);
        make.centerY.equalTo(@0);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    
    
    return self;
}

@end
