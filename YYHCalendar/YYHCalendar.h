//
//  YYHCalendar.h
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHCalendar : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)NSDate *date;

@property (nonatomic,strong)NSDate *today;

@property (nonatomic,copy)void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

+ (instancetype)showOnView:(UIView *)calendarView;

@end
