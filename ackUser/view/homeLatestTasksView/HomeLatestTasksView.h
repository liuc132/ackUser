//
//  HomeLatestTasksView.h
//  ackUser
//
//  Created by LiuC on 16/11/24.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLatestTasksView : UIView

@property (strong, nonatomic) UIView        *moreTasksView;
@property (strong, nonatomic) UIView        *latestTaskView;
@property (strong, nonatomic) UIView        *secondTaskView;
@property (strong, nonatomic) UIView        *thirdTaskView;
@property (strong, nonatomic) UIImageView   *latestTaskImageView;
@property (strong, nonatomic) UILabel       *latestTaskNameLabel;
@property (strong, nonatomic) UILabel       *latestTaskMoneyLabel;
@property (strong, nonatomic) UILabel       *secondTaskNameLabel;
@property (strong, nonatomic) UILabel       *secondTaskMoneyLabel;
@property (strong, nonatomic) UILabel       *thirdTaskNameLabel;
@property (strong, nonatomic) UILabel       *thirdTaskMoneyLabel;



@end
