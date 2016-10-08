//
//  TSHoldAlarmViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSHoldAlarmViewController.h"
#import "TSPrefixHeader.pch"

@interface TSHoldAlarmViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *checkerOutletCollection;
@property (weak, nonatomic) IBOutlet UIPickerView *fromMinPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *fromHourPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *toMinPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *toHourPickerViewOne;
@property (weak, nonatomic) IBOutlet UIPickerView *fromMinPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *fromHourPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *toMinPickerViewTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *toHourPickerViewTwo;

@end

@implementation TSHoldAlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (UIButton *button in self.checkerOutletCollection)
    {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    self.fromMinPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromHourPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.toMinPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.toHourPickerViewOne.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromMinPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.fromHourPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.toMinPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
    self.toHourPickerViewTwo.layer.borderColor = [BLUE_COLOR CGColor];
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
