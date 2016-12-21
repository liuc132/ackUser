//
//  NormalPickerView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "NormalPickerView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation NormalPickerView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setBackgroundColor:[UIColor colorFromHexString:@"#E8E8E8" alpha:1.0]];
    
    _normalPickerCancleButton = [UIButton new];
    _normalPickerCancleButton.layer.cornerRadius = 5.0;
    _normalPickerCancleButton.layer.masksToBounds = YES;
    [_normalPickerCancleButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_normalPickerCancleButton setTitle:@"取消" forState:UIControlStateNormal];
    _normalPickerCancleButton.backgroundColor = [UIColor colorFromHexString:@"#46CF98" alpha:1.0];
    [self addSubview:_normalPickerCancleButton];
    [_normalPickerCancleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(5);
        make.top.equalTo(self.top).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    _normalPickerConfirmButton = [UIButton new];
    _normalPickerConfirmButton.layer.cornerRadius = 5.0;
    _normalPickerConfirmButton.layer.masksToBounds = YES;
    [_normalPickerConfirmButton.titleLabel setTextColor:[UIColor whiteColor]];
    [_normalPickerConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _normalPickerConfirmButton.backgroundColor = [UIColor colorFromHexString:@"#46CF98" alpha:1.0];
    [self addSubview:_normalPickerConfirmButton];
    [_normalPickerConfirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(self.right).offset(-5);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor whiteColor];
    [self addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_normalPickerCancleButton.bottom).offset(10);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(@4);
    }];
    
    _normalPickerView = [UIPickerView new];
    [self addSubview:_normalPickerView];
    [_normalPickerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView.bottom).offset(5);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    
    
    
    return self;
}






@end
