//
//  UIImage+ChangeImageColor.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/19.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ChangeImageColor)

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth;

@end
