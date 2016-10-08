//
//  TSLaunguageViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSLaunguageViewController.h"
#import "TSPrefixHeader.pch"

@interface TSLaunguageViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewLaunguage;
@property (weak, nonatomic) IBOutlet UIButton *deButton;
@property (weak, nonatomic) IBOutlet UIButton *enButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPin;

@end

@implementation TSLaunguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerViewLaunguage.layer.borderColor = [BLUE_COLOR CGColor];
    self.deButton.layer.borderColor = [BLUE_COLOR CGColor];
    self.enButton.layer.borderColor = [BLUE_COLOR CGColor];
    self.textFieldPin.layer.borderColor = [BLUE_COLOR CGColor];
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
