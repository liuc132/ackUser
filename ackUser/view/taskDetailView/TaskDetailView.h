//
//  TaskDetailView.h
//  ackUser
//
//  Created by LiuC on 16/11/25.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDetailView : UIView

@property (strong, nonatomic) UIImageView       *taskDetailADImageView;
@property (strong, nonatomic) UILabel           *taskDetailTaskNameLabel;
@property (strong, nonatomic) UILabel           *taskDetailTaskDetailLabel;


@property (strong, nonatomic) UITextView        *otherExplainTextView;
@property (strong, nonatomic) UIButton          *taskDetailgetTaskRightNowButton;

@end
