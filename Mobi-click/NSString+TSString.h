//
//  NSString+TSString.h
//  Mobi-click
//
//  Created by Mac on 10.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TSString)

+ (NSString *)sosComand:(NSArray *)numberPhones checkerPosirion:(NSArray *)checkers;
+ (NSString *)telComand:(NSString *)numberPhone checker:(BOOL)checker;
+ (NSString *)nameDiviceComand:(NSString *)nameDevice;
+ (NSString *)setTimeComand:(NSDictionary *)dictionaryValue;
+ (NSString *)changePinComand:(NSString *)newPin;
+ (NSString *)changeLaunguageComand:(NSString *)newLaunguage;

@end
