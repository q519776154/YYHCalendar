//
//  UIColor+color.m
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "UIColor+color.h"

@implementation UIColor (color)

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *colorString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([colorString length] < 6) {
        return [UIColor clearColor];
    }
    if ([colorString hasPrefix:@"0X"]) {
        colorString = [colorString substringFromIndex:2];
    }
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }
    if ([colorString length] != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *redString = [colorString substringWithRange:range];
    //r
    range.location = 2;
    
    //g
    range.location = 2;
    NSString *greenString = [colorString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *blueString = [colorString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:redString] scanHexInt:&r];
    [[NSScanner scannerWithString:greenString] scanHexInt:&g];
    [[NSScanner scannerWithString:blueString] scanHexInt:&b];
    
    return [UIColor colorWithRed:( r / 255.0) green:( g / 255.0) blue:( b / 255.0) alpha:1.0];


}

@end
