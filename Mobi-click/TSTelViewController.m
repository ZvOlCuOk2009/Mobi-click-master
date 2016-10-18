//
//  TSTelViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSTelViewController.h"
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"
#import "TSPrefixHeader.pch"


@interface TSTelViewController () <MFMessageComposeViewControllerDelegate, CNContactPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *checkerButton;
@property (assign, nonatomic) BOOL switchCheker;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation TSTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.textField.layer.cornerRadius = 8.0f;
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.borderColor = [BLUE_COLOR CGColor];
    self.textField.layer.borderWidth = 3.0f;
    
    self.checkerButton.layer.borderColor = [BLUE_COLOR CGColor];
    
    self.switchCheker = NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLauguage];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (IS_IPHONE_4) {
        [self.scrollView setContentSize:CGSizeMake(320, 436)];
        self.scrollView.frame = CGRectMake(0, 64, 320, 436);
    } else if (IS_IPHONE_5) {
        [self.scrollView setContentSize:CGSizeMake(320, 524)];
        self.scrollView.frame = CGRectMake(0, 64, 320, 524);
    } else if (IS_IPHONE_6) {
        [self.scrollView setContentSize:CGSizeMake(320, 603)];
        self.scrollView.frame = CGRectMake(0, 64, 375, 603);
    } else if (IS_IPHONE_6_PLUS) {
        [self.scrollView setContentSize:CGSizeMake(320, 672)];
        self.scrollView.frame = CGRectMake(0, 64, 414, 672);
    }
}


#pragma marc Actions


- (IBAction)actionChecker:(id)sender
{
    if (![self.textField.text isEqualToString:@""]) {
        if (self.switchCheker == NO) {
            [self.checkerButton setImage:self.clickImage forState:UIControlStateNormal];
            self.switchCheker = YES;
        } else if (self.switchCheker == YES) {
            [self.checkerButton setImage:self.noclickImage forState:UIControlStateNormal];
            self.switchCheker = NO;
        }
    }
}


- (IBAction)actionSendButton:(id)sender
{
    if (![self.textField.text isEqualToString:@""]) {
        
        self.contactPicker = [[CNContactPickerViewController alloc] init];
        self.contactPicker.delegate = self;
        
        [self presentViewController:self.contactPicker animated:YES completion:nil];

        
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter a phone number to send the comand"
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
    
    MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipients bodyMessage:[NSString telComand:self.textField.text checker:self.switchCheker]];
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



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([newString length] >= 10) {
        return  NO;
    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
