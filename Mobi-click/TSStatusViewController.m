//
//  TSStatusViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSStatusViewController.h"
#import "TSPrefixHeader.pch"

@interface TSStatusViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *alarmWiedPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmOnePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmTwoPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *idieAlarmPickerView;

@property (weak, nonatomic) IBOutlet UISwitch *swichInterval;
@property (weak, nonatomic) IBOutlet UISwitch *swichLock;
@property (weak, nonatomic) IBOutlet UISwitch *swichRepeat;
@property (weak, nonatomic) IBOutlet UISwitch *swichGsmAlarmOne;
@property (weak, nonatomic) IBOutlet UISwitch *swichGsmAlarmTwo;
@property (weak, nonatomic) IBOutlet UISwitch *swichIdleAlarm;

@property (weak, nonatomic) IBOutlet UILabel *lockLabel;
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;

@property (strong, nonatomic) NSMutableArray *dataSourceInterval;
@property (strong, nonatomic) NSMutableArray *dataSourceRepeat;
@property (strong, nonatomic) NSMutableArray *dataSourceGsmAlarmOne;
@property (strong, nonatomic) NSMutableArray *dataSourceGsmAlarmTwo;
@property (strong, nonatomic) NSMutableArray *dataSourceIdieAlarm;

@end

@implementation TSStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureController];
}


#pragma mark - Configuration


- (void)configureController
{
    self.intervalPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.alarmWiedPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.gsmAlarmOnePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.gsmAlarmTwoPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.idieAlarmPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    
    
    self.dataSourceInterval = [NSMutableArray array];
    self.dataSourceRepeat = [NSMutableArray array];
    self.dataSourceGsmAlarmOne = [NSMutableArray array];
    self.dataSourceGsmAlarmTwo = [NSMutableArray array];
    self.dataSourceIdieAlarm = [NSMutableArray array];
    
    
    for (int i = 0; i < 24; i++) {
        NSString *intervalString = [NSString stringWithFormat:@"%d", i];
        if ([intervalString length] == 1) {
            intervalString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceInterval addObject:intervalString];
    }
    
    for (int i = 0; i < 61; i++) {
        NSString *repeatString = [NSString stringWithFormat:@"%d", i];
        if ([repeatString length] == 1) {
            repeatString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceRepeat addObject:repeatString];
    }
    
    for (int i = 1; i < 10; i++) {
        NSString *gsmOneString = [NSString stringWithFormat:@"%d", i];
        gsmOneString = [NSString stringWithFormat:@"%d0", i];
        [self.dataSourceGsmAlarmOne addObject:gsmOneString];
    }
    
    for (int i = 1; i < 61; i++) {
        NSString *gsmTwoString = [NSString stringWithFormat:@"%d", i];
        if ([gsmTwoString length] == 1) {
            gsmTwoString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceGsmAlarmTwo addObject:gsmTwoString];
    }
    
    for (int i = 0; i < 241; i++) {
        NSString *idieString = [NSString stringWithFormat:@"%d", i];
        if ([idieString length] == 1) {
            idieString = [NSString stringWithFormat:@"0%d", i];
        }
        [self.dataSourceIdieAlarm addObject:idieString];
    }
    
}


#pragma mark - Actions


- (IBAction)ationTestButton:(id)sender
{
    
}


- (IBAction)ationSendButton:(id)sender
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
            return self.dataSourceInterval.count;
            break;
        case 2:
            return self.dataSourceRepeat.count;
            break;
        case 3:
            return self.dataSourceGsmAlarmOne.count;
            break;
        case 4:
            return self.dataSourceGsmAlarmTwo.count;
            break;
        case 5:
            return self.dataSourceIdieAlarm.count;
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
            return [self.dataSourceInterval objectAtIndex:row];
            break;
        case 2:
            return [self.dataSourceRepeat objectAtIndex:row];
            break;
        case 3:
            return [self.dataSourceGsmAlarmOne objectAtIndex:row];
            break;
        case 4:
            return [self.dataSourceGsmAlarmTwo objectAtIndex:row];
            break;
        case 5:
            return [self.dataSourceIdieAlarm objectAtIndex:row];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
