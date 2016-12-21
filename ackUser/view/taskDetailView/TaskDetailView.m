//
//  TaskDetailView.m
//  ackUser
//
//  Created by LiuC on 16/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskDetailView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "UITextView+Placeholder.h"
#import "Masonry.h"

@interface TaskDetailView ()<UIGestureRecognizerDelegate, UIScrollViewDelegate>

@end

@implementation TaskDetailView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIScrollView *detailScrollView = [UIScrollView new];
    detailScrollView.delegate = self;
    detailScrollView.scrollEnabled = YES;
    detailScrollView.showsVerticalScrollIndicator = YES;
    detailScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:detailScrollView];
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contentView = [UIView new];
    [detailScrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(detailScrollView);
        make.width.equalTo(detailScrollView);
    }];
    
    _taskDetailADImageView = [UIImageView new];
    _taskDetailADImageView.contentMode = UIViewContentModeScaleAspectFill;
    _taskDetailADImageView.image = [UIImage imageNamed:@"icon_taskDetail_AD"];
    [contentView addSubview:_taskDetailADImageView];
    [_taskDetailADImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top);
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.height.equalTo(@120);
    }];
    
    _taskDetailTaskNameLabel = [UILabel new];
    _taskDetailTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    [_taskDetailTaskNameLabel setFont:[UIFont systemFontOfSize:13]];
    _taskDetailTaskNameLabel.text = @"金科地产(18年一子定天元)";
    [contentView addSubview:_taskDetailTaskNameLabel];
    [_taskDetailTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_taskDetailADImageView.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_taskDetailTaskNameLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _taskDetailTaskDetailLabel = [UILabel new];
    _taskDetailTaskDetailLabel.numberOfLines = 0;
    _taskDetailTaskDetailLabel.textAlignment = NSTextAlignmentLeft;
    [_taskDetailTaskDetailLabel setFont:[UIFont systemFontOfSize:13]];
    _taskDetailTaskDetailLabel.text = @"我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字,我是一段广告详情的文字。";
    [contentView addSubview:_taskDetailTaskDetailLabel];
    [_taskDetailTaskDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@100);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_taskDetailTaskDetailLabel.bottom).offset(30);
        make.height.equalTo(@4);
    }];
    
    UIImageView *taskRequireImageView = [UIImageView new];
    taskRequireImageView.contentMode = UIViewContentModeScaleAspectFill;
    taskRequireImageView.image = [UIImage imageNamed:@"icon_taskDetail_title"];
    [contentView addSubview:taskRequireImageView];
    [taskRequireImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(separetedView1.bottom).offset(-22);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    UILabel *taskRequireLabel = [UILabel new];
    taskRequireLabel.textAlignment = NSTextAlignmentCenter;
    taskRequireLabel.textColor = [UIColor whiteColor];
    [taskRequireLabel setFont:[UIFont systemFontOfSize:13]];
    taskRequireLabel.text = @"招募要求";
    [taskRequireImageView addSubview:taskRequireLabel];
    [taskRequireLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(taskRequireImageView);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIImageView *carTypeImageView = [UIImageView new];
    carTypeImageView.contentMode = UIViewContentModeCenter;
    carTypeImageView.image = [UIImage imageNamed:@"icon_taskDetail_carType"];
    [contentView addSubview:carTypeImageView];
    [carTypeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(taskRequireImageView.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *carTypeNoteLabel = [UILabel new];
    carTypeNoteLabel.text = @"车型";
    carTypeNoteLabel.font = [UIFont systemFontOfSize:13];
    carTypeNoteLabel.textAlignment = NSTextAlignmentLeft;
    carTypeNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:carTypeNoteLabel];
    [carTypeNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskRequireImageView.bottom).offset(10);
        make.left.equalTo(carTypeImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *rightCarTypesLabel = [UILabel new];
    rightCarTypesLabel.text = @"小车，SUV，越野";
    rightCarTypesLabel.font = [UIFont systemFontOfSize:10];
    rightCarTypesLabel.textAlignment = NSTextAlignmentRight;
    rightCarTypesLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [contentView addSubview:rightCarTypesLabel];
    [rightCarTypesLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskRequireImageView.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView2 = [UIView new];
    separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView2];
    [separetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carTypeImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *mileageImageView = [UIImageView new];
    mileageImageView.contentMode = UIViewContentModeCenter;
    mileageImageView.image = [UIImage imageNamed:@"icon_taskDetail_mileage"];
    [contentView addSubview:mileageImageView];
    [mileageImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *mileageNoteLabel = [UILabel new];
    mileageNoteLabel.text = @"日均里程";
    mileageNoteLabel.font = [UIFont systemFontOfSize:13];
    mileageNoteLabel.textAlignment = NSTextAlignmentLeft;
    mileageNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:mileageNoteLabel];
    [mileageNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.left.equalTo(mileageImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *mileagePerDayNoteLabel = [UILabel new];
    mileagePerDayNoteLabel.text = @">30km";
    mileagePerDayNoteLabel.font = [UIFont systemFontOfSize:10];
    mileagePerDayNoteLabel.textAlignment = NSTextAlignmentRight;
    mileagePerDayNoteLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [self addSubview:mileagePerDayNoteLabel];
    [mileagePerDayNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView3 = [UIView new];
    separetedView3.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView3];
    [separetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(mileageImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *taskRegionImageView = [UIImageView new];
    taskRegionImageView.contentMode = UIViewContentModeCenter;
    taskRegionImageView.image = [UIImage imageNamed:@"icon_taskDetail_carType"];
    [contentView addSubview:taskRegionImageView];
    [taskRegionImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskRegionNoteLabel = [UILabel new];
    taskRegionNoteLabel.text = @"区域";
    taskRegionNoteLabel.font = [UIFont systemFontOfSize:13];
    taskRegionNoteLabel.textAlignment = NSTextAlignmentLeft;
    taskRegionNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:taskRegionNoteLabel];
    [taskRegionNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.left.equalTo(mileageImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskRegionNoteDetailLabel = [UILabel new];
    taskRegionNoteDetailLabel.text = @"渝中,九龙坡,江北";
    taskRegionNoteDetailLabel.font = [UIFont systemFontOfSize:10];
    taskRegionNoteDetailLabel.textAlignment = NSTextAlignmentRight;
    taskRegionNoteDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [self addSubview:taskRegionNoteDetailLabel];
    [taskRegionNoteDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView4 = [UIView new];
    separetedView4.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView4];
    [separetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(taskRegionImageView.bottom).offset(30);
        make.height.equalTo(@4);
    }];
    
    UIImageView *taskExplainImageView = [UIImageView new];
    taskExplainImageView.contentMode = UIViewContentModeScaleAspectFill;
    taskExplainImageView.image = [UIImage imageNamed:@"icon_taskDetail_title"];
    [contentView addSubview:taskExplainImageView];
    [taskExplainImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(separetedView4.bottom).offset(-22);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    UILabel *taskExplainLabel = [UILabel new];
    taskExplainLabel.textAlignment = NSTextAlignmentCenter;
    taskExplainLabel.textColor = [UIColor whiteColor];
    [taskExplainLabel setFont:[UIFont systemFontOfSize:13]];
    taskExplainLabel.text = @"任务说明";
    [taskExplainImageView addSubview:taskExplainLabel];
    [taskExplainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(taskExplainImageView);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIImageView *taskPeriodImageView = [UIImageView new];
    taskPeriodImageView.contentMode = UIViewContentModeCenter;
    taskPeriodImageView.image = [UIImage imageNamed:@"icon_taskDetail_period"];
    [contentView addSubview:taskPeriodImageView];
    [taskPeriodImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(taskExplainImageView.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskPeriodNoteLabel = [UILabel new];
    taskPeriodNoteLabel.text = @"任务周期";
    taskPeriodNoteLabel.font = [UIFont systemFontOfSize:13];
    taskPeriodNoteLabel.textAlignment = NSTextAlignmentLeft;
    taskPeriodNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:taskPeriodNoteLabel];
    [taskPeriodNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskExplainImageView.bottom).offset(10);
        make.left.equalTo(taskPeriodImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskPeriodDetailLabel = [UILabel new];
    taskPeriodDetailLabel.text = @"30天";
    taskPeriodDetailLabel.font = [UIFont systemFontOfSize:10];
    taskPeriodDetailLabel.textAlignment = NSTextAlignmentRight;
    taskPeriodDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [contentView addSubview:taskPeriodDetailLabel];
    [taskPeriodDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taskExplainImageView.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView5 = [UIView new];
    separetedView5.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView5];
    [separetedView5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(taskPeriodImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *recruitImageView = [UIImageView new];
    recruitImageView.contentMode = UIViewContentModeCenter;
    recruitImageView.image = [UIImage imageNamed:@"icon_taskDetail_count"];
    [contentView addSubview:recruitImageView];
    [recruitImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *recruitNoteLabel = [UILabel new];
    recruitNoteLabel.text = @"招募数量";
    recruitNoteLabel.font = [UIFont systemFontOfSize:13];
    recruitNoteLabel.textAlignment = NSTextAlignmentLeft;
    recruitNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:recruitNoteLabel];
    [recruitNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.left.equalTo(recruitImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *recruitDetailLabel = [UILabel new];
    recruitDetailLabel.text = @"1000台";
    recruitDetailLabel.font = [UIFont systemFontOfSize:10];
    recruitDetailLabel.textAlignment = NSTextAlignmentRight;
    recruitDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [self addSubview:recruitDetailLabel];
    [recruitDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView6 = [UIView new];
    separetedView6.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView6];
    [separetedView6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(recruitImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *recruitDeadTimeImageView = [UIImageView new];
    recruitDeadTimeImageView.contentMode = UIViewContentModeCenter;
    recruitDeadTimeImageView.image = [UIImage imageNamed:@"icon_taskDetail_deadTime"];
    [contentView addSubview:recruitDeadTimeImageView];
    [recruitDeadTimeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *recruitDeadTimeLabel = [UILabel new];
    recruitDeadTimeLabel.text = @"招募时限";
    recruitDeadTimeLabel.font = [UIFont systemFontOfSize:13];
    recruitDeadTimeLabel.textAlignment = NSTextAlignmentLeft;
    recruitDeadTimeLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:recruitDeadTimeLabel];
    [recruitDeadTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.left.equalTo(recruitDeadTimeImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *recruitDeadTimeDetailLabel = [UILabel new];
    recruitDeadTimeDetailLabel.text = @"2016-08-01前";
    recruitDeadTimeDetailLabel.font = [UIFont systemFontOfSize:10];
    recruitDeadTimeDetailLabel.textAlignment = NSTextAlignmentRight;
    recruitDeadTimeDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [self addSubview:recruitDeadTimeDetailLabel];
    [recruitDeadTimeDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView7 = [UIView new];
    separetedView7.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView7];
    [separetedView7 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(recruitDeadTimeImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *taskRewardImageView = [UIImageView new];
    taskRewardImageView.contentMode = UIViewContentModeCenter;
    taskRewardImageView.image = [UIImage imageNamed:@"icon_taskDetail_reward"];
    [contentView addSubview:taskRewardImageView];
    [taskRewardImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView7.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskRewardLabel = [UILabel new];
    taskRewardLabel.text = @"任务报酬";
    taskRewardLabel.font = [UIFont systemFontOfSize:13];
    taskRewardLabel.textAlignment = NSTextAlignmentLeft;
    taskRewardLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:taskRewardLabel];
    [taskRewardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView7.bottom).offset(10);
        make.left.equalTo(taskRewardImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *taskRewardDetailLabel = [UILabel new];
    taskRewardDetailLabel.text = @"3000币";
    taskRewardDetailLabel.font = [UIFont systemFontOfSize:10];
    taskRewardDetailLabel.textAlignment = NSTextAlignmentRight;
    taskRewardDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [self addSubview:taskRewardDetailLabel];
    [taskRewardDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView7.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView8 = [UIView new];
    separetedView8.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView8];
    [separetedView8 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(taskRewardImageView.bottom).offset(30);
        make.height.equalTo(@4);
    }];
    
    UIImageView *installExplainImageView = [UIImageView new];
    installExplainImageView.contentMode = UIViewContentModeScaleAspectFill;
    installExplainImageView.image = [UIImage imageNamed:@"icon_taskDetail_title"];
    [contentView addSubview:installExplainImageView];
    [installExplainImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(separetedView8.bottom).offset(-22);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    UILabel *installExplainLabel = [UILabel new];
    installExplainLabel.textAlignment = NSTextAlignmentCenter;
    installExplainLabel.textColor = [UIColor whiteColor];
    [installExplainLabel setFont:[UIFont systemFontOfSize:13]];
    installExplainLabel.text = @"安装说明";
    [installExplainImageView addSubview:installExplainLabel];
    [installExplainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(installExplainImageView);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIImageView *installTimeImageView = [UIImageView new];
    installTimeImageView.contentMode = UIViewContentModeCenter;
    installTimeImageView.image = [UIImage imageNamed:@"icon_taskDetail_installTime"];
    [contentView addSubview:installTimeImageView];
    [installTimeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(installExplainImageView.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *installTimeLabel = [UILabel new];
    installTimeLabel.text = @"安装时间";
    installTimeLabel.font = [UIFont systemFontOfSize:13];
    installTimeLabel.textAlignment = NSTextAlignmentLeft;
    installTimeLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:installTimeLabel];
    [installTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(installExplainImageView.bottom).offset(10);
        make.left.equalTo(taskRewardImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UILabel *installTimeDetailLabel = [UILabel new];
    installTimeDetailLabel.text = @"2016-7-30~2016-7-31";
    installTimeDetailLabel.font = [UIFont systemFontOfSize:10];
    installTimeDetailLabel.textAlignment = NSTextAlignmentRight;
    installTimeDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [contentView addSubview:installTimeDetailLabel];
    [installTimeDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(installExplainImageView.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.width.equalTo(@120);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView9 = [UIView new];
    separetedView9.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView9];
    [separetedView9 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(installTimeImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *installAddressImageView = [UIImageView new];
    installAddressImageView.contentMode = UIViewContentModeCenter;
    installAddressImageView.image = [UIImage imageNamed:@"icon_taskDetail_address"];
    [contentView addSubview:installAddressImageView];
    [installAddressImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *installAddressLabel = [UILabel new];
    installAddressLabel.text = @"安装地址";
    installAddressLabel.font = [UIFont systemFontOfSize:13];
    installAddressLabel.textAlignment = NSTextAlignmentLeft;
    installAddressLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [contentView addSubview:installAddressLabel];
    [installAddressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.left.equalTo(installAddressImageView.right);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    UIImageView *installLocationImageView = [UIImageView new];
    installLocationImageView.contentMode = UIViewContentModeCenter;
    installLocationImageView.image = [UIImage imageNamed:@"icon_taskDetail_navigation"];
    [contentView addSubview:installLocationImageView];
    [installLocationImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.width.equalTo(@10);
        make.height.equalTo(@20);
    }];
    
    UILabel *installAddressDetailLabel = [UILabel new];
    installAddressDetailLabel.text = @"九龙坡区谢家湾华润二十四城营销中心";
    installAddressDetailLabel.font = [UIFont systemFontOfSize:10];
    installAddressDetailLabel.textAlignment = NSTextAlignmentRight;
    installAddressDetailLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [contentView addSubview:installAddressDetailLabel];
    [installAddressDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.right.equalTo(installLocationImageView.left);
        make.width.equalTo(@140);
        make.height.equalTo(@20);
    }];
    
    UIView *separetedView10 = [UIView new];
    separetedView10.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView10];
    [separetedView10 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(installAddressImageView.bottom).offset(30);
        make.height.equalTo(@4);
    }];
    
    UIImageView *otherExplainImageView = [UIImageView new];
    otherExplainImageView.contentMode = UIViewContentModeScaleAspectFill;
    otherExplainImageView.image = [UIImage imageNamed:@"icon_taskDetail_title"];
    [contentView addSubview:otherExplainImageView];
    [otherExplainImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(separetedView10.bottom).offset(-22);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    
    UILabel *otherExplainLabel = [UILabel new];
    otherExplainLabel.textAlignment = NSTextAlignmentCenter;
    otherExplainLabel.textColor = [UIColor whiteColor];
    [otherExplainLabel setFont:[UIFont systemFontOfSize:13]];
    otherExplainLabel.text = @"其他说明";
    [otherExplainImageView addSubview:otherExplainLabel];
    [otherExplainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(otherExplainImageView);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _otherExplainTextView = [UITextView new];
    _otherExplainTextView.placeholder = @"其他说明";
    _otherExplainTextView.placeholderColor = [UIColor colorFromHexString:@"#c9c8ce" alpha:1.0];
//    feedBackView.delegate = self;
    [contentView addSubview:_otherExplainTextView];
    [_otherExplainTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherExplainImageView.bottom).offset(10);
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.height.equalTo(@60);
    }];
    
    _taskDetailgetTaskRightNowButton = [UIButton new];
    [_taskDetailgetTaskRightNowButton setTitle:@"立即领取" forState:UIControlStateNormal];
    [_taskDetailgetTaskRightNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _taskDetailgetTaskRightNowButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [contentView addSubview:_taskDetailgetTaskRightNowButton];
    [_taskDetailgetTaskRightNowButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_otherExplainTextView.bottom).offset(10);
        make.height.equalTo(@44);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_taskDetailgetTaskRightNowButton.bottom);
    }];
    
    
    
    return self;
}




@end
