//
//  TSGPSViewController.m
//  Mobi-click
//
//  Created by Mac on 16.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSGPSViewController.h"
#import "TSPrefixHeader.pch"

@interface TSGPSViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *nsOnePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ewOnePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *nsTwoPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ewTwoPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *zonePickerView;

@property (weak, nonatomic) IBOutlet UITextField *lattitudeOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *longtittudeOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *lattitudeTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *longtittudeTwoTextField;

@property (weak, nonatomic) IBOutlet UILabel *lattitudeOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *loungtittudeOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *lattitudeTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *loungtittudeTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *setButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *testButton;

@property (strong, nonatomic) NSArray *dataSourceNS;
@property (strong, nonatomic) NSArray *dataSourceEW;
@property (strong, nonatomic) NSArray *dataSourceZone;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TSGPSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureController];
}



#pragma mark - Actions


- (IBAction)actionButtonSet:(id)sender
{
    
    
}


- (IBAction)actionButtonReset:(id)sender
{
    
}


- (IBAction)actionButtonTest:(id)sender
{
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
 
    NSLog(@"replacementString %@", string);
    
//    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSMutableString *resaultString = [NSMutableString string];
    
    static const NSInteger localNumberMaxLenght = 7;
//    static const NSInteger areaCodeMaxLenght = 3;
//    static const NSInteger countryCodeMaxLenght = 3;
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLenght);
    
    if (localNumberLength > 0) {
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        [resaultString appendString:number];
        
        if ([resaultString length] > 1) {
            [resaultString insertString:@"," atIndex:1];
        }
    }
    
    textField.text = resaultString;
    
    return [newString length] <= 12;
}


#pragma mark - Configuration controller


- (void)configureController
{
    
    self.nsOnePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.ewOnePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.nsTwoPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.ewTwoPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.zonePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    
    self.lattitudeOneTextField.layer.borderColor = [BLUE_COLOR CGColor];
    self.longtittudeOneTextField.layer.borderColor = [BLUE_COLOR CGColor];
    self.lattitudeTwoTextField.layer.borderColor = [BLUE_COLOR CGColor];
    self.longtittudeTwoTextField.layer.borderColor = [BLUE_COLOR CGColor];
    
    
    self.dataSourceNS = @[@"N", @"S"];
    self.dataSourceEW = @[@"E", @"W"];
    self.dataSourceZone = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
}


#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return self.dataSourceNS.count;
            break;
        case 2:
            return self.dataSourceEW.count;
            break;
        case 3:
            return self.dataSourceNS.count;
            break;
        case 4:
            return self.dataSourceEW.count;
            break;
        case 5:
            return self.dataSourceZone.count;
            break;
        default:
            return 0;
            break;
    }
    
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (thePickerView.tag) {
        case 1:
            return [self.dataSourceNS objectAtIndex:row];
            break;
        case 2:
            return [self.dataSourceEW objectAtIndex:row];
            break;
        case 3:
            return [self.dataSourceNS objectAtIndex:row];
            break;
        case 4:
            return [self.dataSourceEW objectAtIndex:row];
            break;
        case 5:
            return [self.dataSourceZone objectAtIndex:row];
            break;
        default:
            return 0;
            break;
    }
}



#pragma mark - UIPickerViewDelegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - Navigation



@end
