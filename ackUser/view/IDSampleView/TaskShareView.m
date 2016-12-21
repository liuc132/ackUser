//
//  TaskShareView.m
//  ackUser
//
//  Created by LiuC on 16/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "TaskShareView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

#define HorizontalSeparetedSpace    (SCREEN_WIDTH - 270)/4

@interface TaskShareView ()

@end

@implementation TaskShareView

-  (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.6];
    
    UIView *noteBackView = [UIView new];
    noteBackView.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.0];
    [self addSubview:noteBackView];
    [noteBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(80);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(SCREEN_WIDTH - 80));
    }];
    
    UIView *visualNoteView = [UIView new];
    visualNoteView.layer.cornerRadius = 4.0;
    visualNoteView.layer.masksToBounds = YES;
    [noteBackView addSubview:visualNoteView];
    [visualNoteView setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 20, 0, 20));
    }];
    
    UILabel *noteTitleLabel = [UILabel new];
    noteTitleLabel.text = @"点击分享到朋友圈";
    noteTitleLabel.textAlignment = NSTextAlignmentCenter;
    [noteTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [noteTitleLabel setTextColor:[UIColor whiteColor]];
    [noteTitleLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:155/255.0 blue:0 alpha:1.0]];
    [visualNoteView addSubview:noteTitleLabel];
    [noteTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visualNoteView.top);
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.height.equalTo(@40);
    }];
    
    _taskWechatShareButton = [UIButton new];
    [_taskWechatShareButton setTitle:@"微信好友" forState:UIControlStateNormal];
    [_taskWechatShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskWechatShareButton setImage:[UIImage imageNamed:@"icon_wechatShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskWechatShareButton];
    [_taskWechatShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(visualNoteView.left).offset(HorizontalSeparetedSpace);
        make.top.equalTo(noteTitleLabel.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskWechatShareButton titleLength:4];
    
    _taskQQShareButton = [UIButton new];
    [_taskQQShareButton setTitle:@"QQ好友" forState:UIControlStateNormal];
    [_taskQQShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskQQShareButton setImage:[UIImage imageNamed:@"icon_qqShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskQQShareButton];
    [_taskQQShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskWechatShareButton.right).offset(HorizontalSeparetedSpace);
        make.top.equalTo(noteTitleLabel.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskQQShareButton titleLength:4];
    
    _taskSinaWeboShareButton = [UIButton new];
    [_taskSinaWeboShareButton setTitle:@"新浪微博" forState:UIControlStateNormal];
    [_taskSinaWeboShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskSinaWeboShareButton setImage:[UIImage imageNamed:@"icon_sinaShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskSinaWeboShareButton];
    [_taskSinaWeboShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskQQShareButton.right).offset(HorizontalSeparetedSpace);
        make.top.equalTo(noteTitleLabel.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskSinaWeboShareButton titleLength:4];
    
    _taskWechatMomentsShareButton = [UIButton new];
    [_taskWechatMomentsShareButton setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [_taskWechatMomentsShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskWechatMomentsShareButton setImage:[UIImage imageNamed:@"icon_wechatMomentShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskWechatMomentsShareButton];
    [_taskWechatMomentsShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(visualNoteView.left).offset(HorizontalSeparetedSpace);
        make.top.equalTo(_taskWechatShareButton.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskWechatMomentsShareButton titleLength:5];
    
    _taskQQSpaceShareButton = [UIButton new];
    [_taskQQSpaceShareButton setTitle:@"QQ空间" forState:UIControlStateNormal];
    [_taskQQSpaceShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskQQSpaceShareButton setImage:[UIImage imageNamed:@"icon_qqSpaceShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskQQSpaceShareButton];
    [_taskQQSpaceShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskWechatMomentsShareButton.right).offset(HorizontalSeparetedSpace);
        make.top.equalTo(_taskWechatShareButton.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskQQSpaceShareButton titleLength:4];
    
    _taskCopyLinksShareButton = [UIButton new];
    [_taskCopyLinksShareButton setTitle:@"复制链接" forState:UIControlStateNormal];
    [_taskCopyLinksShareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_taskCopyLinksShareButton setImage:[UIImage imageNamed:@"icon_copyLinksShare_button"] forState:UIControlStateNormal];
    [visualNoteView addSubview:_taskCopyLinksShareButton];
    [_taskCopyLinksShareButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_taskQQSpaceShareButton.right).offset(HorizontalSeparetedSpace);
        make.top.equalTo(_taskWechatShareButton.bottom).offset(10);
        make.height.equalTo(@80);
        make.width.equalTo(@70);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_taskCopyLinksShareButton titleLength:4];
    
    
    _dismissTaskShareViewButton = [UIButton new];
    _dismissTaskShareViewButton.layer.cornerRadius = 15;
    _dismissTaskShareViewButton.layer.masksToBounds = YES;
    [_dismissTaskShareViewButton setImage:[UIImage imageNamed:@"Icon_taskShareDismiss"] forState:UIControlStateNormal];
    _dismissTaskShareViewButton.showsTouchWhenHighlighted = NO;
    [_dismissTaskShareViewButton addTarget:self action:@selector(dismissTaskShareViewAction) forControlEvents:UIControlEventTouchUpInside];
    [noteBackView addSubview:_dismissTaskShareViewButton];
    [_dismissTaskShareViewButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteBackView.top);
        make.right.equalTo(noteBackView.right).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    return self;
}

- (void)settingButtonImageAndTitlePositionWithButton:(UIButton *)sender  titleLength:(NSInteger)length
{
    [sender setTitleColor:[UIColor colorFromHexString:@"#2d2d2d" alpha:1.0] forState:UIControlStateNormal];
    
    CGSize titleSize = CGSizeMake(40.0, 20.0);
    CGSize imageSize = sender.imageView.bounds.size;
    CGFloat horizontalMoveLength = 0.0;
    switch (length) {
        case 2:
            horizontalMoveLength = 25.0;
            break;
            
        case 4:
            horizontalMoveLength = 50.0;
            break;
            
        case 5:
            horizontalMoveLength = 60.0;
            break;
            
        default:
            break;
    }
    
    CGFloat totalHeight = (imageSize.height + titleSize.height);
    sender.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, -horizontalMoveLength);
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

/**
 dismiss the IlegalNoteView
 */
- (void)dismissTaskShareViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
    
}

/**
 show the IlegalNoteView
 */
- (void)showTaskShareView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}








@end
