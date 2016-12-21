//
//  HomeLatestNews.m
//  ackUser
//
//  Created by LiuC on 16/11/24.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeLatestNews.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"


@implementation HomeLatestNews

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *latestIconImageView = [UIImageView new];
    latestIconImageView.contentMode = UIViewContentModeCenter;
    latestIconImageView.image = [UIImage imageNamed:@"icon_home_latestNews"];
    [self addSubview:latestIconImageView];
    [latestIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *latestTaskNoteLabel = [UILabel new];
    latestTaskNoteLabel.text = @"最新资讯";
    latestTaskNoteLabel.font = [UIFont systemFontOfSize:13];
    latestTaskNoteLabel.textAlignment = NSTextAlignmentLeft;
    latestTaskNoteLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [self addSubview:latestTaskNoteLabel];
    [latestTaskNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(latestIconImageView.right).offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _moreNewsView = [UIView new];
    [self addSubview:_moreNewsView];
    [_moreNewsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@65);
        make.height.equalTo(@20);
    }];
    
    UIImageView *enterMoreRightArrowImageView = [UIImageView new];
    enterMoreRightArrowImageView.contentMode = UIViewContentModeCenter;
    enterMoreRightArrowImageView.image = [UIImage imageNamed:@"icon_home_more"];
    [_moreNewsView addSubview:enterMoreRightArrowImageView];
    [enterMoreRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_moreNewsView.right);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *moreNoteLabel = [UILabel new];
    moreNoteLabel.text = @"更多";
    moreNoteLabel.font = [UIFont systemFontOfSize:10];
    moreNoteLabel.textAlignment = NSTextAlignmentRight;
    moreNoteLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_moreNewsView addSubview:moreNoteLabel];
    [moreNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(enterMoreRightArrowImageView.left);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    _latestNewsView = [UIView new];
    [self addSubview:_latestNewsView];
    [_latestNewsView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(35, 0, 90, 0));
    }];
    
    _latestNewsImageView = [UIImageView new];
    _latestNewsImageView.contentMode = UIViewContentModeScaleAspectFit;
    _latestNewsImageView.image = [UIImage imageNamed:@"icon_home_latestAD1"];
    [_latestNewsView addSubview:_latestNewsImageView];
    [_latestNewsImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 10, 20, 10));
    }];
    
    _latestNewsNameLabel = [UILabel new];
    _latestNewsNameLabel.font = [UIFont systemFontOfSize:9];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9],};
    NSString *latestNewsNameString = @"万达城示范区明星活动明星活动";
    _latestNewsNameLabel.text = latestNewsNameString;
    CGSize textSize = [latestNewsNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _latestNewsNameLabel.textAlignment = NSTextAlignmentLeft;
    _latestNewsNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_latestNewsView addSubview:_latestNewsNameLabel];
    [_latestNewsNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_latestNewsView.bottom);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(textSize.width + 35));
        make.height.equalTo(@20);
    }];
    
    _latestNewsThumbUpsLabel = [UILabel new];
    _latestNewsThumbUpsLabel.text = @"658";
    _latestNewsThumbUpsLabel.font = [UIFont systemFontOfSize:10];
    _latestNewsThumbUpsLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_latestNewsView addSubview:_latestNewsThumbUpsLabel];
    [_latestNewsThumbUpsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_latestNewsView.right).offset(-10);
        make.bottom.equalTo(_latestNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *latestNewsThumbUpIconImageView = [UIImageView new];
    latestNewsThumbUpIconImageView.contentMode = UIViewContentModeCenter;
    latestNewsThumbUpIconImageView.image = [UIImage imageNamed:@"icon_home_thumUp"];
    [_latestNewsView addSubview:latestNewsThumbUpIconImageView];
    [latestNewsThumbUpIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_latestNewsThumbUpsLabel.left);
        make.bottom.equalTo(_latestNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    _latestNewsReadersLabel = [UILabel new];
    _latestNewsReadersLabel.text = @"6583";
    _latestNewsReadersLabel.font = [UIFont systemFontOfSize:10];
    _latestNewsReadersLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_latestNewsView addSubview:_latestNewsReadersLabel];
    [_latestNewsReadersLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(latestNewsThumbUpIconImageView.left).offset(-5);
        make.bottom.equalTo(_latestNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *latestNewsReadersIconImageView = [UIImageView new];
    latestNewsReadersIconImageView.contentMode = UIViewContentModeCenter;
    latestNewsReadersIconImageView.image = [UIImage imageNamed:@"icon_home_readers"];
    [_latestNewsView addSubview:latestNewsReadersIconImageView];
    [latestNewsReadersIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_latestNewsReadersLabel.left);
        make.bottom.equalTo(_latestNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    UIView *horizontalSeparetedView0 = [UIView new];
    horizontalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:horizontalSeparetedView0];
    [horizontalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_latestNewsView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _secondNewsView = [UIView new];
    [self addSubview:_secondNewsView];
    [_secondNewsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@26);
    }];
    
    _secondNewImageView = [UIImageView new];
    _secondNewImageView.contentMode = UIViewContentModeScaleToFill;
    _secondNewImageView.layer.cornerRadius = 3.0;
    _secondNewImageView.layer.masksToBounds = YES;
    _secondNewImageView.image = [UIImage imageNamed:@"icon_home_secondNew"];
    [_secondNewsView addSubview:_secondNewImageView];
    [_secondNewImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_secondNewsView.left);
        make.centerY.equalTo(@0);
        make.height.equalTo(@26);
        make.width.equalTo(@40);
    }];
    
    _secondNewsNameLabel = [UILabel new];
    _secondNewsNameLabel.font = [UIFont systemFontOfSize:9];
    NSDictionary *secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9],};
    NSString *secondTaskNameString = @"万达城示范区明星活动";
    _secondNewsNameLabel.text = secondTaskNameString;
    CGSize secondTextSize = [secondTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:secondAttributes context:nil].size;
    _secondNewsNameLabel.textAlignment = NSTextAlignmentLeft;
    _secondNewsNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_secondNewsView addSubview:_secondNewsNameLabel];
    [_secondNewsNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondNewsView.top).offset(3);
        make.left.equalTo(_secondNewImageView.right);
        make.width.equalTo(@(secondTextSize.width + 15));
        make.height.equalTo(@10);
    }];
    
    _secondNewTimeLabel = [UILabel new];
    _secondNewTimeLabel.font = [UIFont systemFontOfSize:9];
    NSDictionary *secondTimeAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9],};
    NSString *secondTimeTaskNameString = @"06-06 13:58";
    _secondNewTimeLabel.text = secondTimeTaskNameString;
    CGSize secondTimeTextSize = [secondTimeTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:secondTimeAttributes context:nil].size;
    _secondNewTimeLabel.textAlignment = NSTextAlignmentLeft;
    _secondNewTimeLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_secondNewsView addSubview:_secondNewTimeLabel];
    [_secondNewTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondNewsNameLabel.bottom).offset(3);
        make.left.equalTo(_secondNewImageView.right);
        make.width.equalTo(@(secondTimeTextSize.width + 15));
        make.height.equalTo(@10);
    }];
    
    _secondNewsThumbUpsLabel = [UILabel new];
    _secondNewsThumbUpsLabel.text = @"8500";
    _secondNewsThumbUpsLabel.font = [UIFont systemFontOfSize:10];
    _secondNewsThumbUpsLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_secondNewsView addSubview:_secondNewsThumbUpsLabel];
    [_secondNewsThumbUpsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondNewsView.right);
        make.bottom.equalTo(_secondNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *secondNewThumUpIconImageView = [UIImageView new];
    secondNewThumUpIconImageView.contentMode = UIViewContentModeCenter;
    secondNewThumUpIconImageView.image = [UIImage imageNamed:@"icon_home_thumUp"];
    [_secondNewsView addSubview:secondNewThumUpIconImageView];
    [secondNewThumUpIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondNewsThumbUpsLabel.left);
        make.bottom.equalTo(_secondNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    _secondNewsReadersLabel = [UILabel new];
    _secondNewsReadersLabel.text = @"6583";
    _secondNewsReadersLabel.font = [UIFont systemFontOfSize:10];
    _secondNewsReadersLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_secondNewsView addSubview:_secondNewsReadersLabel];
    [_secondNewsReadersLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(secondNewThumUpIconImageView.left).offset(-5);
        make.bottom.equalTo(_secondNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *secondNewsReadersIconImageView = [UIImageView new];
    secondNewsReadersIconImageView.contentMode = UIViewContentModeCenter;
    secondNewsReadersIconImageView.image = [UIImage imageNamed:@"icon_home_readers"];
    [_latestNewsView addSubview:secondNewsReadersIconImageView];
    [secondNewsReadersIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondNewsReadersLabel.left);
        make.bottom.equalTo(_secondNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    UIView *horizontalSeparetedView1 = [UIView new];
    horizontalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:horizontalSeparetedView1];
    [horizontalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_secondNewsView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _thirdNewsView = [UIView new];
    [self addSubview:_thirdNewsView];
    [_thirdNewsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@26);
    }];
    
    _thirdNewImageView = [UIImageView new];
    _thirdNewImageView.layer.cornerRadius = 3.0;
    _thirdNewImageView.layer.masksToBounds = YES;
    _thirdNewImageView.contentMode = UIViewContentModeScaleToFill;
    _thirdNewImageView.image = [UIImage imageNamed:@"icon_home_thirdNew"];
    [_thirdNewsView addSubview:_thirdNewImageView];
    [_thirdNewImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thirdNewsView.left);
        make.centerY.equalTo(@0);
        make.height.equalTo(@26);
        make.width.equalTo(@40);
    }];
    
    _thirdNewsNameLabel = [UILabel new];
    _thirdNewsNameLabel.font = [UIFont systemFontOfSize:9];
    NSDictionary *thirdAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9],};
    NSString *thirdTaskNameString = @"万达城示范区明星活动";
    _thirdNewsNameLabel.text = secondTaskNameString;
    CGSize thirdTextSize = [thirdTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:thirdAttributes context:nil].size;
    _thirdNewsNameLabel.textAlignment = NSTextAlignmentLeft;
    _thirdNewsNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_thirdNewsView addSubview:_thirdNewsNameLabel];
    [_thirdNewsNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdNewsView.top).offset(3);
        make.left.equalTo(_thirdNewImageView.right);
        make.width.equalTo(@(thirdTextSize.width + 15));
        make.height.equalTo(@10);
    }];
    
    _thirdNewTimeLabel = [UILabel new];
    _thirdNewTimeLabel.font = [UIFont systemFontOfSize:9];
    NSDictionary *thirdTimeAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:9],};
    NSString *thirdTimeTaskNameString = @"06-06 13:58";
    _thirdNewTimeLabel.text = thirdTimeTaskNameString;
    CGSize thirdTimeTextSize = [thirdTimeTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:thirdTimeAttributes context:nil].size;
    _thirdNewTimeLabel.textAlignment = NSTextAlignmentLeft;
    _thirdNewTimeLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_thirdNewsView addSubview:_thirdNewTimeLabel];
    [_thirdNewTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdNewsNameLabel.bottom).offset(3);
        make.left.equalTo(_thirdNewImageView.right);
        make.width.equalTo(@(thirdTimeTextSize.width + 15));
        make.height.equalTo(@10);
    }];
    
    _thirdNewsThumbUpsLabel = [UILabel new];
    _thirdNewsThumbUpsLabel.text = @"8500";
    _thirdNewsThumbUpsLabel.font = [UIFont systemFontOfSize:10];
    _thirdNewsThumbUpsLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_thirdNewsView addSubview:_thirdNewsThumbUpsLabel];
    [_thirdNewsThumbUpsLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thirdNewsView.right);
        make.bottom.equalTo(_thirdNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *thirdNewThumbUpconImageView = [UIImageView new];
    thirdNewThumbUpconImageView.contentMode = UIViewContentModeCenter;
    thirdNewThumbUpconImageView.image = [UIImage imageNamed:@"icon_home_thumUp"];
    [_thirdNewsView addSubview:thirdNewThumbUpconImageView];
    [thirdNewThumbUpconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thirdNewsThumbUpsLabel.left);
        make.bottom.equalTo(_thirdNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    _thirdNewsReadersLabel = [UILabel new];
    _thirdNewsReadersLabel.text = @"6583";
    _thirdNewsReadersLabel.font = [UIFont systemFontOfSize:10];
    _thirdNewsReadersLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_thirdNewsView addSubview:_thirdNewsReadersLabel];
    [_thirdNewsReadersLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(thirdNewThumbUpconImageView.left).offset(-5);
        make.bottom.equalTo(_thirdNewsView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *thirdNewsReadersIconImageView = [UIImageView new];
    thirdNewsReadersIconImageView.contentMode = UIViewContentModeCenter;
    thirdNewsReadersIconImageView.image = [UIImage imageNamed:@"icon_home_readers"];
    [_thirdNewsView addSubview:thirdNewsReadersIconImageView];
    [thirdNewsReadersIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thirdNewsReadersLabel.left);
        make.bottom.equalTo(_thirdNewsView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    
    
    return self;
}





@end
