//
//  StopTaskView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopTaskView : UIView

@property (strong, nonatomic) UITextView                *stopTaskTextView;
@property (strong, nonatomic) UILabel                   *stopTaskWordCountLabel;

@property (strong, nonatomic) UIButton                  *stopTaskLeftSampleButton;
@property (strong, nonatomic) UIButton                  *stopTaskRightSampleButton;
@property (strong, nonatomic) UIImageView               *stopTaskLeftCarBodyImageView;
@property (strong, nonatomic) UIImageView               *stopTaskRightCarBodyImageView;
@property (strong, nonatomic) UIButton                  *stopTaskOdometerSampleButton;
@property (strong, nonatomic) UIImageView               *stopTaskOdometerImageView;
@property (strong, nonatomic) UIButton                  *stopTaskUploadRequestButton;
@property (strong, nonatomic) UIButton                  *stopTaskCloseDirectlyButton;

@end
