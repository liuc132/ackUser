//
//  SampleNoteView.m
//  ackUser
//
//  Created by LiuC on 16/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SampleNoteView.h"
#import "ackUserPCH.pch"
#import "Masonry.h"


@implementation SampleNoteView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    //back color 126 127 128
    
    self.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.5];
    
    UIView *noteBackView = [UIView new];
    noteBackView.layer.cornerRadius = 4.0;
    noteBackView.layer.masksToBounds = YES;
    noteBackView.backgroundColor = [UIColor whiteColor];
    [self addSubview:noteBackView];
    [noteBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(30);
        make.width.equalTo(@(SCREEN_WIDTH - 60));
        make.height.equalTo(@(SCREEN_WIDTH - 80));
    }];
    
    UIView *visualNoteView = [UIView new];
    visualNoteView.layer.cornerRadius = 4.0;
    visualNoteView.layer.masksToBounds = YES;
    [noteBackView addSubview:visualNoteView];
    [visualNoteView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _noteTitleLabel = [UILabel new];
    _noteTitleLabel.text = @"行驶证照片(示例图)";
    _noteTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_noteTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [_noteTitleLabel setTextColor:[UIColor whiteColor]];
    [_noteTitleLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:155/255.0 blue:0 alpha:1.0]];
    [visualNoteView addSubview:_noteTitleLabel];
    [_noteTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visualNoteView.top);
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.height.equalTo(@30);
    }];
    
    _backImageView = [UIImageView new];
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backImageView.image = [UIImage imageNamed:@"icon_drivingLicense"];
    [visualNoteView addSubview:_backImageView];
    [_backImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noteTitleLabel.bottom).offset(5);
        make.left.equalTo(visualNoteView.left).offset(5);
        make.bottom.equalTo(visualNoteView.bottom).offset(-5);
        make.right.equalTo(visualNoteView.right).offset(-5);
    }];
    
    _dismissNoteViewButton = [UIButton new];
    [_dismissNoteViewButton setImage:[UIImage imageNamed:@"icon_myCar_dismiss"] forState:UIControlStateNormal];
    _dismissNoteViewButton.showsTouchWhenHighlighted = NO;
    [_dismissNoteViewButton addTarget:self action:@selector(dismissSampleNoteViewAction) forControlEvents:UIControlEventTouchUpInside];
    [noteBackView addSubview:_dismissNoteViewButton];
    [_dismissNoteViewButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteBackView.top).offset(-3);
        make.right.equalTo(noteBackView.right).offset(3);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    
    
    
    
    
    return self;
}

/**
 dismiss the IlegalNoteView
 */
- (void)dismissSampleNoteViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
    
}

/**
 show the IlegalNoteView
 */
- (void)showSampleNoteView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}



@end
