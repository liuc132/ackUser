//
//  RetakePhotoView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/1.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "RetakePhotoView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation RetakePhotoView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorFromHexString:@"#7f7f7f" alpha:0.8];
    
    _oldPhotoImageView = [UIImageView new];
    _oldPhotoImageView.layer.masksToBounds = YES;
    _oldPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_oldPhotoImageView];
    [_oldPhotoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(SCREEN_HEIGHT/4);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_HEIGHT/2 - 60));
    }];
    
    _retakeButton = [UIButton new];
    _retakeButton.layer.cornerRadius = 4.0;
    _retakeButton.layer.masksToBounds = YES;
    _retakeButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [_retakeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_retakeButton setTitle:@"重拍" forState:UIControlStateNormal];
    [self addSubview:_retakeButton];
    [_retakeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldPhotoImageView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@40);
    }];
    
    
    return self;
}


/**
 dismiss the RetakePhotoView
 */
- (void)dismissRetakePhotoView
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
}

/**
 show the RetakePhotoView
 */
- (void)showRetakePhotoView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}

@end
