//
//  RemoveAccountView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "RemoveAccountView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation RemoveAccountView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.7];
    
    UIView *noteBackView = [UIView new];
    noteBackView.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.0];
    [self addSubview:noteBackView];
    [noteBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(80);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(SCREEN_WIDTH - 90));
    }];
    
    UIView *visualNoteView = [UIView new];
    visualNoteView.layer.cornerRadius = 4.0;
    visualNoteView.layer.masksToBounds = YES;
    [noteBackView addSubview:visualNoteView];
    [visualNoteView setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 20, 0, 20));
    }];
    
    _noteTitleLabel = [UILabel new];
    _noteTitleLabel.text = @"注销帐号";
    _noteTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_noteTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [_noteTitleLabel setTextColor:[UIColor whiteColor]];
    [_noteTitleLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:155/255.0 blue:0 alpha:1.0]];
    [visualNoteView addSubview:_noteTitleLabel];
    [_noteTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visualNoteView.top);
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.height.equalTo(@40);
    }];
    
    _noteSubTitleLabel = [UILabel new];
    _noteSubTitleLabel.numberOfLines = 0;
    _noteSubTitleLabel.text = @"注销后您的账号数据，包括所有爱车币及现金将一并被清空。确定要将此账户注销吗？";
    _noteSubTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_noteSubTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [_noteSubTitleLabel setTextColor:[UIColor colorFromHexString:@"#202020" alpha:1.0]];
    [_noteSubTitleLabel setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView addSubview:_noteSubTitleLabel];
    [_noteSubTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noteTitleLabel.bottom);
        make.left.equalTo(visualNoteView.left).offset(10);
        make.right.equalTo(visualNoteView.right).offset(-10);
        make.height.equalTo(@100);
    }];
    
    _removeAccountCancelButton = [UIButton new];
    _removeAccountCancelButton.layer.cornerRadius = 20.0;
    _removeAccountCancelButton.layer.masksToBounds = YES;
    [_removeAccountCancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_removeAccountCancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _removeAccountCancelButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [visualNoteView addSubview:_removeAccountCancelButton];
    [_removeAccountCancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-((SCREEN_WIDTH-100)/4 + 5)));
        make.width.equalTo(@((SCREEN_WIDTH-100)/2));
        make.top.equalTo(_noteSubTitleLabel.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    _removeAccountConfirmButton = [UIButton new];
    _removeAccountConfirmButton.layer.cornerRadius = 20.0;
    _removeAccountConfirmButton.layer.masksToBounds = YES;
    [_removeAccountConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_removeAccountConfirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _removeAccountConfirmButton.backgroundColor = [UIColor colorFromHexString:@"#00b9ed" alpha:1.0];
    [visualNoteView addSubview:_removeAccountConfirmButton];
    [_removeAccountConfirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@((SCREEN_WIDTH-100)/4 + 5));
        make.width.equalTo(@((SCREEN_WIDTH-100)/2));
        make.top.equalTo(_noteSubTitleLabel.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UIButton *dismissChargeSuccessNoteViewButton = [UIButton new];
    dismissChargeSuccessNoteViewButton.layer.cornerRadius = 15;
    dismissChargeSuccessNoteViewButton.layer.masksToBounds = YES;
    [dismissChargeSuccessNoteViewButton setImage:[UIImage imageNamed:@"Icon_taskShareDismiss"] forState:UIControlStateNormal];
    dismissChargeSuccessNoteViewButton.showsTouchWhenHighlighted = NO;
    [dismissChargeSuccessNoteViewButton addTarget:self action:@selector(dismissRemoveAccountViewAction) forControlEvents:UIControlEventTouchUpInside];
    [noteBackView addSubview:dismissChargeSuccessNoteViewButton];
    [dismissChargeSuccessNoteViewButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteBackView.top);
        make.right.equalTo(noteBackView.right).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    return self;
}

/**
 dismiss the RemoveAccountView
 */
- (void)dismissRemoveAccountViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
}

/**
 show the RemoveAccountView
 */
- (void)showRemoveAccountView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}


@end
