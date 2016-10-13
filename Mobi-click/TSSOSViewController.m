//
//  TSSOSViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSOSViewController.h"
#import "TSPrefixHeader.pch"
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <ContactsUI/ContactsUI.h>

@interface TSSOSViewController () <MFMessageComposeViewControllerDelegate, UITextFieldDelegate, CNContactPickerDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;

@property (weak, nonatomic) IBOutlet UIButton *checkerButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFore;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFive;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSix;

@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldOne;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldThree;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldFore;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldFive;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldSix;

@property (strong, nonatomic) UIImage * clickImage;
@property (strong, nonatomic) UIImage * noclickImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) CNContactPickerViewController *contactPicker;

@property (assign, nonatomic) BOOL switchChekerOne;
@property (assign, nonatomic) BOOL switchChekerTwo;
@property (assign, nonatomic) BOOL switchChekerThree;
@property (assign, nonatomic) BOOL switchChekerFore;
@property (assign, nonatomic) BOOL switchChekerFive;
@property (assign, nonatomic) BOOL switchChekerSix;

@property (strong, nonatomic) NSArray *recipient;

@end

@implementation TSSOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    for (UITextField *textField in self.textFieldOutletCollection)
    {
        textField.layer.borderColor = [BLUE_COLOR CGColor];
        textField.delegate = self;
    }
    
    
    self.checkerButtonOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.checkerButtonTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.checkerButtonThree.layer.borderColor = [BLUE_COLOR CGColor];
    self.checkerButtonFore.layer.borderColor = [BLUE_COLOR CGColor];
    self.checkerButtonFive.layer.borderColor = [BLUE_COLOR CGColor];
    self.checkerButtonSix.layer.borderColor = [BLUE_COLOR CGColor];
    
    
    self.switchChekerOne = NO;
    self.switchChekerTwo = NO;
    self.switchChekerThree = NO;
    self.switchChekerFore = NO;
    self.switchChekerFive = NO;
    self.switchChekerSix = NO;
    
    self.clickImage = [UIImage imageNamed:@"click"];
    self.noclickImage = [UIImage imageNamed:@"noclick"];
    
}


#pragma mark - Actions


- (IBAction)actionCheckerOne:(UIButton *)sender
{
  
    if (![self.numberTelTextFieldOne.text isEqualToString:@""]) {
        if (self.switchChekerOne == NO) {
            [self.checkerButtonOne setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerOne = YES;
        } else if (self.switchChekerOne == YES) {
            [self.checkerButtonOne setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerOne = NO;
        }
    }
    
}


- (IBAction)actionCheckerTwo:(id)sender
{
    
    if (![self.numberTelTextFieldTwo.text isEqualToString:@""]) {
        if (self.switchChekerTwo == NO) {
            [self.checkerButtonTwo setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerTwo = YES;
        } else if (self.switchChekerTwo == YES) {
            [self.checkerButtonTwo setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerTwo = NO;
        }
    }
    
}


- (IBAction)actionCheckerThree:(id)sender
{
    
    if (![self.numberTelTextFieldThree.text isEqualToString:@""]) {
        if (self.switchChekerThree == NO) {
            [self.checkerButtonThree setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerThree = YES;
        } else if (self.switchChekerThree == YES) {
            [self.checkerButtonThree setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerThree = NO;
        }
    }
    
}


- (IBAction)actionCheckerFore:(id)sender
{
    
    if (![self.numberTelTextFieldFore.text isEqualToString:@""]) {
        if (self.switchChekerFore == NO) {
            [self.checkerButtonFore setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerFore = YES;
        } else if (self.switchChekerFore == YES) {
            [self.checkerButtonFore setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerFore = NO;
        }
    }

}


- (IBAction)actionCheckerFive:(id)sender
{
    
    if (![self.numberTelTextFieldFive.text isEqualToString:@""]) {
        if (self.switchChekerFive == NO) {
            [self.checkerButtonFive setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerFive = YES;
        } else if (self.switchChekerFive == YES) {
            [self.checkerButtonFive setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerFive = NO;
        }
    }
    
}


- (IBAction)actionCheckerSix:(id)sender
{
    
    if (![self.numberTelTextFieldSix.text isEqualToString:@""]) {
        if (self.switchChekerSix == NO) {
            [self.checkerButtonSix setImage:self.clickImage forState:UIControlStateNormal];
            self.switchChekerSix = YES;
        } else if (self.switchChekerSix == YES) {
            [self.checkerButtonSix setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchChekerSix = NO;
        }
    }
    
}


- (IBAction)actionSendButton:(id)sender
{
    if (![self.numberTelTextFieldOne.text isEqualToString:@""] ||
        ![self.numberTelTextFieldTwo.text isEqualToString:@""] ||
        ![self.numberTelTextFieldThree.text isEqualToString:@""] ||
        ![self.numberTelTextFieldFore.text isEqualToString:@""] ||
        ![self.numberTelTextFieldFive.text isEqualToString:@""] ||
        ![self.numberTelTextFieldSix.text isEqualToString:@""]) {
        
        
        self.contactPicker = [[CNContactPickerViewController alloc] init];
        self.contactPicker.delegate = self;
        
        [self presentViewController:self.contactPicker animated:YES completion:nil];
    
        
    } else {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter at least one phone number to send comand"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                
                                                            }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }

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
    
    NSArray *numberPhones = @[self.numberTelTextFieldOne.text,
                              self.numberTelTextFieldTwo.text,
                              self.numberTelTextFieldThree.text,
                              self.numberTelTextFieldFore.text,
                              self.numberTelTextFieldFive.text,
                              self.numberTelTextFieldSix.text];
    
    
    NSNumber *oneChacker = [NSNumber numberWithBool:self.switchChekerOne];
    NSNumber *twoChacker = [NSNumber numberWithBool:self.switchChekerTwo];
    NSNumber *threeChacker = [NSNumber numberWithBool:self.switchChekerThree];
    NSNumber *foreChacker = [NSNumber numberWithBool:self.switchChekerFore];
    NSNumber *fiveChacker = [NSNumber numberWithBool:self.switchChekerFive];
    NSNumber *sixChacker = [NSNumber numberWithBool:self.switchChekerSix];
    
    
    NSArray *chackerPosition = @[oneChacker, twoChacker, threeChacker, foreChacker, fiveChacker, sixChacker];
    
    NSMutableArray *chakersString = [NSMutableArray array];
    
    for (NSNumber *chacker in chackerPosition) {
        
        BOOL chack = [chacker boolValue];
        NSString *checkerIsOn = nil;
        
        if (chack == YES) {
            checkerIsOn = @"S";
        } else if (chack == NO) {
            checkerIsOn = @"C";
        }
        [chakersString addObject:checkerIsOn];
    }
    
    NSLog(@"comand %@", [NSString sosComand:numberPhones checkerPosirion:chakersString]);

    
    MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:[NSString sosComand:numberPhones checkerPosirion:chakersString]];
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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
    if (textField == self.numberTelTextFieldOne ||
        textField == self.numberTelTextFieldTwo ||
        textField == self.numberTelTextFieldThree ||
        textField == self.numberTelTextFieldFore ||
        textField == self.numberTelTextFieldFive ||
        textField == self.numberTelTextFieldSix) {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:VALID_CHARACTER];
        
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        return YES;
    }
    
    //не работает!
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= LIMIT_CHARACTER;
    
}


#pragma mark - Keyboard notification


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLauguage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


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


#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.numberTelTextFieldOne) {
        [textField resignFirstResponder];
        [self.numberTelTextFieldTwo becomeFirstResponder];
    } else if (textField == self.numberTelTextFieldTwo) {
        [textField resignFirstResponder];
        [self.numberTelTextFieldThree becomeFirstResponder];
    } else if (textField == self.numberTelTextFieldThree) {
        [textField resignFirstResponder];
        [self.numberTelTextFieldFore becomeFirstResponder];
    } else if (textField == self.numberTelTextFieldFore) {
        [textField resignFirstResponder];
        [self.numberTelTextFieldFive becomeFirstResponder];
    } else if (textField == self.numberTelTextFieldFive) {
        [textField resignFirstResponder];
        [self.numberTelTextFieldSix becomeFirstResponder];
    }

    return YES;
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
    [self.titleLabel setText:@"Phonebook programming"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.titleLabel setText:@"Programmierung Telefonnummern"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
