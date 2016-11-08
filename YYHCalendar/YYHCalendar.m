//
//  YYHCalendar.m
//  YYHCalendar
//
//  Created by qianfeng on 16/11/7.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "YYHCalendar.h"
#import "YYHCalendarCell.h"
#import "UIColor+color.h"

@interface YYHCalendar ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *yearMonthLabel;

@property (strong, nonatomic) IBOutlet UIButton *previousButton;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic , strong) NSArray *weekDayArray;
@property (nonatomic , strong) UIView *backgroundView;

@end

@implementation YYHCalendar


- (void)drawRect:(CGRect)rect {
   
    [self addTap];
    [self addSwipe];
    [self show];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
     [_collectionView registerClass: [YYHCalendarCell class]forCellWithReuseIdentifier:@"YYHCalendarCell"];
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _collectionView.frame = CGRectMake(0, 86, self.frame.size.width, self.frame.size.height - 86);
    _backgroundView.frame = CGRectMake(0, 0, self.frame.size.width, 86);
}
- (void)customCollectionView
{
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
   
}
- (void)setDate:(NSDate *)date
{
    _date = date;
    [_yearMonthLabel setText:[NSString stringWithFormat:@"%ld - %ld",(long)[self year:date],(long)[self month:date]]];
    [_collectionView reloadData];
}

#pragma mark - date
- (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}
- (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
- (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [components setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:components];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
    
}

- (NSInteger)totaldaysInLastMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYHCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYHCalendarCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#1fcffc"]];
    } else {
        NSInteger daysInThisMonth = [self totaldaysInLastMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#1f1f1f"]];
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#fe1aaf"]];
                } else if (day > [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cdcade"]];
                }
            } else if ([_today compare:_date] == NSOrderedAscending) {
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cdcade"]];
            }
        }
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInLastMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day <= [self day:_date]) {
                    return YES;
                }
            } else if ([_today compare:_date] == NSOrderedDescending) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
    [self hide];
}
+ (instancetype)showOnView:(UIView *)view
{
    YYHCalendar *calendar = [[[NSBundle mainBundle] loadNibNamed:@"YYHCalendar" owner:self options:nil] firstObject];
    
    calendar.backgroundView.backgroundColor = [UIColor colorWithRed:103.0/255.0 green:200.0/255.0 blue:255.0/255.0];
    //calendar.backgroundView.alpha = 0.3;
    [view addSubview:calendar.backgroundView];
    [view addSubview:calendar];
    return calendar;
}
- (IBAction)previousButtonClick:(id)sender {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
    } completion:nil];
}

- (IBAction)nextButtonClick:(id)sender {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
    } completion:nil];
}
- (void)show
{
    self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL isFinished) {
        [self customCollectionView];
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.5 animations:^(void) {
        self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL isFinished) {
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
    }];

}
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonClick:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousButtonClick:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.backgroundView addGestureRecognizer:tap];
}

@end












