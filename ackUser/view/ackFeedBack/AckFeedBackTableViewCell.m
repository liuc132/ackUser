//
//  AckFeedBackTableViewCell.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AckFeedBackTableViewCell.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@interface AckFeedBackTableViewCell ()


@end

@implementation AckFeedBackTableViewCell

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *ackAvatarImageView = [UIImageView new];
    ackAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    ackAvatarImageView.layer.cornerRadius = ackAvatarImageView.frame.size.height/2;
    ackAvatarImageView.layer.masksToBounds = YES;
    ackAvatarImageView.image = [UIImage imageNamed:@"setting_feedBack_ack"];
    [self addSubview:ackAvatarImageView];
    [ackAvatarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(38);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UILabel *userNameLabel = [UILabel new];
    userNameLabel.text = @"爱车贴平台";
    userNameLabel.font = [UIFont systemFontOfSize:11];
    userNameLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:userNameLabel];
    [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ackAvatarImageView.bottom);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    
    UIImageView *ackRightArrowImageView = [UIImageView new];
    ackRightArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    ackRightArrowImageView.layer.masksToBounds = YES;
    UIImage *arrowImage = [UIImage imageNamed:@"setting_feedBack_rightArrow"];
    ackRightArrowImageView.image = [arrowImage imageWithColor:[UIColor colorFromHexString:@"#f2f2f2" alpha:1.0]];
    [self addSubview:ackRightArrowImageView];
    [ackRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(53);
        make.right.equalTo(ackAvatarImageView.left);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = 4.0;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ackRightArrowImageView.left).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.bottom.equalTo(self.bottom).offset(-5);
    }];
    
    UILabel *ackFeedBackSessionLabel = [UILabel new];
    ackFeedBackSessionLabel.layer.cornerRadius = 4.0;
    ackFeedBackSessionLabel.layer.masksToBounds = YES;
    ackFeedBackSessionLabel.numberOfLines = 0;
    ackFeedBackSessionLabel.textAlignment = NSTextAlignmentJustified;
    ackFeedBackSessionLabel.backgroundColor = [UIColor colorFromHexString:@"#f2f2f2" alpha:1.0];
    ackFeedBackSessionLabel.text = @"12313131asdfasdfsa";
    ackFeedBackSessionLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    [contentView addSubview:ackFeedBackSessionLabel];
    [ackFeedBackSessionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(contentView.top);
        make.bottom.equalTo(contentView.bottom).offset(-25);
    }];
    
    UILabel *ackFeedBackTimeLabel = [UILabel new];
    ackFeedBackTimeLabel.text = @"2016-11-21";
    ackFeedBackTimeLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    ackFeedBackTimeLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:ackFeedBackTimeLabel];
    [ackFeedBackTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView.bottom);
        make.left.equalTo(contentView.left).offset(5);
        make.height.equalTo(@20);
        make.width.equalTo(@120);
    }];
    
    
    
    return self;
}





@end
