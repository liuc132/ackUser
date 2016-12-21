//
//  CustomDatePickView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CustomDatePickView.h"
#import "UIColor+HexColor.h"
#import "ackUserPCH.pch"
#import "Masonry.h"

@interface CustomDatePickView ()

@end

@implementation CustomDatePickView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setBackgroundColor:[UIColor colorFromHexString:@"#E8E8E8" alpha:1.0]];
    
    
    _dateCancleButton = [UIButton new];
    _dateCancleButton.layer.cornerRadius = 5.0;
    _dateCancleButton.layer.masksToBounds = YES;
    [_dateCancleButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_dateCancleButton setTitle:@"取消" forState:UIControlStateNormal];
    _dateCancleButton.backgroundColor = [UIColor colorFromHexString:@"#46CF98" alpha:1.0];
    [self addSubview:_dateCancleButton];
    [_dateCancleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(5);
        make.top.equalTo(self.top).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    _dateConfirmButton = [UIButton new];
    _dateConfirmButton.layer.cornerRadius = 5.0;
    _dateConfirmButton.layer.masksToBounds = YES;
    [_dateConfirmButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_dateConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _dateConfirmButton.backgroundColor = [UIColor colorFromHexString:@"#46CF98" alpha:1.0];
    [self addSubview:_dateConfirmButton];
    [_dateConfirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(self.right).offset(-5);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor whiteColor];
    [self addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateCancleButton.bottom).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@4);
    }];
    
    _datePickerView = [UIDatePicker new];
    _datePickerView.datePickerMode = UIDatePickerModeDate;
    [self addSubview:_datePickerView];
    [_datePickerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView.bottom).offset(5);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    
    
    return self;
}




@end
