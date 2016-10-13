//
//  TSSettingsViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSettingsViewController.h"
#import "TSLaunguageViewController.h"

@interface TSSettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *launguageButton;
@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *timeDataButton;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIButton *gpsButton;
@property (weak, nonatomic) IBOutlet UIButton *audioButton;
@property (weak, nonatomic) IBOutlet UIButton *holdAlarmButton;
@property (weak, nonatomic) IBOutlet UIButton *extraButton;

@end

@implementation TSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setLauguage];
}


- (void)setLauguage
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"language"];
    
    if ([language isEqualToString:@"English"]) {
        
        [self setEngleshLaunguage];
        
    } else if ([language isEqualToString:@"German"]) {
        
        [self setGermanLaunguage];
    }
}


#pragma mark - methods set launguage


- (void)setEngleshLaunguage
{
    [self.launguageButton setTitle:@"Launguage" forState:UIControlStateNormal];
    [self.nameButton setTitle:@"Name" forState:UIControlStateNormal];
    [self.timeDataButton setTitle:@"Time Date" forState:UIControlStateNormal];
    [self.statusButton setTitle:@"Status" forState:UIControlStateNormal];
    [self.gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
    [self.audioButton setTitle:@"Audio" forState:UIControlStateNormal];
    [self.holdAlarmButton setTitle:@"Holdalarm" forState:UIControlStateNormal];
    [self.extraButton setTitle:@"Extra" forState:UIControlStateNormal];
}


- (void)setGermanLaunguage
{
    [self.launguageButton setTitle:@"Sprache" forState:UIControlStateNormal];
    [self.nameButton setTitle:@"Geratenamen" forState:UIControlStateNormal];
    [self.timeDataButton setTitle:@"Uhrzeit und Datum" forState:UIControlStateNormal];
    [self.statusButton setTitle:@"Status" forState:UIControlStateNormal];
    [self.gpsButton setTitle:@"GPS" forState:UIControlStateNormal];
    [self.audioButton setTitle:@"Audio" forState:UIControlStateNormal];
    [self.holdAlarmButton setTitle:@"Holdalarm" forState:UIControlStateNormal];
    [self.extraButton setTitle:@"Extra" forState:UIControlStateNormal];
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
