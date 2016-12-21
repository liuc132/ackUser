//
//  MyTaskListView.h
//  ackUser
//
//  Created by LiuC on 16/11/26.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTaskListView : UIView

@property (strong, nonatomic) UILabel       *myTaskNameLabel;
@property (strong, nonatomic) UIImageView   *myTaskADImageView;
@property (strong, nonatomic) UILabel       *myTaskPlateNumLabel;
@property (strong, nonatomic) UILabel       *myTaskCoinLabel;
@property (strong, nonatomic) UILabel       *myTaskTimeLabel;
@property (strong, nonatomic) UILabel       *myTaskAddressOrEndTimeLabel;
@property (strong, nonatomic) UILabel       *myTaskStatusLabel;
@property (strong, nonatomic) UIView        *myTaskSeparetedView;
@property (strong, nonatomic) UILabel       *myTaskNoticeLabel;


@end
