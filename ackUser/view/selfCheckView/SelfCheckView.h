//
//  SelfCheckView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCheckView : UIView

@property (strong, nonatomic) UIButton          *leftSampleButton;
@property (strong, nonatomic) UIButton          *rightSampleButton;
@property (strong, nonatomic) UIImageView       *leftCarBodyImageView;
@property (strong, nonatomic) UIImageView       *rightCarBodyImageView;
@property (strong, nonatomic) UIButton          *odometerSampleButton;
@property (strong, nonatomic) UIImageView       *odometerImageView;
@property (strong, nonatomic) UIButton          *uploadRequestButton;


@end
