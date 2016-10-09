//
//  TSSOSViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSOSViewController.h"
#import "TSPrefixHeader.pch"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface TSSOSViewController () <MFMessageComposeViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;

@property (weak, nonatomic) IBOutlet UIButton *checkerButtonOne;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonTwo;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonThree;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFore;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonFive;
@property (weak, nonatomic) IBOutlet UIButton *checkerButtonSix;

@property (assign, nonatomic) BOOL switchChekerOne;
@property (assign, nonatomic) BOOL switchChekerTwo;
@property (assign, nonatomic) BOOL switchChekerThree;
@property (assign, nonatomic) BOOL switchChekerFore;
@property (assign, nonatomic) BOOL switchChekerFive;
@property (assign, nonatomic) BOOL switchChekerSix;

@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldOne;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldThree;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldFore;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldFive;
@property (weak, nonatomic) IBOutlet UITextField *numberTelTextFieldSix;

@property (strong, nonatomic) UIImage * clickImage;
@property (strong, nonatomic) UIImage * noclickImage;

@end

@implementation TSSOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.numberTelTextFieldOne.delegate = self;
    self.numberTelTextFieldTwo.delegate = self;
    self.numberTelTextFieldThree.delegate = self;
    self.numberTelTextFieldFore.delegate = self;
    self.numberTelTextFieldFive.delegate = self;
    self.numberTelTextFieldSix.delegate = self;
    
    for (UITextField *textField in self.textFieldOutletCollection)
    {
        textField.layer.borderColor = [BLUE_COLOR CGColor];
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
  
    if (self.switchChekerOne == NO) {
        [self.checkerButtonOne setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerOne = YES;
    } else if (self.switchChekerOne == YES) {
        [self.checkerButtonOne setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerOne = NO;
    }
    
}


- (IBAction)actionCheckerTwo:(id)sender
{
    
    if (self.switchChekerTwo == NO) {
        [self.checkerButtonTwo setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerTwo = YES;
    } else if (self.switchChekerTwo == YES) {
        [self.checkerButtonTwo setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerTwo = NO;
    }
    
}


- (IBAction)actionCheckerThree:(id)sender
{
    
    if (self.switchChekerThree == NO) {
        [self.checkerButtonThree setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerThree = YES;
    } else if (self.switchChekerThree == YES) {
        [self.checkerButtonThree setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerThree = NO;
    }
    
}


- (IBAction)actionCheckerFore:(id)sender
{
    
    if (self.switchChekerFore == NO) {
        [self.checkerButtonFore setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerFore = YES;
    } else if (self.switchChekerFore == YES) {
        [self.checkerButtonFore setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerFore = NO;
    }
    
}


- (IBAction)actionCheckerFive:(id)sender
{
    
    if (self.switchChekerFive == NO) {
        [self.checkerButtonFive setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerFive = YES;
    } else if (self.switchChekerFive == YES) {
        [self.checkerButtonFive setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerFive = NO;
    }
    
}


- (IBAction)actionCheckerSix:(id)sender
{
    
    if (self.switchChekerSix == NO) {
        [self.checkerButtonSix setImage:self.clickImage forState:UIControlStateNormal];
        self.switchChekerSix = YES;
    } else if (self.switchChekerSix == YES) {
        [self.checkerButtonSix setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchChekerSix = NO;
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
        
        
        NSArray *recipientNumberPhoneOne = @[self.numberTelTextFieldOne.text];
        NSArray *recipientNumberPhoneTwo = @[self.numberTelTextFieldTwo.text];
        NSArray *recipientNumberPhoneThree = @[self.numberTelTextFieldThree.text];
        NSArray *recipientNumberPhoneFore = @[self.numberTelTextFieldFore.text];
        NSArray *recipientNumberPhoneFive = @[self.numberTelTextFieldFive.text];
        NSArray *recipientNumberPhoneSix = @[self.numberTelTextFieldSix.text];
        
        
        if (self.switchChekerOne == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneOne bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneOne objectAtIndex:0] checker:self.switchChekerOne]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneOne objectAtIndex:0] checker:self.switchChekerOne]];
        }
        
        
        if (self.switchChekerTwo == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneTwo bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneTwo objectAtIndex:0] checker:self.switchChekerTwo]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneTwo objectAtIndex:0] checker:self.switchChekerTwo]];
        }
        
        
        if (self.switchChekerThree == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneThree bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneThree objectAtIndex:0] checker:self.switchChekerThree]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneThree objectAtIndex:0] checker:self.switchChekerThree]];
        }
        
        
        if (self.switchChekerFore == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneFore bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneFore objectAtIndex:0] checker:self.switchChekerFore]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneFore objectAtIndex:0] checker:self.switchChekerFore]];
        }
        
        
        if (self.switchChekerFive == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneFive bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneFive objectAtIndex:0] checker:self.switchChekerFive]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneFive objectAtIndex:0] checker:self.switchChekerFive]];
        }
        
        
        
        if (self.switchChekerSix == YES) {
            
            [self messageComposeViewController:recipientNumberPhoneSix bodyMessage:[self prefixNumberPhone:[recipientNumberPhoneSix objectAtIndex:0] checker:self.switchChekerSix]];
            
        } else {
            
            [self callingSubscriberByNumberPhone:[self prefixNumberPhone:[recipientNumberPhoneSix objectAtIndex:0] checker:self.switchChekerSix]];
        }
        
        
        
        NSLog(@"%@\n%@\n%@\n%@\n%@\n%@", [self prefixNumberPhone:[recipientNumberPhoneOne objectAtIndex:0] checker:self.switchChekerOne],
              [self prefixNumberPhone:[recipientNumberPhoneTwo objectAtIndex:0] checker:self.switchChekerTwo],
              [self prefixNumberPhone:[recipientNumberPhoneThree objectAtIndex:0] checker:self.switchChekerThree],
              [self prefixNumberPhone:[recipientNumberPhoneFore objectAtIndex:0] checker:self.switchChekerFore],
              [self prefixNumberPhone:[recipientNumberPhoneFive objectAtIndex:0] checker:self.switchChekerFive],
              [self prefixNumberPhone:[recipientNumberPhoneSix objectAtIndex:0] checker:self.switchChekerSix]);
        
    } else {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You must enter at least one phone number to send messages"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                
                                                            }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }

//    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)messageComposeViewController:(NSArray *)phoneNumberToСall bodyMessage:(NSString *)bodyMessage
{
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.messageComposeDelegate = self;
    [messageComposeViewController setRecipients:phoneNumberToСall];
    [messageComposeViewController setBody:bodyMessage];
    
//    [self presentViewController:messageComposeViewController animated:YES completion:nil];
}


- (void)callingSubscriberByNumberPhone:(NSString *)phoneNumber
{
    NSString *numberPrefix = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberPrefix]];
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


- (NSString *)prefixNumberPhone:(NSString *)numberPhone checker:(BOOL)checker
{
    NSString *checkerIsOn = nil;
    
    if (checker == YES) {
        checkerIsOn = @"S";
    } else if (checker == NO) {
        checkerIsOn = @"C";
    }
    
    return [NSString stringWithFormat:@"Set TEL1 %@ 49%@", checkerIsOn, numberPhone];
}


#pragma mark - MFMessageComposeViewControllerDelegate


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
