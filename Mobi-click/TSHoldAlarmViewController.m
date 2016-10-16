//
//  TSHoldAlarmViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSHoldAlarmViewController.h"
#import "TSPostingMessagesManager.h"
#import "TSPrefixHeader.pch"

@interface TSHoldAlarmViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *checkerOutletCollection;
@property (strong, nonatomic) NSMutableArray *dataSourceHours;
@property (strong, nonatomic) NSMutableArray *dataSourceMinutes;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISwitch *holdAlarmSwitchOne;
@property (weak, nonatomic) IBOutlet UISwitch *holdAlarmSwitchTwo;

@property (weak, nonatomic) IBOutlet UIPickerView *fromMinPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *fromHourPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *toMinPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *toHourPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *fromMinPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *fromHourPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *toMinPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *toHourPickerViewTwo;

@property (weak, nonatomic) IBOutlet UIButton *checkerButtonOneRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonTwoRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonThreeRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonForeRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFiveRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSixRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSevenRowOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonOneRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonTwoRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonThreeRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonForeRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFiveRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSixRowTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSevenRowTwo;

@property (assign, nonatomic) BOOL switchChekerOneRowOne;
@property (assign, nonatomic) BOOL switchChekerTwoRowOne;
@property (assign, nonatomic) BOOL switchChekerTreeRowOne;
@property (assign, nonatomic) BOOL switchChekerForeRowOne;
@property (assign, nonatomic) BOOL switchChekerFiveRowOne;
@property (assign, nonatomic) BOOL switchChekerSixRowOne;
@property (assign, nonatomic) BOOL switchChekerSevenRowOne;
@property (assign, nonatomic) BOOL switchChekerOneRowTwo;
@property (assign, nonatomic) BOOL switchChekerTwoRowTwo;
@property (assign, nonatomic) BOOL switchChekerTreeRowTwo;
@property (assign, nonatomic) BOOL switchChekerForeRowTwo;
@property (assign, nonatomic) BOOL switchChekerFiveRowTwo;
@property (assign, nonatomic) BOOL switchChekerSixRowTwo;
@property (assign, nonatomic) BOOL switchChekerSevenRowTwo;

@end

@implementation TSHoldAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureContrioller];
    
}


#pragma mark - Configure contrioller


- (void)configureContrioller
{
    for (UIButton *button in self.checkerOutletCollection)
    {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    self.fromMinPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromHourPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.toMinPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.toHourPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromMinPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromHourPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.toMinPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.toHourPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    
    self.dataSourceHours = [NSMutableArray array];
    self.dataSourceMinutes = [NSMutableArray array];
    
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
    
    self.switchChekerOneRowOne = NO;
    self.switchChekerTwoRowOne = NO;
    self.switchChekerTreeRowOne = NO;
    self.switchChekerForeRowOne = NO;
    self.switchChekerFiveRowOne = NO;
    self.switchChekerSixRowOne = NO;
    self.switchChekerSevenRowOne = NO;
    self.switchChekerOneRowTwo = NO;
    self.switchChekerTwoRowTwo = NO;
    self.switchChekerTreeRowTwo = NO;
    self.switchChekerForeRowTwo = NO;
    self.switchChekerFiveRowTwo = NO;
    self.switchChekerSixRowTwo = NO;
    self.switchChekerSevenRowTwo = NO;

}


- (NSArray *)configureComand
{
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    
    NSString *holdAlarmOne = nil;
    NSString *holdAlarmTwo = nil;
    
    NSMutableArray *comands = [NSMutableArray array];
    
    NSString *valueFromMinPickerViewOne = [self pickerView:self.fromMinPickerViewOne
                                      titleForRow:[self.fromMinPickerViewOne selectedRowInComponent:0] forComponent:0];
    
    NSString *valueFromHourPickerViewOne = [self pickerView:self.fromHourPickerViewOne
                                   titleForRow:[self.fromHourPickerViewOne selectedRowInComponent:0] forComponent:0];
    
    NSString *valueToMinPickerViewOne = [self pickerView:self.toMinPickerViewOne
                                   titleForRow:[self.toMinPickerViewOne selectedRowInComponent:0] forComponent:0];
    
    NSString *valueToHourPickerViewOne = [self pickerView:self.toHourPickerViewOne
                                         titleForRow:[self.toHourPickerViewOne selectedRowInComponent:0] forComponent:0];
    
    NSString *valueFromMinPickerViewTwo = [self pickerView:self.fromMinPickerViewTwo
                                           titleForRow:[self.fromMinPickerViewTwo selectedRowInComponent:0] forComponent:0];
    
    NSString *valueFromHourPickerViewTwo = [self pickerView:self.fromHourPickerViewTwo
                                        titleForRow:[self.fromHourPickerViewTwo selectedRowInComponent:0] forComponent:0];
    
    NSString *valueToMinPickerViewTwo = [self pickerView:self.toMinPickerViewTwo
                                        titleForRow:[self.toMinPickerViewTwo selectedRowInComponent:0] forComponent:0];
    
    NSString *valueToHourPickerViewTwo = [self pickerView:self.toHourPickerViewTwo
                                              titleForRow:[self.toHourPickerViewTwo selectedRowInComponent:0] forComponent:0];
    
    NSArray *daysWeek = @[@"mo", @"tu", @"we", @"th", @"fr", @"sa", @"su"];
    
    
    NSNumber *switchChekerOneRowOne = [NSNumber numberWithBool:self.switchChekerOneRowOne];
    NSNumber *switchChekerTwoRowOne = [NSNumber numberWithBool:self.switchChekerTwoRowOne];
    NSNumber *switchChekerTreeRowOne = [NSNumber numberWithBool:self.switchChekerTreeRowOne];
    NSNumber *switchChekerForeRowOne = [NSNumber numberWithBool:self.switchChekerForeRowOne];
    NSNumber *switchChekerFiveRowOne = [NSNumber numberWithBool:self.switchChekerFiveRowOne];
    NSNumber *switchChekerSixRowOne = [NSNumber numberWithBool:self.switchChekerSixRowOne];
    NSNumber *switchChekerSevenRowOne = [NSNumber numberWithBool:self.switchChekerSevenRowOne];
    
    NSNumber *switchChekerOneRowTwo = [NSNumber numberWithBool:self.switchChekerOneRowTwo];
    NSNumber *switchChekerTwoRowTwo = [NSNumber numberWithBool:self.switchChekerTwoRowTwo];
    NSNumber *switchChekerTreeRowTwo = [NSNumber numberWithBool:self.switchChekerTreeRowTwo];
    NSNumber *switchChekerForeRowTwo = [NSNumber numberWithBool:self.switchChekerForeRowTwo];
    NSNumber *switchChekerFiveRowTwo = [NSNumber numberWithBool:self.switchChekerFiveRowTwo];
    NSNumber *switchChekerSixRowTwo = [NSNumber numberWithBool:self.switchChekerSixRowTwo];
    NSNumber *switchChekerSevenRowTwo = [NSNumber numberWithBool:self.switchChekerSevenRowTwo];
    
    
    NSArray *chackersPositionsTopRow = @[switchChekerOneRowOne, switchChekerTwoRowOne, switchChekerTreeRowOne, switchChekerForeRowOne, switchChekerFiveRowOne, switchChekerSixRowOne, switchChekerSevenRowOne];
    
    NSArray *chackersPositionsBottomRow = @[switchChekerOneRowTwo, switchChekerTwoRowTwo, switchChekerTreeRowTwo, switchChekerForeRowTwo, switchChekerFiveRowTwo, switchChekerSixRowTwo, switchChekerSevenRowTwo];
    
    NSMutableArray *arraySelectedDaysTop = [NSMutableArray array];
    NSMutableArray *arraySelectedDaysBottom = [NSMutableArray array];
    
    for (int i = 0; i < [chackersPositionsTopRow count]; i++) {
        NSNumber *dayPosition = [chackersPositionsTopRow objectAtIndex:i];
        BOOL day = [dayPosition boolValue];
        if (day == 1) {
            [arraySelectedDaysTop addObject:[daysWeek objectAtIndex:i]];
        }
    }
    
    for (int i = 0; i < [chackersPositionsBottomRow count]; i++) {
        NSNumber *dayPosition = [chackersPositionsBottomRow objectAtIndex:i];
        BOOL day = [dayPosition boolValue];
        if (day == 1) {
            [arraySelectedDaysBottom addObject:[daysWeek objectAtIndex:i]];
        }
    }
    
    // top comand
    
    if (self.holdAlarmSwitchOne.isOn) {
        
        NSString *intermediateString = [NSString stringWithFormat:@"​SET HOLDALARM %@ %@ %@ %@ X #%@",valueFromMinPickerViewOne, valueFromHourPickerViewOne, valueToMinPickerViewOne, valueToHourPickerViewOne, pin];
        
        
        if ([arraySelectedDaysTop count] > 0) {
            
            NSMutableString *concatenateStringTop = [NSMutableString string];
            
            for (int i = 0; i < [arraySelectedDaysTop count]; i++) {
                NSString *slectDay = [arraySelectedDaysTop objectAtIndex:i];
                [concatenateStringTop appendString:[NSString stringWithFormat:@"%@ ", slectDay]];
            }
            
            NSArray *components = [intermediateString componentsSeparatedByString:@" "];
            holdAlarmOne = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@%@", [components objectAtIndex:0], [components objectAtIndex:1], [components objectAtIndex:2], [components objectAtIndex:3], [components objectAtIndex:4], [components objectAtIndex:5], concatenateStringTop, [components objectAtIndex:7]];
        }
        [comands addObject:holdAlarmOne];
        NSLog(@"%@", holdAlarmOne);
        
    } else {
        holdAlarmOne = [NSString stringWithFormat:@"RESET HOLDALARM #%@", pin];
        [comands addObject:holdAlarmOne];
    }
    
    //bottom comand concatenate
    
    if (self.holdAlarmSwitchTwo.isOn)
    {
        NSString *intermediateString = [NSString stringWithFormat:@"​SET HOLDALARM %@ %@ %@ %@ X #%@",valueFromMinPickerViewTwo, valueFromHourPickerViewTwo, valueToMinPickerViewTwo, valueToHourPickerViewTwo, pin];
        
        
        if ([arraySelectedDaysBottom count] > 0) {
            
            NSMutableString *concatenateStringBottom = [NSMutableString string];
            
            for (int i = 0; i < [arraySelectedDaysBottom count]; i++) {
                NSString *slectDay = [arraySelectedDaysBottom objectAtIndex:i];
                [concatenateStringBottom appendString:[NSString stringWithFormat:@"%@ ", slectDay]];
            }
            
            NSArray *components = [intermediateString componentsSeparatedByString:@" "];
            holdAlarmTwo = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@%@", [components objectAtIndex:0], [components objectAtIndex:1], [components objectAtIndex:2], [components objectAtIndex:3], [components objectAtIndex:4], [components objectAtIndex:5], concatenateStringBottom, [components objectAtIndex:7]];
        }
        [comands addObject:holdAlarmTwo];
        NSLog(@"%@", holdAlarmTwo);
        
        [comands addObject:holdAlarmTwo];
    } else {
        holdAlarmTwo = [NSString stringWithFormat:@"RESET LOCK #%@", pin];
        [comands addObject:holdAlarmTwo];
    }
    
    return comands;
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
            return self.dataSourceHours.count;
            break;
        case 4:
            return self.dataSourceMinutes.count;
            break;
        case 5:
            return self.dataSourceHours.count;
            break;
        case 6:
            return self.dataSourceMinutes.count;
            break;
        case 7:
            return self.dataSourceHours.count;
            break;
        case 8:
            return self.dataSourceMinutes.count;
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
            return [self.dataSourceHours objectAtIndex:row];
            break;
        case 4:
            return [self.dataSourceMinutes objectAtIndex:row];
            break;
        case 5:
            return [self.dataSourceHours objectAtIndex:row];
            break;
        case 6:
            return [self.dataSourceMinutes objectAtIndex:row];
            break;
        case 7:
            return [self.dataSourceHours objectAtIndex:row];
            break;
        case 8:
            return [self.dataSourceMinutes objectAtIndex:row];
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



#pragma mark - Actions


- (IBAction)actionCheckerOneRowOne:(id)sender
{
    if (self.switchChekerOneRowOne == NO) {
        [self.checkerButtonOneRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerOneRowOne = YES;
    } else if (self.switchChekerOneRowOne == YES) {
        [self.checkerButtonOneRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerOneRowOne = NO;
    }
}


- (IBAction)actionCheckerTwoRowOne:(id)sender
{
    if (self.switchChekerTwoRowOne == NO) {
        [self.checkerButtonTwoRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerTwoRowOne = YES;
    } else if (self.switchChekerTwoRowOne == YES) {
        [self.checkerButtonTwoRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerTwoRowOne = NO;
    }
}


- (IBAction)actionCheckerThreeRowOne:(id)sender
{
    if (self.switchChekerTreeRowOne == NO) {
        [self.checkerButtonThreeRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerTreeRowOne = YES;
    } else if (self.switchChekerTreeRowOne == YES) {
        [self.checkerButtonThreeRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerTreeRowOne = NO;
    }
}


- (IBAction)actionCheckerForeRowOne:(id)sender
{
    if (self.switchChekerForeRowOne == NO) {
        [self.checkerButtonForeRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerForeRowOne = YES;
    } else if (self.switchChekerForeRowOne == YES) {
        [self.checkerButtonForeRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerForeRowOne = NO;
    }
}


- (IBAction)actionCheckerFiveRowOne:(id)sender
{
    if (self.switchChekerFiveRowOne == NO) {
        [self.checkerButtonFiveRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerFiveRowOne = YES;
    } else if (self.switchChekerFiveRowOne == YES) {
        [self.checkerButtonFiveRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerFiveRowOne = NO;
    }
}


- (IBAction)actionCheckerSixRowOne:(id)sender
{
    if (self.switchChekerSixRowOne == NO) {
        [self.checkerButtonSixRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerSixRowOne = YES;
    } else if (self.switchChekerSixRowOne == YES) {
        [self.checkerButtonSixRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerSixRowOne = NO;
    }
}


- (IBAction)actionCheckerSevenRowOne:(id)sender
{
    if (self.switchChekerSevenRowOne == NO) {
        [self.checkerButtonSevenRowOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerSevenRowOne = YES;
    } else if (self.switchChekerSevenRowOne == YES) {
        [self.checkerButtonSevenRowOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerSevenRowOne = NO;
    }
}


- (IBAction)actionCheckerOneRowTwo:(id)sender
{
    if (self.switchChekerOneRowTwo == NO) {
        [self.checkerButtonOneRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerOneRowTwo = YES;
    } else if (self.switchChekerOneRowTwo == YES) {
        [self.checkerButtonOneRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerOneRowTwo = NO;
    }
}


- (IBAction)actionCheckerTwoRowTwo:(id)sender
{
    if (self.switchChekerTwoRowTwo == NO) {
        [self.checkerButtonTwoRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerTwoRowTwo = YES;
    } else if (self.switchChekerTwoRowTwo == YES) {
        [self.checkerButtonTwoRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerTwoRowTwo = NO;
    }
}


- (IBAction)actionCheckerThreeRowTwo:(id)sender
{
    if (self.switchChekerTreeRowTwo == NO) {
        [self.checkerButtonThreeRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerTreeRowTwo = YES;
    } else if (self.switchChekerTreeRowTwo == YES) {
        [self.checkerButtonThreeRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerTreeRowTwo = NO;
    }
}


- (IBAction)actionCheckerForeRowTwo:(id)sender
{
    if (self.switchChekerForeRowTwo == NO) {
        [self.checkerButtonForeRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerForeRowTwo = YES;
    } else if (self.switchChekerForeRowTwo == YES) {
        [self.checkerButtonForeRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerForeRowTwo = NO;
    }
}


- (IBAction)actionCheckerFiveRowTwo:(id)sender
{
    if (self.switchChekerFiveRowTwo == NO) {
        [self.checkerButtonFiveRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerFiveRowTwo = YES;
    } else if (self.switchChekerFiveRowTwo == YES) {
        [self.checkerButtonFiveRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerFiveRowTwo = NO;
    }
}


- (IBAction)actionCheckerSixRowTwo:(id)sender
{
    if (self.switchChekerSixRowTwo == NO) {
        [self.checkerButtonSixRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerSixRowTwo = YES;
    } else if (self.switchChekerSixRowTwo == YES) {
        [self.checkerButtonSixRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerSixRowTwo = NO;
    }
}


- (IBAction)actionCheckerSevenRowTwo:(id)sender
{
    if (self.switchChekerSevenRowTwo == NO) {
        [self.checkerButtonSevenRowTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerSevenRowTwo = YES;
    } else if (self.switchChekerSevenRowTwo == YES) {
        [self.checkerButtonSevenRowTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerSevenRowTwo = NO;
    }
}


- (IBAction)actionSendButton:(id)sender
{
//    self.contactPicker = [[CNContactPickerViewController alloc] init];
//    self.contactPicker.delegate = self;
//    
//    [self presentViewController:self.contactPicker animated:YES completion:nil];
    
    [self configureComand];
}



#pragma mark - CNContactPickerDelegate


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    NSArray *phoneNumbers = [contact phoneNumbers];
    CNLabeledValue *number = [phoneNumbers objectAtIndex:0];
    NSString *numberPhone = [[number value] stringValue];
    self.recipient = @[numberPhone];
    
    [self sendMessage:self.recipient];
}


#pragma mark - MFMessageComposeViewController


- (void)sendMessage:(NSArray *)recipients
{

    MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:@""];
    messageComposeViewController.messageComposeDelegate = self;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:messageComposeViewController animated:YES completion:nil];
    
}


#pragma mark - MFMessageComposeViewControllerDelegate


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    }
    else if (result == MessageComposeResultSent) {
        NSLog(@"Message sent");
    }
    else {
        NSLog(@"Message failed");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
