//
//  TSTableViewCell.h
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ringtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkerButton;
- (IBAction)actionCheckerButton:(id)sender;

@end
