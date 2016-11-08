//
//  UIColor+color.h
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (color)

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

/**
 16进制的颜色转换为字符串类型

 @param color <#color description#>

 @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
