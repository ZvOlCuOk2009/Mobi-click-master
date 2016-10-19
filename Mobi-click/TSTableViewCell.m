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


}

- (IBAction)actionCheckerButton:(id)sender
{
    
    
    
}


@end
