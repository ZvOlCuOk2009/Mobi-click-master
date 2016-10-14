//
//  TSAudioViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSAudioViewController.h"
#import "TSTableViewCell.h"
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"
#import "TSPrefixHeader.pch"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface TSAudioViewController () <UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate, CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *loudspeackerPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *microphonePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ringtonesPickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakerVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *microphoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *signalVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ringonLabel;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *checkerButton;

@property (strong, nonatomic) NSMutableArray *dataSourceSpeakerVolume;
@property (strong, nonatomic) NSMutableArray *dataSourceMicrophone;
@property (strong, nonatomic) NSMutableArray *dataSourceSignalVolume;
@property (strong, nonatomic) NSArray *namesRingtons;

@property (strong, nonatomic) NSArray *recipient;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSDictionary *valuesDictionary;
@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (assign, nonatomic) NSInteger determinantPressedButton;
@property (assign, nonatomic) BOOL switchCheker;

@end

@implementation TSAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self configureContrioller];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLaunguage];
}


#pragma mark - Configure contrioller


- (void)configureContrioller
{
    self.loudspeackerPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.microphonePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.ringtonesPickerView.layer.borderColor = [BLUE_COLOR CGColor];

    
    self.dataSourceSpeakerVolume = [NSMutableArray array];
    self.dataSourceMicrophone = [NSMutableArray array];
    self.dataSourceSignalVolume = [NSMutableArray array];
    
    
    for (int i = 0; i < 10; i++)
    {
        NSString *intervalString = [NSString stringWithFormat:@"%d", i];
        [self.dataSourceSpeakerVolume addObject:intervalString];
        [self.dataSourceMicrophone addObject:intervalString];
        [self.dataSourceSignalVolume addObject:intervalString];
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
            return self.dataSourceSpeakerVolume.count;
            break;
        case 2:
            return self.dataSourceMicrophone.count;
            break;
        case 3:
            return self.dataSourceSignalVolume.count;
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
            return [self.dataSourceSpeakerVolume objectAtIndex:row];
            break;
        case 2:
            return [self.dataSourceMicrophone objectAtIndex:row];
            break;
        case 3:
            return [self.dataSourceSignalVolume objectAtIndex:row];
            break;
        default:
            return 0;
            break;
    }
}


#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{
    self.contactPicker = [[CNContactPickerViewController alloc] init];
    self.contactPicker.delegate = self;
    
    [self presentViewController:self.contactPicker animated:YES completion:nil];
    
    NSLog(@"pressed button - %ld", (long)self.determinantPressedButton);
}


- (IBAction)actionCheckerButton:(id)sender
{
    NSIndexPath *indexPath = [self determineTheAffiliationSectionOfTheCell:sender];
    self.determinantPressedButton = indexPath.row;
}


- (NSIndexPath *)determineTheAffiliationSectionOfTheCell:(UIButton *)button
{
    
    CGPoint buttonPosition = [button convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    return indexPath;
    
}


#pragma mark - UIPickerViewDelegate


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell";
    
    TSTableViewCell *cell = (TSTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[TSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.ringtonLabel.text = [NSString stringWithFormat:@"%@", [self.namesRingtons objectAtIndex:indexPath.row]];

    return  cell;
    
}


#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

    NSString *valuePickerViewLoudspeacker = [self pickerView:self.loudspeackerPickerView
                                                 titleForRow:[self.loudspeackerPickerView selectedRowInComponent:0] forComponent:0];
    
    NSString *valuePickerViewMicrophone = [self pickerView:self.microphonePickerView
                                               titleForRow:[self.microphonePickerView selectedRowInComponent:0] forComponent:0];
    
    NSString *valuePickerViewRingtones = [self pickerView:self.ringtonesPickerView
                                              titleForRow:[self.ringtonesPickerView selectedRowInComponent:0] forComponent:0];
    
    NSString *determinantPressedButton = [NSString stringWithFormat:@"%ld", (long)self.determinantPressedButton];
    
    NSDictionary *dictionaryValue = @{@"speaker":valuePickerViewLoudspeacker,
                                      @"microphone":valuePickerViewMicrophone,
                                      @"ringtone":valuePickerViewRingtones,
                                      @"determinant":determinantPressedButton};
    
    MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:[NSString setRingtonComand:dictionaryValue]];
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



#pragma mark - methods set launguage


- (void)setLaunguage
{
    NSString *language = [self.userDefaults objectForKey:@"language"];
    
    if ([language isEqualToString:@"English"]) {
        
        self.namesRingtons = @[@"Mystery", @"German national anthem", @"Mozart", @"Strauss", @"Puccini", @"Vici", @"Quick buzzing", @"Compact sound (Standart)", @"Short buzz", @"Long buzz"];
        
        [self setEngleshLaunguage];
        
    } else if ([language isEqualToString:@"German"]) {
        
        self.namesRingtons = @[@"Mystery", @"Deutsche Nationalhymne", @"Mozart", @"Strauss", @"Puccini", @"Vici", @"schneller/kurze Signalfolge", @"Compact Rufton (Standard)", @"kurze Signalfolge", @"langgezogens Signal"];
        
        [self setGermanLaunguage];
    }
}


- (void)setEngleshLaunguage
{
    [self.titleLabel setText:@"Audio volume control and ringing"];
    [self.speakerVolumeLabel setText:@"Speaker volume"];
    [self.microphoneLabel setText:@"Microphone sensitivity"];
    [self.signalVolumeLabel setText:@"Call signal volume"];
    [self.ringonLabel setText:@"Ringtones"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.titleLabel setText:@"Audio Lautstärkeregler und Ruftone"];
    [self.speakerVolumeLabel setText:@"Lautsprecher-Lautstärke"];
    [self.microphoneLabel setText:@"Mikrofon-Lautstärke"];
    [self.signalVolumeLabel setText:@"Rufton-Lautstärke"];
    [self.ringonLabel setText:@"Ruftone"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}



@end
