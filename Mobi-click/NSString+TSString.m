//
//  NSString+TSString.m
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "NSString+TSString.h"
#import "TSPrefixHeader.pch"

static NSString *pin;

@implementation NSString (TSString)

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        pin = [userDefaults objectForKey:@"pin"];
    }
    return self;
}

+ (NSString *)prefixNumberPhone:(NSArray *)numberPhones checkerPosirion:(NSArray *)checker
{
    
    NSString *numberOne = [numberPhones objectAtIndex:0];
    NSString *numberTwo = [numberPhones objectAtIndex:1];
    NSString *numberThree = [numberPhones objectAtIndex:2];
    NSString *numberFore = [numberPhones objectAtIndex:3];
    NSString *numberFive = [numberPhones objectAtIndex:4];
    NSString *numberSix = [numberPhones objectAtIndex:5];
    
    
    NSString *checkerOne = [checker objectAtIndex:0];
    NSString *checkerTwo = [checker objectAtIndex:1];
    NSString *checkerThree = [checker objectAtIndex:2];
    NSString *checkerFore = [checker objectAtIndex:3];
    NSString *checkerFive = [checker objectAtIndex:4];
    NSString *checkerSix = [checker objectAtIndex:5];
    
    NSString *prefix = @"49";
    
    NSString *comand = [NSString stringWithFormat:@"Set TEL1 %@ %@%@ %@ %@%@ %@ %@%@ %@ %@%@ %@ %@%@ %@ %@%@ #%@", checkerOne, prefix, numberOne, checkerTwo, prefix, numberTwo, checkerThree, prefix, numberThree, checkerFore, prefix, numberFore, checkerFive, prefix, numberFive, checkerSix, prefix, numberSix, pin];
    
    return comand;
    
}


+ (NSString *)prefixNumberPhoneAndPin:(NSString *)numberPhone checker:(BOOL)checker
{
    NSString *checkerIsOn = nil;
    
    if (checker == YES) {
        checkerIsOn = @"S";
    } else if (checker == NO) {
        checkerIsOn = @"C";
    }
    
    return [NSString stringWithFormat:@"Set TEL1 %@ 49%@ %@#", checkerIsOn, numberPhone, pin];
}


+ (NSString *)nameDivice:(NSString *)nameDevice
{
    return [NSString stringWithFormat:@"SET NAME %@ %@#", nameDevice, pin];
}

@end
