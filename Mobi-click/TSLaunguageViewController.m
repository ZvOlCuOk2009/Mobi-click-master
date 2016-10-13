//
//  TSLaunguageViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSLaunguageViewController.h"
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"
#import "TSPrefixHeader.pch"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface TSLaunguageViewController () <MFMessageComposeViewControllerDelegate, CNContactPickerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *launguagePickerView;

@property (weak, nonatomic) IBOutlet UILabel *launguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPinLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UILabel *displayOldPinLabel;
@property (strong, nonatomic) NSString *launguage;

@property (strong, nonatomic) NSArray *recipient;
@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPin;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSArray *comands;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic) NSInteger counterComand;

@end

@implementation TSLaunguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"English", @"German"];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.launguagePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.textFieldNewPin.layer.borderColor = [BLUE_COLOR CGColor];
    self.displayOldPinLabel.layer.borderColor = [BLUE_COLOR CGColor];
    
    [self setPinToLabel];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.launguage = [self.userDefaults objectForKey:@"language"];
    NSInteger row;
    if ([self.launguage isEqualToString:@"English"]) {
        row = 0;
    } else if ([self.launguage isEqualToString:@"German"]) {
        row = 1;
    }
    
    [self.launguagePickerView selectRow:row inComponent:0 animated:NO];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


- (void)setPinToLabel
{
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    self.displayOldPinLabel.text = [NSString stringWithFormat:@"  %@", pin];
}


#pragma mark - warning that the command is not sent


- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    if (!parent && ([[self configureCommand:0] count] > 0)){
        UIAlertController *alertController = [self alertController:@"The changes will take effect only on the device. To send a command, go back and click ""SEND"" button !!!"];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if (row == 0) {
        [self setEngleshLaunguage];
        [self.userDefaults setObject:@"English" forKey:@"language"];
        [self.userDefaults synchronize];
    } else {
        [self setGermanLaunguage];
        [self.userDefaults setObject:@"German" forKey:@"language"];
        [self.userDefaults synchronize];
    }
    
    return [self.dataSource objectAtIndex:row];
}


- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return component;
}


#pragma mark - UIPickerViewDelegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}



#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{
    NSString *currentValueLaunguage = [self currentValuePickerViewLaunguage];
    
    if (![self.textFieldNewPin.text isEqualToString:@""] || ![self.launguage isEqualToString:currentValueLaunguage])
    {
        self.contactPicker = [[CNContactPickerViewController alloc] init];
        self.contactPicker.delegate = self;
        
        [self presentViewController:self.contactPicker animated:YES completion:nil];
        
        self.counter = 0;
        self.counterComand = 0;
    }
   
}


#pragma mark - Configure comand


- (NSArray *)configureCommand:(NSInteger)recognizer
{
    NSString *currentValueLaunguage = [self currentValuePickerViewLaunguage];
    
    NSString *pin = [self.userDefaults objectForKey:@"pin"];
    
    NSString *prefixLaunguage = nil;
    
    if ([currentValueLaunguage isEqualToString:@"English"]) {
        prefixLaunguage = @"EN";
    } else if ([currentValueLaunguage isEqualToString:@"German"]) {
        prefixLaunguage = @"DE";
    }
    
    NSMutableArray *comands = [NSMutableArray array];
    
    if (![self.launguage isEqualToString:currentValueLaunguage]) {
        NSString *changeLaunguageComand = [NSString stringWithFormat:@"SET LANGUAGE %@ #%@", prefixLaunguage, pin];
        [comands addObject:changeLaunguageComand];
    }
    
    if (![self.textFieldNewPin.text isEqualToString:@""] && ![pin isEqualToString:self.textFieldNewPin.text])
    {
        NSString *changePinComand = [NSString stringWithFormat:@"SET PIN %@ #%@", self.textFieldNewPin.text, pin];
        [comands addObject:changePinComand];
        if (recognizer == 1) {
            [self.userDefaults setObject:self.textFieldNewPin.text forKey:@"pin"];
        }
    }
    
    
    return comands;
}


- (NSString *)currentValuePickerViewLaunguage
{
    NSString *valuePickerViewLaunguage = [self pickerView:self.launguagePickerView
                                              titleForRow:[self.launguagePickerView selectedRowInComponent:0] forComponent:0];
    return valuePickerViewLaunguage;
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
    
    if (self.counterComand == 0) {
        self.comands = [self configureCommand:1];
    }
    
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
        [self setPinToLabel];
        self.textFieldNewPin.text = @"";
        NSInteger countComand = [self.comands count] - 1;
        if (self.counter < countComand) {
            
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


- (void)setEngleshLaunguage
{
    [self.launguageLabel setText:@"Language"];
    [self.oldPinLabel setText:@"Old PIN"];
    [self.pinLabel setText:@"New PIN"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.launguageLabel setText:@"Sprache"];
    [self.oldPinLabel setText:@"Alt PIN"];
    [self.pinLabel setText:@"Neu PIN"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
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


#pragma mark - UIAlertController


- (UIAlertController *)alertController:(NSString *)title
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            
                                                        }];
    [alertController addAction:alertAction];
    
    return alertController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
