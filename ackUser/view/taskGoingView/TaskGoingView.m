//
//  TaskGoingView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskGoingView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation TaskGoingView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _taskGoingADImageView = [UIImageView new];
    _taskGoingADImageView.layer.masksToBounds = YES;
    _taskGoingADImageView.contentMode = UIViewContentModeScaleAspectFill;
    _taskGoingADImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_taskGoingADImageView];
    [_taskGoingADImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    _taskGoingTaskNameLabel = [UILabel new];
    _taskGoingTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingTaskNameLabel.font = [UIFont systemFontOfSize:14];
    _taskGoingTaskNameLabel.textColor = [UIColor colorFromHexString:@"#212223" alpha:1.0];
    _taskGoingTaskNameLabel.text = @"任务名称任务名称任务名称";
    [self addSubview:_taskGoingTaskNameLabel];
    [_taskGoingTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingADImageView.top);
        make.left.equalTo(_taskGoingADImageView.right).offset(5);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(@20);
    }];
    
    _taskGoingPlateNumberLabel = [UILabel new];
    _taskGoingPlateNumberLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingPlateNumberLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingPlateNumberLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskGoingPlateNumberLabel.text = @"渝BHM789";
    [self addSubview:_taskGoingPlateNumberLabel];
    [_taskGoingPlateNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingTaskNameLabel.bottom).offset(10);
        make.left.equalTo(_taskGoingADImageView.right).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    _taskGoingStatusLabel = [UILabel new];
    _taskGoingStatusLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingStatusLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingStatusLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskGoingStatusLabel.text = @"当前状态:待自检";
    [self addSubview:_taskGoingStatusLabel];
    [_taskGoingStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingPlateNumberLabel.bottom).offset(10);
        make.left.equalTo(_taskGoingADImageView.right).offset(5);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    _taskGoingPeriodLabel = [UILabel new];
    _taskGoingPeriodLabel.numberOfLines = 0;
    _taskGoingPeriodLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingPeriodLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingPeriodLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    _taskGoingPeriodLabel.text = @"任务周期:30天(已发布15天)";
    [self addSubview:_taskGoingPeriodLabel];
    [_taskGoingPeriodLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingPlateNumberLabel.bottom).offset(10);
        make.left.equalTo(_taskGoingStatusLabel.right);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(@30);
    }];
    
    _taskGoingSelfCheckButton = [UIButton new];
    _taskGoingSelfCheckButton.layer.cornerRadius = 15.0;
    _taskGoingSelfCheckButton.layer.masksToBounds = YES;
    [_taskGoingSelfCheckButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    _taskGoingSelfCheckButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [_taskGoingSelfCheckButton setTitle:@"去自检" forState:UIControlStateNormal];
    [_taskGoingSelfCheckButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _taskGoingSelfCheckButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_taskGoingSelfCheckButton];
    [_taskGoingSelfCheckButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-5);
        make.top.equalTo(_taskGoingADImageView.top).offset(25);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_taskGoingPeriodLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _taskGoingAlreadyEarnedLabel = [UILabel new];
    _taskGoingAlreadyEarnedLabel.text = @"已赚取报酬:15000(币)";
    _taskGoingAlreadyEarnedLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingAlreadyEarnedLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingAlreadyEarnedLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingAlreadyEarnedLabel];
    [_taskGoingAlreadyEarnedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@130);
        make.height.equalTo(@20);
    }];
    
    _taskGoingEndTimeLabel = [UILabel new];
    _taskGoingEndTimeLabel.text = @"结束日期:2016-08-31";
    _taskGoingEndTimeLabel.textAlignment = NSTextAlignmentRight;
    _taskGoingEndTimeLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingEndTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingEndTimeLabel];
    [_taskGoingEndTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@130);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_taskGoingAlreadyEarnedLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _taskGoingInstallPartmentNameLabel = [UILabel new];
    _taskGoingInstallPartmentNameLabel.text = @"重庆市酷帖汽车改装中心";
    _taskGoingInstallPartmentNameLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingInstallPartmentNameLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingInstallPartmentNameLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingInstallPartmentNameLabel];
    [_taskGoingInstallPartmentNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    _taskGoingInstallTimeLabel = [UILabel new];
    _taskGoingInstallTimeLabel.text = @"安装时间:2016-09-09 9:00~10:00";
    _taskGoingInstallTimeLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingInstallTimeLabel.font = [UIFont systemFontOfSize:14];
    _taskGoingInstallTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingInstallTimeLabel];
    [_taskGoingInstallTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingInstallPartmentNameLabel.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    _taskGoingInstallAddressLabel = [UILabel new];
    _taskGoingInstallAddressLabel.text = @"门店地址:重庆北部新区星光大道海王星B座2-1号";
    _taskGoingInstallAddressLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingInstallAddressLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingInstallAddressLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingInstallAddressLabel];
    [_taskGoingInstallAddressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingInstallTimeLabel.bottom).offset(10);
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
        make.top.equalTo(_taskGoingInstallAddressLabel.top);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_taskGoingInstallAddressLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _taskGoingSelfCheckTimesLabel = [UILabel new];
    _taskGoingSelfCheckTimesLabel.text = @"自检次数:2次(已检验1次)";
    _taskGoingSelfCheckTimesLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingSelfCheckTimesLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingSelfCheckTimesLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingSelfCheckTimesLabel];
    [_taskGoingSelfCheckTimesLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    _taskGoingSelfCheckTimeLabel = [UILabel new];
    _taskGoingSelfCheckTimeLabel.text = @"自检时间:2016-7-30,2016-8-15";
    _taskGoingSelfCheckTimeLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingSelfCheckTimeLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingSelfCheckTimeLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingSelfCheckTimeLabel];
    [_taskGoingSelfCheckTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingSelfCheckTimesLabel.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@20);
    }];
    
    UILabel *selfCheckNoteLabel = [UILabel new];
    selfCheckNoteLabel.numberOfLines = 0;
    selfCheckNoteLabel.text = @"(检验时间的前三天和后三天检验通道会开启,请准时检验,逾期后将自动关闭任务。)";
    selfCheckNoteLabel.font = [UIFont systemFontOfSize:10];
    selfCheckNoteLabel.textAlignment = NSTextAlignmentLeft;
    selfCheckNoteLabel.textColor = [UIColor colorFromHexString:@"#f18209" alpha:1.0];
    [self addSubview:selfCheckNoteLabel];
    [selfCheckNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskGoingSelfCheckTimeLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView3 = [UIView new];
    horizonalSeparetedView3.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView3];
    [horizonalSeparetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(selfCheckNoteLabel.bottom).offset(10);
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
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@55);
        make.height.equalTo(@20);
    }];
    
    _taskGoingBusinessHotLineLabel = [UILabel new];
    _taskGoingBusinessHotLineLabel.text = @"023-90909801";
    _taskGoingBusinessHotLineLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingBusinessHotLineLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingBusinessHotLineLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingBusinessHotLineLabel];
    [_taskGoingBusinessHotLineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.left.equalTo(businessLabel.right);
        make.width.equalTo(@90);
        make.height.equalTo(@20);
    }];
    
    UIView *verticalSeparetedView = [UIView new];
    verticalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:verticalSeparetedView];
    [verticalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(horizonalSeparetedView3.bottom);
        make.width.equalTo(@1);
        make.height.equalTo(@40);
    }];
    
    _taskGoingACKHotLineLabel = [UILabel new];
    _taskGoingACKHotLineLabel.text = @"023-90909801";
    _taskGoingACKHotLineLabel.textAlignment = NSTextAlignmentLeft;
    _taskGoingACKHotLineLabel.font = [UIFont systemFontOfSize:12];
    _taskGoingACKHotLineLabel.textColor = [UIColor colorFromHexString:@"#717676" alpha:1.0];
    [self addSubview:_taskGoingACKHotLineLabel];
    [_taskGoingACKHotLineLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
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
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.right.equalTo(_taskGoingACKHotLineLabel.left);
        make.width.equalTo(@55);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView4 = [UIView new];
    horizonalSeparetedView4.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView4];
    [horizonalSeparetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(businessLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    
    return self;
}









@end
