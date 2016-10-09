//
//  NSString+TSString.h
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TSString)

+ (NSString *)prefixNumberPhone:(NSString *)numberPhone checker:(BOOL)checker;
+ (NSString *)prefixNumberPhoneAndPin:(NSString *)numberPhone checker:(BOOL)checker; 

@end
