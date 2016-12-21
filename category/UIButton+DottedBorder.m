//
//  UIButton+DottedBorder.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/22.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "UIButton+DottedBorder.h"

@implementation UIButton (DottedBorder)


/**
 绘制虚线边框
 */
- (void)drawDottedLineWith
{
    CGFloat dashPattern[]= {3.0, 2};
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 1.0, 1.0);
    // And draw with a blue fill color
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 4.0);
    CGContextSetLineDash(context, 0.0, dashPattern, 2);
    
    CGContextAddRect(context, self.bounds);
    
    CGContextStrokePath(context);
    
    
    // Close the path
    CGContextClosePath(context);
    // Fill & stroke the path
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
