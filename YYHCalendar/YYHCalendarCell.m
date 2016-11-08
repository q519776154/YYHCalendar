//
//  YYHCalendarCell.m
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "YYHCalendarCell.h"

@implementation YYHCalendarCell

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

@end
