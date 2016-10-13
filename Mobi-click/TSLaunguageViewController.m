//
//  TSLaunguageViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSLaunguageViewController.h"
#import "TSPrefixHeader.pch"

@interface TSLaunguageViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewLaunguage;

@property (weak, nonatomic) IBOutlet UILabel *launguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPinLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UITextField *textFieldOldPin;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPin;

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TSLaunguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = @[@"English", @"German"];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.pickerViewLaunguage.layer.borderColor = [BLUE_COLOR CGColor];
    self.textFieldOldPin.layer.borderColor = [BLUE_COLOR CGColor];
    self.textFieldNewPin.layer.borderColor = [BLUE_COLOR CGColor];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *launguage = [self.userDefaults objectForKey:@"language"];
    NSInteger row;
    if ([launguage isEqualToString:@"English"]) {
        row = 0;
    } else if ([launguage isEqualToString:@"German"]) {
        row = 1;
    }
    
    [self.pickerViewLaunguage selectRow:row inComponent:0 animated:NO];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}


#pragma mark - Actions


- (IBAction)actionSendButton:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *pin = [userDefaults objectForKey:@"pin"];
    
    if ([pin isEqualToString:self.textFieldOldPin.text]) {
        
        [userDefaults setObject:self.textFieldNewPin.text forKey:@"pin"];
        [userDefaults synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else {
        //alert
    }
    
}


#pragma mark - UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSource.count;
}


- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if (row == 0) {
        [self setEngleshLaunguage];
        [self.userDefaults setObject:@"English" forKey:@"language"];
        [self.userDefaults synchronize];
    } else {
        [self setGermanLaunguage];
        [self.userDefaults setObject:@"German" forKey:@"language"];
        [self.userDefaults synchronize];
    }
    
    return [self.dataSource objectAtIndex:row];
}


- (NSInteger)selectedRowInComponent:(NSInteger)component
{
    return component;
}


#pragma mark - UIPickerViewDelegate



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - methods set launguage


- (void)setEngleshLaunguage
{
    [self.launguageLabel setText:@"Language"];
    [self.oldPinLabel setText:@"Old PIN"];
    [self.pinLabel setText:@"New PIN"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.launguageLabel setText:@"Sprache"];
    [self.oldPinLabel setText:@"Alt PIN"];
    [self.pinLabel setText:@"Neu PIN"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
}


#pragma mark - Keyboard notification


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.view.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.view.frame.origin.y - kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}


- (void)keyboardDidHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
