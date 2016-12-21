//
//  IDSampleView.h
//  ackUser
//
//  Created by LiuC on 16/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskShareView : UIView

@property (strong, nonatomic) UIButton      *dismissTaskShareViewButton;
@property (strong, nonatomic) UIButton      *taskWechatShareButton;
@property (strong, nonatomic) UIButton      *taskQQShareButton;
@property (strong, nonatomic) UIButton      *taskSinaWeboShareButton;
@property (strong, nonatomic) UIButton      *taskWechatMomentsShareButton;
@property (strong, nonatomic) UIButton      *taskQQSpaceShareButton;
@property (strong, nonatomic) UIButton      *taskCopyLinksShareButton;

/**
 dismiss the IlegalNoteView
 */
- (void)dismissTaskShareViewAction;

/**
 show the IlegalNoteView
 */
- (void)showTaskShareView;

@end
