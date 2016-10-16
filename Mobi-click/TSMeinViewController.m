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

@interface TSMeinViewController ()

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

//@property (strong, nonatomic) NSArray *recipient;
//@property (strong, nonatomic) NSArray *comands;
//@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSDictionary *valuesDictionary;

@property (assign, nonatomic) NSInteger counter;
//@property (assign, nonatomic) NSInteger counterComand;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TSMeinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureController];
    
    NSInteger counter = [self.userDefaults integerForKey:@"counter"];
    if (counter == 0) {
        
        NSString *defaultPin = @"1513";
        NSString *nameDevice = @"Compact 4";
        [self.userDefaults setObject:defaultPin forKey:@"pin"];
        [self.userDefaults setObject:nameDevice forKey:@"nameDevice"];
        [self.userDefaults setInteger:1 forKey:@"counter"];
        [self.userDefaults synchronize];
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLaunguage];
    
    NSString *nameDevice = [self.userDefaults objectForKey:@"nameDevice"];
    [self.deviceButton setTitle:nameDevice forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(valuesPickerViewSensorContrNotification:)
                                                 name:ValuesPickerViewNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}


- (void)viewDidDisappear:(BOOL)animated
{
    [self savePositionsSwitchs];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (IS_IPHONE_4) {
        [self.scrollView setContentSize:CGSizeMake(320, 603)];
        self.scrollView.frame = CGRectMake(0, 64, 320, 436);
    } else if (IS_IPHONE_5) {
        [self.scrollView setContentSize:CGSizeMake(320, 603)];
        self.scrollView.frame = CGRectMake(0, 64, 320, 524);
    } else if (IS_IPHONE_6) {
        [self.scrollView setContentSize:CGSizeMake(320, 603)];
        self.scrollView.frame = CGRectMake(0, 64, 375, 623);
    } else if (IS_IPHONE_6_PLUS) {
        [self.scrollView setContentSize:CGSizeMake(320, 672)];
        self.scrollView.frame = CGRectMake(0, 64, 414, 692);
    }
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
    
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.titleImageView setFrame:CGRectMake(0, 0, 250, 44)];
    self.navigationItem.titleView = self.titleImageView;
    
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

    self.clickImage = [UIImage imageNamed:@"click"];
    self.noclickImage = [UIImage imageNamed:@"noclick"];
}


- (NSArray *)configureCommand
{
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    
    NSString *sensorSettingsMovie = [self.valuesDictionary objectForKey:@"valueMove"];
    NSString *sensorSettingsVoice = [self.valuesDictionary objectForKey:@"valueVoice"];
    NSString *sensorSettingsVibra = [self.valuesDictionary objectForKey:@"valueVibra"];
    
    NSString *alarm = nil;
    NSString *move = nil;
    NSString *voice = nil;
    NSString *vibra = nil;
    
    if (self.switchAlarm.isOn) {
        alarm = [NSString stringWithFormat:@"SET SECURITY #%@", pin];
    } else {
        alarm = [NSString stringWithFormat:@"RESET SECURITY #%@", pin];
    }
    
    if (self.switchMove.isOn) {
        move = [NSString stringWithFormat:@"SET MOVE%@ #%@", sensorSettingsMovie, pin];
    } else {
        move = [NSString stringWithFormat:@"RESET MOVE #%@", pin];
    }
    
    if (self.switchVoice.isOn) {
        voice = [NSString stringWithFormat:@"SET VOICE%@ #%@", sensorSettingsVoice, pin];
    } else {
        voice = [NSString stringWithFormat:@"RESET VOICE #%@", pin];
    }
    
    if (self.switchVibra.isOn) {
        vibra = [NSString stringWithFormat:@"SET VIBRA%@ #%@", sensorSettingsVibra, pin];
    } else {
        vibra = [NSString stringWithFormat:@"RESET VIBRA #%@", pin];
    }
    
    
    NSArray *comands = @[alarm, move, voice, vibra];
        
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



#pragma mark - Keyboard notification


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.view.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.origin.y - kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}


- (void)keyboardDidHide:(NSNotification *)notification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
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
    [self.sosButton setTitle:@"Telefonnummern" forState:UIControlStateNormal];
    [self.telButton setTitle:@"Telefonnummern" forState:UIControlStateNormal];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
