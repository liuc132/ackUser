//
//  WillHandleTaskView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/1.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "WillHandleTaskView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation WillHandleTaskView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _taskDetailADImageView = [UIImageView new];
    _taskDetailADImageView.layer.masksToBounds = YES;
    _taskDetailADImageView.contentMode = UIViewContentModeScaleAspectFill;
    _taskDetailADImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_taskDetailADImageView];
    [_taskDetailADImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    _taskDetailTaskNameLabel = [UILabel new];
    _taskDetailTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailTaskNameLabel.font = [UIFont systemFontOfSize:14];
    _taskDetailTaskNameLabel.textColor = [UIColor colorFromHexString:@"#212223" alpha:1.0];
    _taskDetailTaskNameLabel.text = @"任务名称任务名称任务名称";
    [self addSubview:_taskDetailTaskNameLabel];
    [_taskDetailTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(_taskDetailADImageView.right).offset(5);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(@20);
    }];
    
    _taskDetailPlateNumberLabel = [UILabel new];
    _taskDetailPlateNumberLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailPlateNumberLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailPlateNumberLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskDetailPlateNumberLabel.text = @"渝BHM789";
    [self addSubview:_taskDetailPlateNumberLabel];
    [_taskDetailPlateNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailTaskNameLabel.bottom).offset(10);
        make.left.equalTo(_taskDetailADImageView.right).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _taskDetailStatusLabel = [UILabel new];
    _taskDetailStatusLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailStatusLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailStatusLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskDetailStatusLabel.text = @"当前状态:待安装";
    [self addSubview:_taskDetailStatusLabel];
    [_taskDetailStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailPlateNumberLabel.bottom).offset(10);
        make.left.equalTo(_taskDetailADImageView.right).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    _taskDetailPeriodLabel = [UILabel new];
    _taskDetailPeriodLabel.textAlignment = NSTextAlignmentRight;
    _taskDetailPeriodLabel.font = [UIFont systemFontOfSize:10];
    _taskDetailPeriodLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskDetailPeriodLabel.text = @"任务周期:30天";
    [self addSubview:_taskDetailPeriodLabel];
    [_taskDetailPeriodLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailPlateNumberLabel.bottom).offset(10);
        make.right.equalTo(self.right).offset(-5);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_taskDetailADImageView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _taskDetailInstallPartmentNameLabel = [UILabel new];
    _taskDetailInstallPartmentNameLabel.text = @"重庆市酷帖汽车改装中心";
    _taskDetailInstallPartmentNameLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailInstallPartmentNameLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailInstallPartmentNameLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskDetailInstallPartmentNameLabel];
    [_taskDetailInstallPartmentNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    _taskDetailInstallTimeLabel = [UILabel new];
    _taskDetailInstallTimeLabel.text = @"安装时间:2016-09-09 9:00~10:00";
    _taskDetailInstallTimeLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailInstallTimeLabel.font = [UIFont systemFontOfSize:14];
    _taskDetailInstallTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskDetailInstallTimeLabel];
    [_taskDetailInstallTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailInstallPartmentNameLabel.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    _taskDetailInstallAddressLabel = [UILabel new];
    _taskDetailInstallAddressLabel.text = @"门店地址:重庆北部新区星光大道海王星B座2-1号";
    _taskDetailInstallAddressLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailInstallAddressLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailInstallAddressLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskDetailInstallAddressLabel];
    [_taskDetailInstallAddressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailInstallTimeLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 50));
        make.height.equalTo(@20);
    }];
    
    UIImageView *locationIconImageView = [UIImageView new];
    locationIconImageView.contentMode = UIViewContentModeCenter;
    UIImage *locationImage = [UIImage imageNamed:@"icon_myApplication_location"];
    locationIconImageView.image = [locationImage imageWithColor:[UIColor colorFromHexString:@"#7c8180" alpha:1.0]];
    [self addSubview:locationIconImageView];
    [locationIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailInstallAddressLabel.top);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_taskDetailInstallAddressLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    UILabel *businessLabel = [UILabel new];
    businessLabel.text = @"联系商家:";
    businessLabel.font = [UIFont systemFontOfSize:12];
    businessLabel.textAlignment = NSTextAlignmentLeft;
    businessLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [self addSubview:businessLabel];
    [businessLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@55);
        make.height.equalTo(@20);
    }];
    
    _taskDetailBusinessHotLineLabel = [UILabel new];
    _taskDetailBusinessHotLineLabel.text = @"023-90909801";
    _taskDetailBusinessHotLineLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailBusinessHotLineLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailBusinessHotLineLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskDetailBusinessHotLineLabel];
    [_taskDetailBusinessHotLineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.left.equalTo(businessLabel.right);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    _taskDetailACKHotLineLabel = [UILabel new];
    _taskDetailACKHotLineLabel.text = @"023-90909801";
    _taskDetailACKHotLineLabel.textAlignment = NSTextAlignmentLeft;
    _taskDetailACKHotLineLabel.font = [UIFont systemFontOfSize:12];
    _taskDetailACKHotLineLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskDetailACKHotLineLabel];
    [_taskDetailACKHotLineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UILabel *platformLabel = [UILabel new];
    platformLabel.text = @"联系平台:";
    platformLabel.font = [UIFont systemFontOfSize:12];
    platformLabel.textAlignment = NSTextAlignmentLeft;
    platformLabel.textColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [self addSubview:platformLabel];
    [platformLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.right.equalTo(_taskDetailACKHotLineLabel.left);
        make.width.equalTo(@55);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(businessLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    
    return self;
}

@end
