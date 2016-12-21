//
//  UIColor+HexColor.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

+ (UIColor *)colorFromHexString:(NSString *)hexColor alpha:(CGFloat)alpha;

@end
