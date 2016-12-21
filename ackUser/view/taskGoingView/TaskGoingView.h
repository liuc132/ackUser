//
//  TaskGoingView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskGoingView : UIView

@property (strong, nonatomic) UIImageView           *taskGoingADImageView;
@property (strong, nonatomic) UILabel               *taskGoingTaskNameLabel;
@property (strong, nonatomic) UILabel               *taskGoingPlateNumberLabel;
@property (strong, nonatomic) UILabel               *taskGoingStatusLabel;
@property (strong, nonatomic) UILabel               *taskGoingPeriodLabel;
@property (strong, nonatomic) UIButton              *taskGoingSelfCheckButton;
@property (strong, nonatomic) UILabel               *taskGoingAlreadyEarnedLabel;
@property (strong, nonatomic) UILabel               *taskGoingEndTimeLabel;
@property (strong, nonatomic) UILabel               *taskGoingInstallPartmentNameLabel;
@property (strong, nonatomic) UILabel               *taskGoingInstallTimeLabel;
@property (strong, nonatomic) UILabel               *taskGoingInstallAddressLabel;
@property (strong, nonatomic) UILabel               *taskGoingSelfCheckTimesLabel;
@property (strong, nonatomic) UILabel               *taskGoingSelfCheckTimeLabel;

@property (strong, nonatomic) UILabel               *taskGoingBusinessHotLineLabel;
@property (strong, nonatomic) UILabel               *taskGoingACKHotLineLabel;

@end
