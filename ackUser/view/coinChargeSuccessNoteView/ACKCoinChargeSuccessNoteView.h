//
//  ACKCoinChargeSuccessNoteView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACKCoinChargeSuccessNoteView : UIView

@property (strong, nonatomic) UIButton      *chargeSuccessBackHomePageButton;
@property (strong, nonatomic) UIButton      *chargeSuccessRobTaskButton;

/**
 dismiss the ChargeSuccessNoteView
 */
- (void)dismissChargeSuccessNoteViewAction;

/**
 show the ChargeSuccessNoteView
 */
- (void)showChargeSuccessNoteView;


@end
