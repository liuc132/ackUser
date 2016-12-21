//
//  TasksListView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TasksListView : UIView

@property (strong, nonatomic) UIView        *taskAckCoinView;
@property (strong, nonatomic) UILabel       *taskAckCoinLabel;
@property (strong, nonatomic) UIView        *taskDeadTimeView;
@property (strong, nonatomic) UILabel       *taskDeadTimeLabel;
@property (strong, nonatomic) UIImageView   *taskADImageView;
@property (strong, nonatomic) UILabel       *taskNameLabel;
@property (strong, nonatomic) UILabel       *taskPeriodLabel;
@property (strong, nonatomic) UILabel       *taskRemainedQuotasLabel;
@property (strong, nonatomic) UIButton      *taskGetButton;//点击图标领取任务
@property (strong, nonatomic) UIImageView   *taskNewIconImageView;


@end
