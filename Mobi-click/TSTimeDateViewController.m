//
//  TSTimeDateViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSTimeDateViewController.h"
#import "TSPrefixHeader.pch"

@interface TSTimeDateViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *hoursPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *minutesPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *daysPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *monthsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *yearsPickerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) NSMutableArray *dataSourceHours;
@property (strong, nonatomic) NSMutableArray *dataSourceMinutes;
@property (strong, nonatomic) NSMutableArray *dataSourceDays;
@property (strong, nonatomic) NSMutableArray *dataSourceMonths;
@property (strong, nonatomic) NSMutableArray *dataSourceYears;

@end

@implementation TSTimeDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureController];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLauguage];
}


- (void)configureController
{
    
    self.hoursPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.minutesPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.daysPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.monthsPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.yearsPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    
    
    self.dataSourceHours = [NSMutableArray array];
    self.dataSourceMinutes = [NSMutableArray array];
    self.dataSourceDays = [NSMutableArray array];
    self.dataSourceMonths = [NSMutableArray array];
    self.dataSourceYears = [NSMutableArray array];
    
    for (int i = 0; i < 24; i++) {
        NSString *hourString = [NSString stringWithFormat:@"%d", i];
        if ([hourString length] == 1) {
            hourString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceHours addObject:hourString];
    }
    
    for (int i = 0; i < 60; i++) {
        NSString *minString = [NSString stringWithFormat:@"%d", i];
        if ([minString length] == 1) {
            minString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceMinutes addObject:minString];
    }
    
    for (int i = 0; i < 31; i++) {
        NSString *dayString = [NSString stringWithFormat:@"%d", i + 1];
        if ([dayString length] == 1) {
            dayString = [NSString stringWithFormat:@"0%d", i + 1];
        }
        [self.dataSourceDays addObject:dayString];
    }
    
    for (int i = 0; i < 12; i++) {
        NSString *monthString = [NSString stringWithFormat:@"%d", i +1];
        if ([monthString length] == 1) {
            monthString = [NSString stringWithFormat:@"0%d", i + 1];
        }
        [self.dataSourceMonths addObject:monthString];
    }
    
    NSInteger year = 2016;
    NSInteger counter = 1;
    
    for (int i = 0; i < 11; i++) {
        
        NSString *hourString = [NSString stringWithFormat:@"%ld", year];
        year = year + counter;
        [self.dataSourceYears addObject:hourString];
    }
    
}


#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{
    
}



#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return self.dataSourceHours.count;
            break;
        case 2:
            return self.dataSourceMinutes.count;
            break;
        case 3:
            return self.dataSourceDays.count;
            break;
        case 4:
            return self.dataSourceMonths.count;
            break;
        case 5:
            return self.dataSourceYears.count;
            break;
        default:
            return 0;
            break;
    }
    
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return [self.dataSourceHours objectAtIndex:row];
            break;
        case 2:
            return [self.dataSourceMinutes objectAtIndex:row];
            break;
        case 3:
            return [self.dataSourceDays objectAtIndex:row];
            break;
        case 4:
            return [self.dataSourceMonths objectAtIndex:row];
            break;
        case 5:
            return [self.dataSourceYears objectAtIndex:row];
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark - UIPickerViewDelegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - methods set launguage


- (void)setLauguage
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    
    if ([language isEqualToString:@"English"]) {
        
        [self setEngleshLaunguage];
        
    } else if ([language isEqualToString:@"German"]) {
        
        [self setGermanLaunguage];
    }
}


- (void)setEngleshLaunguage
{
    [self.titleLabel setText:@"Setting Time and Date"];
    [self.timeLabel setText:@"Time"];
    [self.dataLabel setText:@"Date"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.titleLabel setText:@"Einstellung der Uhrzeit und des Datums"];
    [self.timeLabel setText:@"Uhrzeit"];
    [self.dataLabel setText:@"Datum"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
