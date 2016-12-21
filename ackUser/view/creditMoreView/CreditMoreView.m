//
//  CreditMoreView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/3.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CreditMoreView.h"
#import "UIColor+HexColor.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@implementation CreditMoreView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *scoreDetailIconImageView = [UIImageView new];
    scoreDetailIconImageView.contentMode = UIViewContentModeCenter;
    scoreDetailIconImageView.image = [UIImage imageNamed:@"icon_creditScore_detail"];
    [self addSubview:scoreDetailIconImageView];
    [scoreDetailIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.centerY.equalTo(@0);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    UILabel *scoreDetailLabel = [UILabel new];
    scoreDetailLabel.textAlignment = NSTextAlignmentLeft;
    scoreDetailLabel.text = @"积分明细";
    scoreDetailLabel.textColor = [UIColor colorFromHexString:@"#7d7d7d" alpha:1.0];
    [self addSubview:scoreDetailLabel];
    [scoreDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scoreDetailIconImageView.right).offset(5);
        make.centerY.equalTo(@0);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    _creditScoreMoreContentView = [UIView new];
    [self addSubview:_creditScoreMoreContentView];
    [_creditScoreMoreContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@65);
        make.height.equalTo(@20);
    }];
    
    UIImageView *enterMoreRightArrowImageView = [UIImageView new];
    enterMoreRightArrowImageView.contentMode = UIViewContentModeCenter;
    enterMoreRightArrowImageView.image = [UIImage imageNamed:@"icon_home_more"];
    [_creditScoreMoreContentView addSubview:enterMoreRightArrowImageView];
    [enterMoreRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_creditScoreMoreContentView.right);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *moreNoteLabel = [UILabel new];
    moreNoteLabel.text = @"查看更多";
    moreNoteLabel.font = [UIFont systemFontOfSize:10];
    moreNoteLabel.textAlignment = NSTextAlignmentRight;
    moreNoteLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_creditScoreMoreContentView addSubview:moreNoteLabel];
    [moreNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(enterMoreRightArrowImageView.left);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    
    
    return self;
}

@end
