//
//  TSMeinViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSMeinViewController.h"
#import "TSPrefixHeader.pch"

#import <Messages/Messages.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface TSMeinViewController () <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *deviceButton;
@property (weak, nonatomic) IBOutlet UIButton *sosButton;
@property (weak, nonatomic) IBOutlet UIButton *telButton;

@property (weak, nonatomic) IBOutlet UISwitch *switchAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *switchMove;
@property (weak, nonatomic) IBOutlet UISwitch *switchVoice;
@property (weak, nonatomic) IBOutlet UISwitch *switchVibra;


@end

@implementation TSMeinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [titleImageView setFrame:CGRectMake(0, 0, 250, 44)];
    self.navigationItem.titleView = titleImageView;
    
    self.deviceButton.layer.borderColor = BLUE_COLOR.CGColor;
    self.sosButton.layer.borderColor = BLUE_COLOR.CGColor;
    self.telButton.layer.borderColor = BLUE_COLOR.CGColor;
}


#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{
    
    if (![MFMessageComposeViewController canSendText]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Your device can not send text message" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    NSString *pin = @"1513";
    
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
        move = [NSString stringWithFormat:@"SET MOVE #%@", pin];
    } else {
        move = [NSString stringWithFormat:@"RESET MOVE #%@", pin];
    }
    
    if (self.switchVoice.isOn) {
        voice = [NSString stringWithFormat:@"SET VOICE #%@", pin];
    } else {
        voice = [NSString stringWithFormat:@"RESET VOICE #%@", pin];
    }
    
    if (self.switchVibra.isOn) {
        vibra = [NSString stringWithFormat:@"SET VIBRA #%@", pin];
    } else {
        vibra = [NSString stringWithFormat:@"RESET VIBRA #%@", pin];
    }
    
    
    NSArray *recipient = @[@"0677756449"];
    
    NSString *message = [NSString stringWithFormat:@"%@ %@ %@ %@", alarm, move, voice, vibra];
    
    
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.messageComposeDelegate = self;
    [messageComposeViewController setRecipients:recipient];
    [messageComposeViewController setBody:message];
    
    [self presentViewController:messageComposeViewController animated:YES completion:nil];
    
}


#pragma mark - MFMessageComposeViewControllerDelegate


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops error while ending"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                             }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
