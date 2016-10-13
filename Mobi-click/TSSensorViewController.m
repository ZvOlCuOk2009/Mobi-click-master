//
//  TSSensorViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSensorViewController.h"
#import "TSMeinViewController.h"
#import "TSPrefixHeader.pch"

NSString *const ValuesPickerViewNotification = @"ValuesPickerViewNotification";

@interface TSSensorViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewMove;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewVoice;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewVibra;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vibraLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) NSUserDefaults *userDefaults;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation TSSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureController];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLauguage];
    [self setSettingsPickerView];
}


- (void)configureController
{
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.dataSource = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    self.pickerViewMove.layer.borderColor = [BLUE_COLOR CGColor];
    self.pickerViewVoice.layer.borderColor = [BLUE_COLOR CGColor];
    self.pickerViewVibra.layer.borderColor = [BLUE_COLOR CGColor];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [titleImageView setFrame:CGRectMake(0, 0, 250, 44)];
    self.navigationItem.titleView = titleImageView;
}


#pragma mark - Action


- (IBAction)actionSendButton:(id)sender
{
    NSString *valuePickerViewMove = [self pickerView:self.pickerViewMove
                           titleForRow:[self.pickerViewMove selectedRowInComponent:0] forComponent:0];
    
    NSString *valuePickerViewVoice = [self pickerView:self.pickerViewVoice
                              titleForRow:[self.pickerViewVoice selectedRowInComponent:0] forComponent:0];
    
    NSString *valuePickerViewVibra = [self pickerView:self.pickerViewVibra
                              titleForRow:[self.pickerViewVibra selectedRowInComponent:0] forComponent:0];

    NSLog(@"%@ %@ %@", valuePickerViewMove, valuePickerViewVoice, valuePickerViewVibra);
    
    NSDictionary *valuesPickerView = @{@"valueMove":valuePickerViewMove,
                                       @"valueVoice":valuePickerViewVoice,
                                       @"valueVibra":valuePickerViewVibra};
    
    NSInteger movie = [valuePickerViewMove integerValue];
    NSInteger voice = [valuePickerViewVoice integerValue];
    NSInteger vibra = [valuePickerViewVibra integerValue];
    
    
    [self.userDefaults setInteger:movie forKey:@"valueMove"];
    [self.userDefaults setInteger:voice forKey:@"valueVoice"];
    [self.userDefaults setInteger:vibra forKey:@"valueVibra"];
    [self.userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ValuesPickerViewNotification object:valuesPickerView];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)setSettingsPickerView
{
    NSInteger valueMovePC = [self.userDefaults integerForKey:@"valueMove"] - 1;
    NSInteger valueVoicePC = [self.userDefaults integerForKey:@"valueVoice"] - 1;
    NSInteger valueVibraPC = [self.userDefaults integerForKey:@"valueVibra"] - 1;
    
    [self.pickerViewMove selectRow:valueMovePC inComponent:0 animated:NO];
    [self.pickerViewVoice selectRow:valueVoicePC inComponent:0 animated:NO];
    [self.pickerViewVibra selectRow:valueVibraPC inComponent:0 animated:NO];
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
    return [self.dataSource objectAtIndex:row];
}


#pragma mark - UIPickerViewDelegate


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - methods set launguage


- (void)setLauguage
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    
    if ([language isEqualToString:@"English"]) {
        
        [self setEngleshLaunguage];
        
    } else if ([language isEqualToString:@"German"]) {
        
        [self setGermanLaunguage];
    }
}


- (void)setEngleshLaunguage
{
    [self.titleLabel setText:@"Sensors programming"];
    [self.moveLabel setText:@"Move"];
    [self.voiceLabel setText:@"Voice"];
    [self.vibraLabel setText:@"Vibra"];
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.titleLabel setText:@"Programmierung der Sensoren"];
    [self.moveLabel setText:@"Bewegung"];
    [self.voiceLabel setText:@"Stimme"];
    [self.vibraLabel setText:@"Vibra"];
    [self.sendButton setTitle:@"SENDEN" forState:UIControlStateNormal];
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
