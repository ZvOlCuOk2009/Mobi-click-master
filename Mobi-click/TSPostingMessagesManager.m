//
//  TSPostingMessages.m
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSPostingMessagesManager.h"

@implementation TSPostingMessagesManager

+ (TSPostingMessagesManager *)sharedManager
{
    static TSPostingMessagesManager *manger = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[TSPostingMessagesManager alloc] init];
    });
    return manger;
}


- (MFMessageComposeViewController *)messageComposeViewController:(NSArray *)phoneNumberToСall bodyMessage:(NSString *)bodyMessage
{
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.messageComposeDelegate = self;
    [messageComposeViewController setRecipients:phoneNumberToСall];
    [messageComposeViewController setBody:bodyMessage];
    
    return messageComposeViewController;
    //    [self presentViewController:messageComposeViewController animated:YES completion:nil];
}


- (void)callingSubscriberByNumberPhone:(NSString *)phoneNumber
{
    NSString *numberPrefix = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberPrefix]];
}


#pragma mark - MFMessageComposeViewControllerDelegate


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller
                didFinishWithResult:(MessageComposeResult)result
{
    
}


@end
