//
//  WillHandleTaskView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/1.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WillHandleTaskView : UIView

@property (strong, nonatomic) UIImageView           *taskDetailADImageView;
@property (strong, nonatomic) UILabel               *taskDetailTaskNameLabel;
@property (strong, nonatomic) UILabel               *taskDetailPlateNumberLabel;
@property (strong, nonatomic) UILabel               *taskDetailStatusLabel;
@property (strong, nonatomic) UILabel               *taskDetailPeriodLabel;
@property (strong, nonatomic) UILabel               *taskDetailInstallPartmentNameLabel;
@property (strong, nonatomic) UILabel               *taskDetailInstallTimeLabel;
@property (strong, nonatomic) UILabel               *taskDetailInstallAddressLabel;

@property (strong, nonatomic) UILabel               *taskDetailBusinessHotLineLabel;
@property (strong, nonatomic) UILabel               *taskDetailACKHotLineLabel;

@end
