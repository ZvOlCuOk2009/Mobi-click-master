//
//  NSString+TSString.h
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TSString)

+ (NSString *)prefixNumberPhone:(NSArray *)numberPhones checkerPosirion:(NSArray *)checkers;
+ (NSString *)prefixNumberPhoneAndPin:(NSString *)numberPhone checker:(BOOL)checker;
+ (NSString *)nameDiviceComand:(NSString *)nameDevice;
+ (NSString *)setTimeComand:(NSDictionary *)dictionaryValue;


@end
