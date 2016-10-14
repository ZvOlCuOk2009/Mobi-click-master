//
//  TSStatusViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSStatusViewController.h"
#import "TSPostingMessagesManager.h"
#import "TSPrefixHeader.pch"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface TSStatusViewController () <MFMessageComposeViewControllerDelegate, CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *intervalPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *alarmWiedPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmOnePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmTwoPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *idieAlarmPickerView;

@property (weak, nonatomic) IBOutlet UISwitch *switchInterval;
@property (weak, nonatomic) IBOutlet UISwitch *switchLock;
@property (weak, nonatomic) IBOutlet UISwitch *switchRepeat;
@property (weak, nonatomic) IBOutlet UISwitch *switchGsmAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *switchGpsAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *switchidlealarm;

@property (weak, nonatomic) IBOutlet UISwitch *swichIdleAlarm;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockLabel;
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *idleaLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) NSMutableArray *dataSourceInterval;
@property (strong, nonatomic) NSMutableArray *dataSourceRepeat;
@property (strong, nonatomic) NSMutableArray *dataSourceGsmAlarmOne;
@property (strong, nonatomic) NSMutableArray *dataSourceGsmAlarmTwo;
@property (strong, nonatomic) NSMutableArray *dataSourceIdieAlarm;

@property (strong, nonatomic) NSString *valuePickerViewInterval;
@property (strong, nonatomic) NSString *valuePickerViewRepeat;
@property (strong, nonatomic) NSString *valuePickerViewGsm;
@property (strong, nonatomic) NSString *valuePickerViewGps;
@property (strong, nonatomic) NSString *valuePickerViewEdleAlarm;

@property (strong, nonatomic) NSArray *recipient;
@property (strong, nonatomic) NSArray *comands;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic) NSInteger counterComand;
@property (assign, nonatomic) NSInteger regognizer;

@end

@implementation TSStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureController];
    [self loadSettingsPickerView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLaunguage];
}


- (void)loadSettingsPickerView
{
    
    NSInteger valueIntervalPC = [self.userDefaults integerForKey:@"valueInterval"];
    NSInteger valueRepeatPC = [self.userDefaults integerForKey:@"valueRepeatAlarm"];
    NSInteger valueGsmPC = [self.userDefaults integerForKey:@"valueGSM"];
    NSInteger valueGpsPC = [self.userDefaults integerForKey:@"valueGPS"] - 1;
    NSInteger valueEdlePC = [self.userDefaults integerForKey:@"valueEdleAlarm"];
    
    NSString *string = [NSString stringWithFormat:@"%ld", (long)valueGsmPC];
    NSMutableString *conrvertStringGsm = [NSMutableString stringWithString:string];
    [conrvertStringGsm deleteCharactersInRange:NSMakeRange([conrvertStringGsm length] - 1, 1)];
    NSInteger convertGsm = [conrvertStringGsm intValue];
    
    [self.intervalPickerView selectRow:valueIntervalPC inComponent:0 animated:NO];
    [self.alarmWiedPickerView selectRow:valueRepeatPC inComponent:0 animated:NO];
    [self.gsmAlarmOnePickerView selectRow:convertGsm - 1 inComponent:0 animated:NO];
    [self.gsmAlarmTwoPickerView selectRow:valueGpsPC inComponent:0 animated:NO];
    [self.idieAlarmPickerView selectRow:valueEdlePC inComponent:0 animated:NO];
    
    BOOL interval = [self.userDefaults boolForKey:@"switchInterval"];
    BOOL lock = [self.userDefaults boolForKey:@"switchLock"];
    BOOL repeat = [self.userDefaults boolForKey:@"switchRepeat"];
    BOOL gsm = [self.userDefaults boolForKey:@"switchGsmAlarm"];
    BOOL gps = [self.userDefaults boolForKey:@"switchGpsAlarm"];
    BOOL idlealarm = [self.userDefaults boolForKey:@"switchidlealarm"];
    
    [self.switchInterval setOn:interval animated:YES];
    [self.switchLock setOn:lock animated:YES];
    [self.switchRepeat setOn:repeat animated:YES];
    [self.switchGsmAlarm setOn:gsm animated:YES];
    [self.switchGpsAlarm setOn:gps animated:YES];
    [self.switchidlealarm setOn:idlealarm animated:YES];
 
}


#pragma mark - Configuration controller


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




#pragma mark - Actions


- (IBAction)ationTestButton:(id)sender
{
    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
    
    self.regognizer = 2;
}


- (IBAction)ationSendButton:(id)sender
{
    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
    
    self.counter = 0;
    self.counterComand = 0;
    self.regognizer = 1;
    
}


#pragma mark - save picker view and switch position


- (void)savePickerViewAndSwitchPositionCommand
{
    
    NSInteger interval = [self.valuePickerViewInterval integerValue];
    NSInteger repeatAlarm = [self.valuePickerViewRepeat integerValue];
    NSInteger gsm = [self.valuePickerViewGsm integerValue];
    NSInteger gps = [self.valuePickerViewGps integerValue];
    NSInteger edleAlarm = [self.valuePickerViewEdleAlarm integerValue];
    
    
    [self.userDefaults setInteger:interval forKey:@"valueInterval"];
    [self.userDefaults setInteger:repeatAlarm forKey:@"valueRepeatAlarm"];
    [self.userDefaults setInteger:gsm forKey:@"valueGSM"];
    [self.userDefaults setInteger:gps forKey:@"valueGPS"];
    [self.userDefaults setInteger:edleAlarm forKey:@"valueEdleAlarm"];
    
    
    [self.userDefaults setBool:self.switchInterval.isOn forKey:@"switchInterval"];
    [self.userDefaults setBool:self.switchLock.isOn forKey:@"switchLock"];
    [self.userDefaults setBool:self.switchRepeat.isOn forKey:@"switchRepeat"];
    [self.userDefaults setBool:self.switchGsmAlarm.isOn forKey:@"switchGsmAlarm"];
    [self.userDefaults setBool:self.switchGpsAlarm.isOn forKey:@"switchGpsAlarm"];
    [self.userDefaults setBool:self.switchidlealarm.isOn forKey:@"switchidlealarm"];
    
    [self.userDefaults synchronize];
    
}


#pragma mark - Configuration comand


- (NSArray *)configureCommand
{
    
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    
    NSString *lock = nil;
    NSString *repeatAlarm = nil;
    NSString *gsm = nil;
    NSString *gps = nil;
    NSString *edleAlarm = nil;
    
    
    self.valuePickerViewRepeat = [self pickerView:self.alarmWiedPickerView
                                             titleForRow:[self.alarmWiedPickerView selectedRowInComponent:0] forComponent:0];
    
    self.valuePickerViewGsm = [self pickerView:self.gsmAlarmOnePickerView
                                             titleForRow:[self.gsmAlarmOnePickerView selectedRowInComponent:0] forComponent:0];
    
    self.valuePickerViewGps = [self pickerView:self.gsmAlarmTwoPickerView
                                             titleForRow:[self.gsmAlarmTwoPickerView selectedRowInComponent:0] forComponent:0];
    
    self.valuePickerViewEdleAlarm = [self pickerView:self.idieAlarmPickerView
                                             titleForRow:[self.idieAlarmPickerView selectedRowInComponent:0] forComponent:0];
    
   
    if (self.switchLock.isOn) {
        lock = [NSString stringWithFormat:@"​SET LOCK #%@", pin];
    } else {
        lock = [NSString stringWithFormat:@"RESET LOCK #%@", pin];
    }
    
    if (self.switchRepeat.isOn) {
        repeatAlarm = [NSString stringWithFormat:@"​SET REPEAT %@ #%@", self.valuePickerViewRepeat, pin];
    } else {
        repeatAlarm = [NSString stringWithFormat:@"RESET REPEAT #%@", pin];
    }
    
    if (self.switchGsmAlarm.isOn) {
        gsm = [NSString stringWithFormat:@"​SET GSMALARM %@ #%@", self.valuePickerViewGsm, pin];
    } else {
        gsm = [NSString stringWithFormat:@"RESET GSMALARM #%@", pin];
    }
    
    if (self.switchGpsAlarm.isOn) {
        gps = [NSString stringWithFormat:@"​SET GPSALARM %@ #%@", self.valuePickerViewGps, pin];
    } else {
        gps = [NSString stringWithFormat:@"RESET GPSALARM #%@", pin];
    }
    
    if (self.switchidlealarm.isOn) {
        edleAlarm = [NSString stringWithFormat:@"​SET IDLEALARM %@ #%@", self.valuePickerViewEdleAlarm, pin];
    } else {
        edleAlarm = [NSString stringWithFormat:@"RESET IDLEALARM #%@", pin];
    }
    
    NSArray *comands = @[lock, repeatAlarm, gsm, gps, edleAlarm];
    
    return comands;
}



- (NSString *)configureCommandStatus
{
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    
    NSString *status = nil;
    
    self.valuePickerViewInterval = [self pickerView:self.intervalPickerView
                                             titleForRow:[self.intervalPickerView selectedRowInComponent:0] forComponent:0];
    
    if (self.switchInterval.isOn) {
        status = [NSString stringWithFormat:@"​SET STATUS %@ #%@", self.valuePickerViewInterval, pin];
    } else {
        status = [NSString stringWithFormat:@"SET STATUS #%@", pin];
    }
    
    return status;
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
    self.comands = [self configureCommand];
    
    if (self.counterComand <= [self.comands count]) {
        
        NSString *comand = nil;
        
        if (self.regognizer == 1) {
            comand = [self.comands objectAtIndex:self.counterComand];
        } else if (self.regognizer == 2) {
            comand = [self configureCommandStatus];
        }
        
        MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:comand];
        messageComposeViewController.messageComposeDelegate = self;
        
        ++self.counterComand;
        [self dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:messageComposeViewController animated:YES completion:nil];
        [self savePickerViewAndSwitchPositionCommand];
    }
    
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
        
        if (self.counter <= [self.comands count] - 2 && self.regognizer == 1) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self sendMessage:self.recipient];
                ++self.counter;
            });
        }
    }
    else {
        NSLog(@"Message failed");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - methods set launguage


- (void)setLaunguage
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
    [self.lockLabel setText:@"Lock"];
    [self.repeatLabel setText:@"Alarm repeat"];
    [self.intervalLabel setText:@"Interval"];
    [self.idleaLabel setText:@"Idlealarm"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.lockLabel setText:@"Tastensperre"];
    [self.repeatLabel setText:@"Alarm-Wiederholung"];
    [self.intervalLabel setText:@"Intervall"];
    [self.idleaLabel setText:@"IdlealarmAUDIO"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}



@end
