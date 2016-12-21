//
//  SetExchangePWView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SetExchangePWView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation SetExchangePWView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIScrollView *detailScrollView = [UIScrollView new];
    detailScrollView.scrollEnabled = YES;
    detailScrollView.showsVerticalScrollIndicator = YES;
    detailScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:detailScrollView];
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contentView = [UIView new];
    [detailScrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(detailScrollView);
        make.width.equalTo(detailScrollView);
    }];
    
    UILabel *passwordLabel = [UILabel new];
    passwordLabel.text = @"新密码";
    passwordLabel.textAlignment = NSTextAlignmentLeft;
//    passwordLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [contentView addSubview:passwordLabel];
    [passwordLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(contentView.top).offset(30);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _passwordTextField = [UITextField new];
    _passwordTextField.userInteractionEnabled = YES;
    _passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _passwordTextField.placeholder = @"请设置交易密码";
    [_passwordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_passwordTextField];
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLabel.right).offset(5);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(contentView.top).offset(30);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(passwordLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    UILabel *reInputPasswordLabel = [UILabel new];
    reInputPasswordLabel.text = @"确认新密码";
    reInputPasswordLabel.textAlignment = NSTextAlignmentLeft;
//    reInputPasswordLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [contentView addSubview:reInputPasswordLabel];
    [reInputPasswordLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.width.equalTo(@90);
        make.height.equalTo(@30);
    }];
    
    _confirmPasswordTextField = [UITextField new];
    _confirmPasswordTextField.userInteractionEnabled = YES;
    _confirmPasswordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _confirmPasswordTextField.placeholder = @"请重复您的交易密码";
    [_confirmPasswordTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_confirmPasswordTextField];
    [_confirmPasswordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reInputPasswordLabel.right).offset(5);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(reInputPasswordLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@5);
    }];
    
    UILabel *setPasswordNoteLabel = [UILabel new];
    setPasswordNoteLabel.text = @"请设置密保问题";
    setPasswordNoteLabel.textAlignment = NSTextAlignmentLeft;
//    setPasswordNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [contentView addSubview:setPasswordNoteLabel];
    [setPasswordNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView6 = [UIView new];
    horizonalSeparetedView6.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView6];
    [horizonalSeparetedView6 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(setPasswordNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    _firstSecretQuestionContentView = [UIView new];
    [contentView addSubview:_firstSecretQuestionContentView];
    [_firstSecretQuestionContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView6.bottom).offset(10);
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.height.equalTo(@30);
    }];
    
    UILabel *firstQuestionNoteLabel = [UILabel new];
    firstQuestionNoteLabel.text = @"密保问题";
    firstQuestionNoteLabel.textAlignment = NSTextAlignmentLeft;
//    firstQuestionNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [_firstSecretQuestionContentView addSubview:firstQuestionNoteLabel];
    [firstQuestionNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.centerY.equalTo(_firstSecretQuestionContentView.centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _firstSecretQuestionLabel = [UILabel new];
    _firstSecretQuestionLabel.text = @"你的父亲姓名是什么?";
    _firstSecretQuestionLabel.textAlignment = NSTextAlignmentLeft;
    _firstSecretQuestionLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [_firstSecretQuestionContentView addSubview:_firstSecretQuestionLabel];
    [_firstSecretQuestionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstQuestionNoteLabel.right).offset(10);
        make.centerY.equalTo(_firstSecretQuestionContentView.centerY);
        make.right.equalTo(_firstSecretQuestionContentView.right).offset(-30);
        make.height.equalTo(@30);
    }];
    
    UIImageView *downArrowImageView = [UIImageView new];
    downArrowImageView.contentMode = UIViewContentModeCenter;
    UIImage *downImage = [[UIImage imageNamed:@"icon_downArrow"] imageWithColor:[UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0]];
    downArrowImageView.image = downImage;
    [_firstSecretQuestionContentView addSubview:downArrowImageView];
    [downArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_firstSecretQuestionContentView.centerY);
        make.right.equalTo(_firstSecretQuestionContentView.right).offset(-10);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_firstSecretQuestionContentView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    UILabel *firstQuestionAnswerNoteLabel = [UILabel new];
    firstQuestionAnswerNoteLabel.text = @"密保答案";
    firstQuestionAnswerNoteLabel.textAlignment = NSTextAlignmentLeft;
//    firstQuestionAnswerNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [contentView addSubview:firstQuestionAnswerNoteLabel];
    [firstQuestionAnswerNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _firstSecretQuestionTextField = [UITextField new];
    _firstSecretQuestionTextField.userInteractionEnabled = YES;
    _firstSecretQuestionTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _firstSecretQuestionTextField.placeholder = @"密保答案";
    [_firstSecretQuestionTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _firstSecretQuestionTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_firstSecretQuestionTextField];
    [_firstSecretQuestionTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstQuestionAnswerNoteLabel.right).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView3 = [UIView new];
    horizonalSeparetedView3.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView3];
    [horizonalSeparetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(firstQuestionAnswerNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    _secondSecretQuestionContentView = [UIView new];
    [contentView addSubview:_secondSecretQuestionContentView];
    [_secondSecretQuestionContentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.height.equalTo(@30);
    }];
    
    UILabel *secondQuestionNoteLabel = [UILabel new];
    secondQuestionNoteLabel.text = @"密保问题";
    secondQuestionNoteLabel.textAlignment = NSTextAlignmentLeft;
//    secondQuestionNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [_secondSecretQuestionContentView addSubview:secondQuestionNoteLabel];
    [secondQuestionNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.centerY.equalTo(_secondSecretQuestionContentView.centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _secondSecretQuestionLabel = [UILabel new];
    _secondSecretQuestionLabel.text = @"你的父亲姓名是什么?";
    _secondSecretQuestionLabel.textAlignment = NSTextAlignmentLeft;
    _secondSecretQuestionLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [_secondSecretQuestionContentView addSubview:_secondSecretQuestionLabel];
    [_secondSecretQuestionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondQuestionNoteLabel.right).offset(10);
        make.centerY.equalTo(_secondSecretQuestionContentView.centerY);
        make.right.equalTo(_secondSecretQuestionContentView.right).offset(-30);
        make.height.equalTo(@30);
    }];
    
    UIImageView *downArrowImageView1 = [UIImageView new];
    downArrowImageView1.contentMode = UIViewContentModeCenter;
    downArrowImageView1.image = downImage;
    [_secondSecretQuestionContentView addSubview:downArrowImageView1];
    [downArrowImageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_secondSecretQuestionContentView.centerY);
        make.right.equalTo(_secondSecretQuestionContentView.right).offset(-10);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    UIView *horizonalSeparetedView4 = [UIView new];
    horizonalSeparetedView4.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView4];
    [horizonalSeparetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_secondSecretQuestionContentView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@1);
    }];
    
    UILabel *secondQuestionAnswerNoteLabel = [UILabel new];
    secondQuestionAnswerNoteLabel.text = @"密保答案";
    secondQuestionAnswerNoteLabel.textAlignment = NSTextAlignmentLeft;
//    secondQuestionAnswerNoteLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [contentView addSubview:secondQuestionAnswerNoteLabel];
    [secondQuestionAnswerNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(horizonalSeparetedView4.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _secondSecretQuestionTextField = [UITextField new];
    _secondSecretQuestionTextField.userInteractionEnabled = YES;
    _secondSecretQuestionTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _secondSecretQuestionTextField.placeholder = @"密保答案";
    [_secondSecretQuestionTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _secondSecretQuestionTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_secondSecretQuestionTextField];
    [_secondSecretQuestionTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondQuestionAnswerNoteLabel.right).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(horizonalSeparetedView4.bottom).offset(10);
        make.height.equalTo(@30);
    }];
    
    UIView *horizonalSeparetedView5 = [UIView new];
    horizonalSeparetedView5.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView5];
    [horizonalSeparetedView5 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(secondQuestionAnswerNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _saveExchangePasswordButton = [UIButton new];
    _saveExchangePasswordButton.userInteractionEnabled = YES;
    _saveExchangePasswordButton.layer.cornerRadius = 4.0;
    _saveExchangePasswordButton.layer.masksToBounds = YES;
    _saveExchangePasswordButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [_saveExchangePasswordButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveExchangePasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentView addSubview:_saveExchangePasswordButton];
    [_saveExchangePasswordButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView5.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_saveExchangePasswordButton.bottom).offset(10);
    }];
    
    return self;
}

@end
