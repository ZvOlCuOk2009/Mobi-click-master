//
//  TSTimeDateViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSTimeDateViewController.h"
#import "TSPrefixHeader.pch"

@interface TSTimeDateViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *hoursPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *minutesPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *daysPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *monthsPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *yearsPickerView;

@end

@implementation TSTimeDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hoursPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.minutesPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.daysPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.monthsPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.yearsPickerView.layer.borderColor = [BLUE_COLOR CGColor];
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
