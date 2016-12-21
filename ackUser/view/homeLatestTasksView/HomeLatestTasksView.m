//
//  HomeLatestTasksView.m
//  ackUser
//
//  Created by LiuC on 16/11/24.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeLatestTasksView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation HomeLatestTasksView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIImageView *latestIconImageView = [UIImageView new];
    latestIconImageView.contentMode = UIViewContentModeCenter;
    latestIconImageView.image = [UIImage imageNamed:@"icon_home_latestTask"];
    [self addSubview:latestIconImageView];
    [latestIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *latestTaskNoteLabel = [UILabel new];
    latestTaskNoteLabel.text = @"最新任务";
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
    
    _moreTasksView = [UIView new];
    [self addSubview:_moreTasksView];
    [_moreTasksView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.width.equalTo(@65);
        make.height.equalTo(@20);
    }];
    
    UIImageView *enterMoreRightArrowImageView = [UIImageView new];
    enterMoreRightArrowImageView.contentMode = UIViewContentModeCenter;
    enterMoreRightArrowImageView.image = [UIImage imageNamed:@"icon_home_more"];
    [_moreTasksView addSubview:enterMoreRightArrowImageView];
    [enterMoreRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_moreTasksView.right);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *moreNoteLabel = [UILabel new];
    moreNoteLabel.text = @"更多";
    moreNoteLabel.font = [UIFont systemFontOfSize:10];
    moreNoteLabel.textAlignment = NSTextAlignmentRight;
    moreNoteLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_moreTasksView addSubview:moreNoteLabel];
    [moreNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(enterMoreRightArrowImageView.left);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    
    _latestTaskView = [UIView new];
    [self addSubview:_latestTaskView];
    [_latestTaskView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(35, 0, 72, 0));
    }];
    
    _latestTaskImageView = [UIImageView new];
    _latestTaskImageView.contentMode = UIViewContentModeScaleAspectFit;
    _latestTaskImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [_latestTaskView addSubview:_latestTaskImageView];
    [_latestTaskImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 10, 20, 10));
    }];
    
    _latestTaskNameLabel = [UILabel new];
    _latestTaskNameLabel.font = [UIFont systemFontOfSize:11];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],};
    NSString *latestTaskNameString = @"万达城示范区明星活动";
    _latestTaskNameLabel.text = latestTaskNameString;
    CGSize textSize = [latestTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _latestTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _latestTaskNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_latestTaskView addSubview:_latestTaskNameLabel];
    [_latestTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_latestTaskView.bottom);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(textSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    UIImageView *latestTaskNoteImageView = [UIImageView new];
    latestTaskNoteImageView.contentMode = UIViewContentModeCenter;
    latestTaskNoteImageView.image = [UIImage imageNamed:@"icon_home_newTaskNote"];
    [_latestTaskView addSubview:latestTaskNoteImageView];
    [latestTaskNoteImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_latestTaskNameLabel.right).offset(3);
        make.bottom.equalTo(_latestTaskView.bottom).offset(-10);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _latestTaskMoneyLabel = [UILabel new];
    _latestTaskMoneyLabel.text = @"8500";
    _latestTaskMoneyLabel.font = [UIFont systemFontOfSize:10];
    _latestTaskMoneyLabel.textColor = [UIColor colorFromHexString:@"#ff9900" alpha:1.0];
    [_latestTaskView addSubview:_latestTaskMoneyLabel];
    [_latestTaskMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_latestTaskView.right).offset(-10);
        make.bottom.equalTo(_latestTaskView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *latestMoneyIconImageView = [UIImageView new];
    latestMoneyIconImageView.contentMode = UIViewContentModeCenter;
    latestMoneyIconImageView.image = [UIImage imageNamed:@"icon_home_ackCoin"];
    [_latestTaskView addSubview:latestMoneyIconImageView];
    [latestMoneyIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_latestTaskMoneyLabel.left);
        make.bottom.equalTo(_latestTaskView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    
    UIView *horizontalSeparetedView0 = [UIView new];
    horizontalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:horizontalSeparetedView0];
    [horizontalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_latestTaskView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _secondTaskView = [UIView new];
    [self addSubview:_secondTaskView];
    [_secondTaskView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@20);
    }];
    
    _secondTaskNameLabel = [UILabel new];
    _secondTaskNameLabel.font = [UIFont systemFontOfSize:11];
    NSDictionary *secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],};
    NSString *secondTaskNameString = @"万达城示范区明星活动";
    _secondTaskNameLabel.text = secondTaskNameString;
    CGSize secondTextSize = [secondTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:secondAttributes context:nil].size;
    _secondTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _secondTaskNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_secondTaskView addSubview:_secondTaskNameLabel];
    [_secondTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_secondTaskView.bottom);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(secondTextSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    _secondTaskMoneyLabel = [UILabel new];
    _secondTaskMoneyLabel.text = @"8500";
    _secondTaskMoneyLabel.font = [UIFont systemFontOfSize:10];
    _secondTaskMoneyLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_secondTaskView addSubview:_secondTaskMoneyLabel];
    [_secondTaskMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondTaskView.right);
        make.bottom.equalTo(_secondTaskView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *secondMoneyIconImageView = [UIImageView new];
    secondMoneyIconImageView.contentMode = UIViewContentModeCenter;
    secondMoneyIconImageView.image = [UIImage imageNamed:@"icon_home_ackCoin"];
    [_secondTaskView addSubview:secondMoneyIconImageView];
    [secondMoneyIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_secondTaskMoneyLabel.left);
        make.bottom.equalTo(_secondTaskView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    
    UIView *horizontalSeparetedView1 = [UIView new];
    horizontalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:horizontalSeparetedView1];
    [horizontalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_secondTaskView.bottom).offset(5);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _thirdTaskView = [UIView new];
    [self addSubview:_thirdTaskView];
    [_thirdTaskView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalSeparetedView1.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(@20);
    }];
    
    _thirdTaskNameLabel = [UILabel new];
    _thirdTaskNameLabel.font = [UIFont systemFontOfSize:11];
    NSDictionary *thirdAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],};
    NSString *thirdTaskNameString = @"万达城示范区明星活动";
    _thirdTaskNameLabel.text = secondTaskNameString;
    CGSize thirdTextSize = [thirdTaskNameString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:thirdAttributes context:nil].size;
    _thirdTaskNameLabel.textAlignment = NSTextAlignmentLeft;
    _thirdTaskNameLabel.textColor = [UIColor colorFromHexString:@"#222324" alpha:1.0];
    [_thirdTaskView addSubview:_thirdTaskNameLabel];
    [_thirdTaskNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_thirdTaskView.bottom);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(thirdTextSize.width + 15));
        make.height.equalTo(@20);
    }];
    
    _thirdTaskMoneyLabel = [UILabel new];
    _thirdTaskMoneyLabel.text = @"8500";
    _thirdTaskMoneyLabel.font = [UIFont systemFontOfSize:10];
    _thirdTaskMoneyLabel.textColor = [UIColor colorFromHexString:@"#797e7e" alpha:1.0];
    [_thirdTaskView addSubview:_thirdTaskMoneyLabel];
    [_thirdTaskMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thirdTaskView.right);
        make.bottom.equalTo(_thirdTaskView.bottom);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
    
    UIImageView *thirdMoneyIconImageView = [UIImageView new];
    thirdMoneyIconImageView.contentMode = UIViewContentModeCenter;
    thirdMoneyIconImageView.image = [UIImage imageNamed:@"icon_home_ackCoin"];
    [_thirdTaskView addSubview:thirdMoneyIconImageView];
    [thirdMoneyIconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_thirdTaskMoneyLabel.left);
        make.bottom.equalTo(_thirdTaskView.bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    
    
    
    return self;
}





@end
