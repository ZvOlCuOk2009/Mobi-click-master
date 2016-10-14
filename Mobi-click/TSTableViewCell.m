//
//  TSTableViewCell.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSTableViewCell.h"
#import "TSPrefixHeader.pch"

@implementation TSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.checkerButton.layer.borderColor = BLUE_COLOR.CGColor;
    
    self.clickImage = [UIImage imageNamed:@"click"];
    self.noclickImage = [UIImage imageNamed:@"noclick"];
    
    self.switchCheker = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)actionCheckerButton:(id)sender
{
    
    if (self.switchCheker == NO) {
        [self.checkerButton setImage:self.clickImage forState:UIControlStateNormal];
        self.switchCheker = YES;
    } else if (self.switchCheker == YES) {
        [self.checkerButton setImage:self.noclickImage forState:UIControlStateNormal];
        self.switchCheker = NO;
    }
    
}


@end
