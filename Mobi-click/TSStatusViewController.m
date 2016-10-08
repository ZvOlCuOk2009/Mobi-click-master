//
//  TSStatusViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSStatusViewController.h"
#import "TSPrefixHeader.pch"

@interface TSStatusViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *intervalPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *alarmWiedPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmOnePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gsmAlarmTwoPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *idieAlarmPickerView;

@end

@implementation TSStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.intervalPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.alarmWiedPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.gsmAlarmOnePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.gsmAlarmTwoPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.idieAlarmPickerView.layer.borderColor = [BLUE_COLOR CGColor];
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
