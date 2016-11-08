//
//  CalendarViewController.m
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CalendarViewController.h"
#import "YYHCalendar.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController
- (IBAction)showAction:(id)sender
{
    YYHCalendar *calendar = [YYHCalendar showOnView:self.view];
    calendar.today = [NSDate date];
    calendar.date = calendar.today;
    calendar.frame = CGRectMake(0, 100, self.view.frame.size.width, 352);
    calendar.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}




@end
