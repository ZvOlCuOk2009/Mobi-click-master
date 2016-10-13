//
//  TSTelViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSTelViewController.h"
#import "TSPrefixHeader.pch"
#import "TSPostingMessagesManager.h"
#import "NSString+TSString.h"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface TSTelViewController () <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *checkerButton;
@property (assign, nonatomic) BOOL switchCheker;

@property (strong, nonatomic) UIImage * clickImage;
@property (strong, nonatomic) UIImage * noclickImage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation TSTelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.textField.layer.cornerRadius = 8.0f;
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.borderColor = [BLUE_COLOR CGColor];
    self.textField.layer.borderWidth = 3.0f;
    
    self.checkerButton.layer.borderColor = [BLUE_COLOR CGColor];
    
    self.switchCheker = NO;
    
    self.clickImage = [UIImage imageNamed:@"click"];
    self.noclickImage = [UIImage imageNamed:@"noclick"];
}


#pragma marc Actions


- (IBAction)actionChecker:(id)sender
{
    if (self.switchCheker == NO) {
        [self.checkerButton setImage:self.clickImage forState:UIControlStateNormal];
        self.switchCheker = YES;
    } else if (self.switchCheker == YES) {
        [self.checkerButton setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchCheker = NO;
    }
}


- (IBAction)actionSendButton:(id)sender
{
    if (![self.textField.text isEqualToString:@""]) {
        
        NSArray *recipientNumberPhone = @[self.textField.text];
        
        if (self.switchCheker == YES) {
            
            MFMessageComposeViewController *messageComposeViewController = [[TSPostingMessagesManager sharedManager] messageComposeViewController:recipientNumberPhone bodyMessage:[NSString prefixNumberPhoneAndPin:[recipientNumberPhone objectAtIndex:0] checker:self.switchCheker]];
            messageComposeViewController.messageComposeDelegate = self;
            
//            [self presentViewController:messageComposeViewController animated:YES completion:nil];
            
        } else {
            
            
      
        }
        
        NSLog(@"%@", [NSString prefixNumberPhoneAndPin:[recipientNumberPhone objectAtIndex:0] checker:self.switchCheker]);
        
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter a phone number to send the message"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                
                                                            }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField == self.textField) {
        
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
    
    return YES;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MFMessageComposeViewControllerDelegate


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    
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
