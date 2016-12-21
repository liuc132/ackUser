//
//  UserFeedBackTableViewCell.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "UserFeedBackTableViewCell.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

@implementation UserFeedBackTableViewCell

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *userAvatarImageView = [UIImageView new];
    userAvatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.size.height/2;
    userAvatarImageView.layer.masksToBounds = YES;
    userAvatarImageView.image = [UIImage imageNamed:@"setting_feedBack_user"];
    [self addSubview:userAvatarImageView];
    [userAvatarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(38);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    UILabel *userNameLabel = [UILabel new];
    userNameLabel.text = @"小灰灰";
    userNameLabel.font = [UIFont systemFontOfSize:13];
    userNameLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:userNameLabel];
    [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userAvatarImageView.bottom);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    
    UIImageView *userleftArrowImageView = [UIImageView new];
    userleftArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    userleftArrowImageView.layer.masksToBounds = YES;
    UIImage *arrowImage = [UIImage imageNamed:@"setting_feedBack_leftArrow"];
    userleftArrowImageView.image = [arrowImage imageWithColor:[UIColor colorFromHexString:@"#f2f2f2" alpha:1.0]];
    [self addSubview:userleftArrowImageView];
    [userleftArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(53);
        make.left.equalTo(userAvatarImageView.right).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = 4.0;
    contentView.layer.masksToBounds = YES;
    [self addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userleftArrowImageView.right).offset(-5);
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.top).offset(10);
        make.bottom.equalTo(self.bottom).offset(-5);
    }];
    
    UILabel *userFeedBackSessionLabel = [UILabel new];
    userFeedBackSessionLabel.layer.cornerRadius = 4.0;
    userFeedBackSessionLabel.layer.masksToBounds = YES;
    userFeedBackSessionLabel.numberOfLines = 0;
    userFeedBackSessionLabel.textAlignment = NSTextAlignmentJustified;
    userFeedBackSessionLabel.backgroundColor = [UIColor colorFromHexString:@"#f2f2f2" alpha:1.0];
    userFeedBackSessionLabel.text = @"12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa12313131asdfasdfsa";
    userFeedBackSessionLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    [contentView addSubview:userFeedBackSessionLabel];
    [userFeedBackSessionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(contentView.top);
        make.bottom.equalTo(contentView.bottom).offset(-25);
    }];
    
    UILabel *userFeedBackTimeLabel = [UILabel new];
    userFeedBackTimeLabel.text = @"2016-11-21";
    userFeedBackTimeLabel.textColor = [UIColor colorFromHexString:@"#7d8381" alpha:1.0];
    userFeedBackTimeLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:userFeedBackTimeLabel];
    [userFeedBackTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView.bottom);
        make.right.equalTo(contentView.right).offset(-5);
        make.height.equalTo(@20);
        make.width.equalTo(@120);
    }];
    
    
    
    return self;
}

@end
