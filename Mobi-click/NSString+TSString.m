//
//  NSString+TSString.m
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "NSString+TSString.h"
#import "TSPrefixHeader.pch"

@implementation NSString (TSString)

+ (NSString *)prefixNumberPhone:(NSString *)numberPhone checker:(BOOL)checker
{
    NSString *checkerIsOn = nil;
    
    if (checker == YES) {
        checkerIsOn = @"S";
    } else if (checker == NO) {
        checkerIsOn = @"C";
    }
    
    return [NSString stringWithFormat:@"Set TEL1 %@ 49%@", checkerIsOn, numberPhone];
}


+ (NSString *)prefixNumberPhoneAndPin:(NSString *)numberPhone checker:(BOOL)checker
{
    NSString *checkerIsOn = nil;
    
    if (checker == YES) {
        checkerIsOn = @"S";
    } else if (checker == NO) {
        checkerIsOn = @"C";
    }
    
    return [NSString stringWithFormat:@"Set TEL1 %@ 49%@ %@#", checkerIsOn, numberPhone, PIN];
}

@end
