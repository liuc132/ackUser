//
//  HomeLocationSelectView.m
//  ackUser
//
//  Created by LiuC on 16/12/4.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeLocationSelectView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation HomeLocationSelectView


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
        make.height.equalTo(@(SCREEN_WIDTH - 120));
    }];
    
    UIView *visualNoteView = [UIView new];
    visualNoteView.layer.cornerRadius = 4.0;
    visualNoteView.layer.masksToBounds = YES;
    [noteBackView addSubview:visualNoteView];
    [visualNoteView setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 20, 0, 20));
    }];
    
    _headlineTitleLabel = [UILabel new];
    _headlineTitleLabel.text = @"您所定位的城市为";
    _headlineTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_headlineTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [_headlineTitleLabel setTextColor:[UIColor whiteColor]];
    [_headlineTitleLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:155/255.0 blue:0 alpha:1.0]];
    [visualNoteView addSubview:_headlineTitleLabel];
    [_headlineTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visualNoteView.top);
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.height.equalTo(@40);
    }];
    
    _addressContentView = [UIView new];
    [visualNoteView addSubview:_addressContentView];
    [_addressContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headlineTitleLabel.bottom).offset(20);
        make.centerX.equalTo(@0);
        make.height.equalTo(@30);
        make.width.equalTo(visualNoteView.width);
    }];
    
    _subTitleLabel = [UILabel new];
//    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.text = @"重庆市";
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_subTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [_subTitleLabel setTextColor:[UIColor colorFromHexString:@"#202020" alpha:1.0]];
    [_subTitleLabel setBackgroundColor:[UIColor whiteColor]];
    [_addressContentView addSubview:_subTitleLabel];
    [_subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_addressContentView);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
    UIImageView *addressArrowImageView = [UIImageView new];
    addressArrowImageView.contentMode = UIViewContentModeCenter;
    addressArrowImageView.image = [UIImage imageNamed:@"icon_homeLocation_downArrow"];
    [_addressContentView addSubview:addressArrowImageView];
    [addressArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_subTitleLabel.centerY);
        make.left.equalTo(_subTitleLabel.right);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [visualNoteView addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.top.equalTo(_addressContentView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _confirmAddressButton = [UIButton new];
    _confirmAddressButton.layer.cornerRadius = 15.0;
    _confirmAddressButton.layer.masksToBounds = YES;
    _confirmAddressButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [_confirmAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmAddressButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_confirmAddressButton setTitle:@"确定" forState:UIControlStateNormal];
    [self addSubview:_confirmAddressButton];
    [_confirmAddressButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(40);
        make.centerX.equalTo(@0);
        make.width.equalTo(@90);
        make.height.equalTo(@30);
    }];
    
    UIButton *dismissLocationViewButton = [UIButton new];
    dismissLocationViewButton.layer.cornerRadius = 15;
    dismissLocationViewButton.layer.masksToBounds = YES;
    [dismissLocationViewButton setImage:[UIImage imageNamed:@"Icon_taskShareDismiss"] forState:UIControlStateNormal];
    dismissLocationViewButton.showsTouchWhenHighlighted = NO;
    [dismissLocationViewButton addTarget:self action:@selector(dismissHomeLocationSelectView) forControlEvents:UIControlEventTouchUpInside];
    [noteBackView addSubview:dismissLocationViewButton];
    [dismissLocationViewButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteBackView.top);
        make.right.equalTo(noteBackView.right).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    
    return self;
}






/**
 dismiss the HomeLocationSelectView
 */
- (void)dismissHomeLocationSelectView
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
}

/**
 show the HomeLocationSelectView
 */
- (void)showHomeLocationSelectView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}


@end
