//
//  MyTaskListView.m
//  ackUser
//
//  Created by LiuC on 16/11/26.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MyTaskListView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"


@implementation MyTaskListView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _myTaskNameLabel = [UILabel new];
    _myTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskNameLabel.font = [UIFont systemFontOfSize:14];
    _myTaskNameLabel.textColor = [UIColor colorFromHexString:@"#212223" alpha:1.0];
    _myTaskNameLabel.text = @"任务名称任务名称任务名称";
    [self addSubview:_myTaskNameLabel];
    [_myTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.top.equalTo(_myTaskNameLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _myTaskADImageView = [UIImageView new];
    _myTaskADImageView.layer.masksToBounds = YES;
    _myTaskADImageView.contentMode = UIViewContentModeScaleAspectFill;
    _myTaskADImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_myTaskADImageView];
    [_myTaskADImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    _myTaskPlateNumLabel = [UILabel new];
    _myTaskPlateNumLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskPlateNumLabel.font = [UIFont systemFontOfSize:14];
    _myTaskPlateNumLabel.textColor = [UIColor colorFromHexString:@"#212223" alpha:1.0];
    _myTaskPlateNumLabel.text = @"渝BHM789";
    [self addSubview:_myTaskPlateNumLabel];
    [_myTaskPlateNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(5);
        make.left.equalTo(_myTaskADImageView.right).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _myTaskCoinLabel = [UILabel new];
    _myTaskCoinLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskCoinLabel.font = [UIFont systemFontOfSize:10];
    _myTaskCoinLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _myTaskCoinLabel.text = @"30000币";
    [self addSubview:_myTaskCoinLabel];
    [_myTaskCoinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTaskPlateNumLabel.bottom).offset(10);
        make.left.equalTo(_myTaskADImageView.right).offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@10);
    }];
    
    _myTaskTimeLabel = [UILabel new];
    _myTaskTimeLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskTimeLabel.font = [UIFont systemFontOfSize:10];
    _myTaskTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _myTaskTimeLabel.text = @"自检时间:2016-10-12 2016-10-20";
    [self addSubview:_myTaskTimeLabel];
    [_myTaskTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTaskCoinLabel.bottom).offset(10);
        make.left.equalTo(_myTaskADImageView.right).offset(5);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@10);
    }];
    
    _myTaskAddressOrEndTimeLabel = [UILabel new];
    _myTaskAddressOrEndTimeLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskAddressOrEndTimeLabel.font = [UIFont systemFontOfSize:10];
    _myTaskAddressOrEndTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _myTaskAddressOrEndTimeLabel.text = @"结束时间:2016-11-12";
    [self addSubview:_myTaskAddressOrEndTimeLabel];
    [_myTaskAddressOrEndTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myTaskTimeLabel.bottom).offset(10);
        make.left.equalTo(_myTaskADImageView.right).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    _myTaskStatusLabel = [UILabel new];
    _myTaskStatusLabel.textAlignment = NSTextAlignmentCenter;
    _myTaskStatusLabel.font = [UIFont systemFontOfSize:15];
    _myTaskStatusLabel.textColor = [UIColor whiteColor];
    _myTaskStatusLabel.text = @"待自检";
    _myTaskStatusLabel.layer.cornerRadius = 20.0;
    _myTaskStatusLabel.layer.masksToBounds = YES;
    _myTaskStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ff231d" alpha:1.0];
    [self addSubview:_myTaskStatusLabel];
    [_myTaskStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(23);
        make.right.equalTo(separetedView0.right).offset(15);
        make.width.equalTo(@80);
        make.height.equalTo(@40);
    }];
    
    _myTaskSeparetedView = [UIView new];
    _myTaskSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e3e3e3" alpha:1.0];
    [self addSubview:_myTaskSeparetedView];
    [_myTaskSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
        make.top.equalTo(_myTaskADImageView.bottom).offset(5);
    }];
    
    _myTaskNoticeLabel = [UILabel new];
    _myTaskNoticeLabel.font = [UIFont systemFontOfSize:13];
    _myTaskNoticeLabel.textAlignment = NSTextAlignmentLeft;
    _myTaskNoticeLabel.textColor = [UIColor colorFromHexString:@"#ff8e07" alpha:1.0];
    [self addSubview:_myTaskNoticeLabel];
    [_myTaskNoticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@30);
        make.top.equalTo(_myTaskSeparetedView.bottom).offset(20);
    }];
    
    
    return self;
}




@end
