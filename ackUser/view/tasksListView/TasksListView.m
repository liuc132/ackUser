//
//  TasksListView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TasksListView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation TasksListView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _taskADImageView = [UIImageView new];
    _taskADImageView.contentMode = UIViewContentModeScaleAspectFill;
    _taskADImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_taskADImageView];
    [_taskADImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 60, 0));
    }];
    
    _taskAckCoinView = [UIView new];
    _taskAckCoinView.layer.cornerRadius = 10.0;
    _taskAckCoinView.backgroundColor = [UIColor colorFromHexString:@"ffa122" alpha:1.0];
    [self addSubview:_taskAckCoinView];
    [_taskAckCoinView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@115);
    }];
    
    UIImageView *ackCoinImageView = [UIImageView new];
    ackCoinImageView.contentMode = UIViewContentModeCenter;
    ackCoinImageView.image = [UIImage imageNamed:@"icon_taskList_ackCoin"];
    [_taskAckCoinView addSubview:ackCoinImageView];
    [ackCoinImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.centerY.equalTo(@0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *ackCoinLabel = [UILabel new];
    ackCoinLabel.text = @"爱车币:30000";
    ackCoinLabel.font = [UIFont systemFontOfSize:13];
    ackCoinLabel.textAlignment = NSTextAlignmentLeft;
    ackCoinLabel.textColor = [UIColor whiteColor];
    [_taskAckCoinView addSubview:ackCoinLabel];
    [ackCoinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(ackCoinImageView.right);
        make.right.equalTo(_taskAckCoinView.right);
        make.height.equalTo(@20);
    }];
    
    _taskDeadTimeView = [UIView new];
    _taskDeadTimeView.layer.cornerRadius = 10.0;
    _taskDeadTimeView.backgroundColor = [UIColor colorFromHexString:@"ffa122" alpha:1.0];
    [self addSubview:_taskDeadTimeView];
    [_taskDeadTimeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@125);
    }];
    
    UIImageView *deadTimeImageView = [UIImageView new];
    deadTimeImageView.contentMode = UIViewContentModeCenter;
    deadTimeImageView.image = [UIImage imageNamed:@"icon_taskList_ackCoin"];
    [_taskDeadTimeView addSubview:deadTimeImageView];
    [deadTimeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@3);
        make.centerY.equalTo(@0);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _taskDeadTimeLabel = [UILabel new];
    _taskDeadTimeLabel.text = @"距招募结束:03天20小时";
    _taskDeadTimeLabel.font = [UIFont systemFontOfSize:9];
    _taskDeadTimeLabel.textAlignment = NSTextAlignmentLeft;
    _taskDeadTimeLabel.textColor = [UIColor whiteColor];
    [_taskDeadTimeView addSubview:_taskDeadTimeLabel];
    [_taskDeadTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(deadTimeImageView.right);
        make.right.equalTo(_taskDeadTimeView.right);
        make.height.equalTo(@20);
    }];
    
    _taskNameLabel = [UILabel new];
    _taskNameLabel.font = [UIFont systemFontOfSize:11];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],};
    NSString *latestTaskNameString = @"万达城示范区明星活动";
    _taskNameLabel.text = latestTaskNameString;
    CGSize textSize = [latestTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _taskNameLabel.textAlignment = NSTextAlignmentLeft;
    _taskNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [self addSubview:_taskNameLabel];
    [_taskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskADImageView.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(textSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    _taskNewIconImageView = [UIImageView new];
    _taskNewIconImageView.contentMode = UIViewContentModeCenter;
    _taskNewIconImageView.image = [UIImage imageNamed:@"icon_home_newTaskNote"];
    [self addSubview:_taskNewIconImageView];
    [_taskNewIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskNameLabel.right).offset(3);
        make.top.equalTo(_taskADImageView.bottom).offset(3);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    UIImageView *periodIconImageView = [UIImageView new];
    periodIconImageView.contentMode = UIViewContentModeCenter;
    periodIconImageView.image = [UIImage imageNamed:@"icon_taskList_period"];
    [self addSubview:periodIconImageView];
    [periodIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(_taskNameLabel.bottom).offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    _taskPeriodLabel = [UILabel new];
    NSDictionary *periodAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],};
    NSString *periodString = @"周期:180";
    _taskPeriodLabel.text = periodString;
    NSMutableAttributedString *periodAttrStr = [[NSMutableAttributedString alloc] initWithString:periodString];
    //setting font
    [periodAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#1a1a1a" alpha:1.0] range:NSMakeRange(0, 3)];
    [periodAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#ff9d23" alpha:1.0] range:NSMakeRange(3, periodString.length - 3)];
    _taskRemainedQuotasLabel.attributedText = periodAttrStr;
    
    CGSize periodTextSize = [periodString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:periodAttributes context:nil].size;
    _taskPeriodLabel.textAlignment = NSTextAlignmentLeft;
    _taskPeriodLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_taskPeriodLabel];
    [_taskPeriodLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(periodIconImageView.right).offset(3);
        make.top.equalTo(_taskNameLabel.bottom).offset(5);
        make.width.equalTo(@(periodTextSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    UIImageView *remainedQuotasImageView = [UIImageView new];
    remainedQuotasImageView.contentMode = UIViewContentModeCenter;
    remainedQuotasImageView.image = [UIImage imageNamed:@"icon_taskList_leftQuotas"];
    [self addSubview:remainedQuotasImageView];
    [remainedQuotasImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskPeriodLabel.right);
        make.top.equalTo(_taskNameLabel.bottom).offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    _taskRemainedQuotasLabel = [UILabel new];
    NSDictionary *quotasAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10],};
    NSString *quotasString = @"剩余名额:8500";
    _taskRemainedQuotasLabel.text = quotasString;
    NSMutableAttributedString *quotasAttrStr = [[NSMutableAttributedString alloc] initWithString:quotasString];
    //setting font
    [quotasAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#1a1a1a" alpha:1.0] range:NSMakeRange(0, 5)];
    [quotasAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#ff9d23" alpha:1.0] range:NSMakeRange(5, quotasString.length - 5)];
    _taskRemainedQuotasLabel.attributedText = quotasAttrStr;
    
    CGSize quotasTextSize = [quotasString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:quotasAttributes context:nil].size;
    _taskRemainedQuotasLabel.textAlignment = NSTextAlignmentLeft;
    _taskRemainedQuotasLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_taskRemainedQuotasLabel];
    [_taskRemainedQuotasLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remainedQuotasImageView.right).offset(5);
        make.top.equalTo(_taskNameLabel.bottom).offset(5);
        make.width.equalTo(@(quotasTextSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    _taskGetButton = [UIButton new];
    [_taskGetButton setImage:[UIImage imageNamed:@"icon_taskList_getRightNow"] forState:UIControlStateNormal];
    [self addSubview:_taskGetButton];
    [_taskGetButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.bottom.equalTo(_taskADImageView.bottom).offset(30);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    
    
    
    
    return self;
}






@end
