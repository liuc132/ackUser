//
//  SampleNoteView.h
//  ackUser
//
//  Created by LiuC on 16/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SampleNoteView : UIView

@property (strong, nonatomic) UIButton      *dismissNoteViewButton;
@property (strong, nonatomic) UILabel       *noteTitleLabel;
@property (strong, nonatomic) UIImageView   *backImageView;


- (void)showSampleNoteView;
- (void)dismissSampleNoteViewAction;

@end
