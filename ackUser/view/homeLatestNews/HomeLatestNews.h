//
//  HomeLatestNews.h
//  ackUser
//
//  Created by LiuC on 16/11/24.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLatestNews : UIView

@property (strong, nonatomic) UIView        *moreNewsView;
@property (strong, nonatomic) UIView        *latestNewsView;
@property (strong, nonatomic) UIView        *secondNewsView;
@property (strong, nonatomic) UIView        *thirdNewsView;
@property (strong, nonatomic) UIImageView   *latestNewsImageView;
@property (strong, nonatomic) UILabel       *latestNewsNameLabel;
@property (strong, nonatomic) UILabel       *latestNewsReadersLabel;
@property (strong, nonatomic) UILabel       *latestNewsThumbUpsLabel;
@property (strong, nonatomic) UILabel       *secondNewsNameLabel;
@property (strong, nonatomic) UILabel       *secondNewsReadersLabel;
@property (strong, nonatomic) UILabel       *secondNewsThumbUpsLabel;
@property (strong, nonatomic) UILabel       *thirdNewsNameLabel;
@property (strong, nonatomic) UILabel       *thirdNewsReadersLabel;
@property (strong, nonatomic) UILabel       *thirdNewsThumbUpsLabel;
@property (strong, nonatomic) UIImageView   *secondNewImageView;
@property (strong, nonatomic) UILabel       *secondNewTimeLabel;
@property (strong, nonatomic) UIImageView   *thirdNewImageView;
@property (strong, nonatomic) UILabel       *thirdNewTimeLabel;


@end
