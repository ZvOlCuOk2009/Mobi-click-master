//
//  TSMeinViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSMeinViewController.h"
#import "TSPrefixHeader.pch"
#import "TSLaunguageViewController.h"
#import "TSPostingMessagesManager.h"
#import "TSSensorViewController.h"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface TSMeinViewController () <MFMessageComposeViewControllerDelegate, CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *deviceButton;
@property (weak, nonatomic) IBOutlet UIButton *sosButton;
@property (weak, nonatomic) IBOutlet UIButton *telButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UISwitch *switchAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *switchMove;
@property (weak, nonatomic) IBOutlet UISwitch *switchVoice;
@property (weak, nonatomic) IBOutlet UISwitch *switchVibra;

@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sosLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vibraLabel;

@property (strong, nonatomic) NSString *alarm;
@property (strong, nonatomic) NSString *move;
@property (strong, nonatomic) NSString *voice;
@property (strong, nonatomic) NSString *vibra;
@property (strong, nonatomic) NSString *nameDevice;

@property (strong, nonatomic) NSArray *recipient;
@property (strong, nonatomic) NSArray *comands;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSDictionary *valuesDictionary;
@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic) NSInteger counterComand;

@end

@implementation TSMeinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureController];
    
    NSInteger counter = [self.userDefaults integerForKey:@"counter"];
    if (counter == 0) {
        
        NSString *defaultPin = @"1513";
        [self.userDefaults setObject:defaultPin forKey:@"pin"];
        [self.userDefaults setInteger:1 forKey:@"counter"];
        [self.userDefaults synchronize];
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nameDevice = [[NSUserDefaults standardUserDefaults] objectForKey:@"nameDevice"];
    [self setLaunguage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(valuesPickerViewSensorContrNotification:)
                                                 name:ValuesPickerViewNotification
                                               object:nil];
    
    NSLog(@"movie %@ self %@ vibra %@", [self.valuesDictionary objectForKey:@"valueMove"], [self.valuesDictionary objectForKey:@"valueVoice"], [self.valuesDictionary objectForKey:@"valueVibra"]);
}


-(void)viewDidDisappear:(BOOL)animated
{
    [self savePositionsSwitchs];
}


- (void)savePositionsSwitchs
{
    [self.userDefaults setBool:self.switchAlarm.isOn forKey:@"alarm"];
    [self.userDefaults setBool:self.switchMove.isOn forKey:@"move"];
    [self.userDefaults setBool:self.switchVoice.isOn forKey:@"voice"];
    [self.userDefaults setBool:self.switchVibra.isOn forKey:@"vibra"];
    [self.userDefaults synchronize];
}


#pragma mark - Notification


- (void)valuesPickerViewSensorContrNotification:(NSNotification *)notification
{
    self.valuesDictionary = [notification object];
}


#pragma mark - Configuration


- (void)configureController
{
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [titleImageView setFrame:CGRectMake(0, 0, 250, 44)];
    self.navigationItem.titleView = titleImageView;
    
    self.deviceButton.layer.borderColor = BLUE_COLOR.CGColor;
    self.sosButton.layer.borderColor = BLUE_COLOR.CGColor;
    self.telButton.layer.borderColor = BLUE_COLOR.CGColor;
    
    BOOL alarm = [self.userDefaults boolForKey:@"alarm"];
    BOOL move = [self.userDefaults boolForKey:@"move"];
    BOOL voice = [self.userDefaults boolForKey:@"voice"];
    BOOL vibra = [self.userDefaults boolForKey:@"vibra"];
    
    [self.switchAlarm setOn:alarm animated:YES];
    [self.switchMove setOn:move animated:YES];
    [self.switchVoice setOn:voice animated:YES];
    [self.switchVibra setOn:vibra animated:YES];
    
}


- (NSArray *)configureCommand
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pin = [userDefaults objectForKey:@"pin"];
    
    NSString *sensorSettingsMovie = [self.valuesDictionary objectForKey:@"valueMove"];
    NSString *sensorSettingsVoice = [self.valuesDictionary objectForKey:@"valueVoice"];
    NSString *sensorSettingsVibra = [self.valuesDictionary objectForKey:@"valueVibra"];
    
    if (self.switchAlarm.isOn) {
        self.alarm = [NSString stringWithFormat:@"SET SECURITY #%@", pin];
    } else {
        self.alarm = [NSString stringWithFormat:@"RESET SECURITY #%@", pin];
    }
    
    if (self.switchMove.isOn) {
        self.move = [NSString stringWithFormat:@"SET MOVE%@ #%@", sensorSettingsMovie, pin];
    } else {
        self.move = [NSString stringWithFormat:@"RESET MOVE #%@", pin];
    }
    
    if (self.switchVoice.isOn) {
        self.voice = [NSString stringWithFormat:@"SET VOICE%@ #%@", sensorSettingsVoice, pin];
    } else {
        self.voice = [NSString stringWithFormat:@"RESET VOICE #%@", pin];
    }
    
    if (self.switchVibra.isOn) {
        self.vibra = [NSString stringWithFormat:@"SET VIBRA%@ #%@", sensorSettingsVibra, pin];
    } else {
        self.vibra = [NSString stringWithFormat:@"RESET VIBRA #%@", pin];
    }
    
    
    NSArray *comands = @[self.alarm, self.move, self.voice, self.vibra];
    
    NSLog(@"comands %@, %@, %@, %@", self.alarm, self.move, self.voice, self.vibra);
    
    return comands;
}


#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{

    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
  
    self.counter = 0;
    self.counterComand = 0;
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
        
        NSString *comand = [self.comands objectAtIndex:self.counterComand];
        
        MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:comand];
        messageComposeViewController.messageComposeDelegate = self;
        
        ++self.counterComand;
        [self dismissViewControllerAnimated:NO completion:nil];
        [self presentViewController:messageComposeViewController animated:YES completion:nil];
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
    
        if (self.counter <= [self.comands count] - 2) {
            
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
    [self.deviceLabel setText:@"Device"];
    [self.sosLabel setText:@"SOS"];
    [self.telLabel setText:@"TEL"];
    [self.alarmLabel setText:@"Alarm"];
    [self.moveLabel setText:@"Move"];
    [self.voiceLabel setText:@"Voice"];
    [self.vibraLabel setText:@"Vibra"];
    [self.deviceButton setTitle:self.nameDevice forState:UIControlStateNormal];
    [self.sosButton setTitle:@"Phone numbers" forState:UIControlStateNormal];
    [self.telButton setTitle:@"Phone numbers" forState:UIControlStateNormal];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.deviceLabel setText:@"Gerät"];
    [self.sosLabel setText:@"SOS"];
    [self.telLabel setText:@"TEL"];
    [self.alarmLabel setText:@"Alarm"];
    [self.moveLabel setText:@"Bewegung"];
    [self.voiceLabel setText:@"Stimme"];
    [self.vibraLabel setText:@"Vibra"];
    [self.deviceButton setTitle:self.nameDevice forState:UIControlStateNormal];
    [self.sosButton setTitle:@"Telefonnummern" forState:UIControlStateNormal];
    [self.telButton setTitle:@"Telefonnummern" forState:UIControlStateNormal];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
