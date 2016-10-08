//
//  TSSOSViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSSOSViewController.h"
#import "TSPrefixHeader.pch"

@interface TSSOSViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldOutletCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *checkerOutletCollection;
@property (assign, nonatomic) NSInteger counter;

@end

@implementation TSSOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    for (UITextField *textField in self.textFieldOutletCollection)
    {
        textField.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    
    for (UIButton *button in self.checkerOutletCollection)
    {
        button.layer.borderColor = [BLUE_COLOR CGColor];
    }
    
    self.counter = 0;
    
}


- (IBAction)actionCheckerOne:(UIButton *)sender
{
    
    UIButton *button = [self.checkerOutletCollection objectAtIndex:0];
    
    
    if (self.counter == 0) {
        UIImage * clickImage = [UIImage imageNamed:@"click"];
        [button setImage:clickImage forState:UIControlStateNormal];
        self.counter = 1;
    } else if (self.counter == 1) {
        UIImage * noclickImage = [UIImage imageNamed:@"noclick"];
        [button setImage:noclickImage forState:UIControlStateNormal];
        self.counter = 0;
    }
    
}


- (IBAction)actionCheckerTwo:(id)sender
{
    
    UIButton *button = [self.checkerOutletCollection objectAtIndex:1];
    
    
    if (self.counter == 0) {
        UIImage * clickImage = [UIImage imageNamed:@"click"];
        [button setImage:clickImage forState:UIControlStateNormal];
        self.counter = 1;
    } else if (self.counter == 1) {
        UIImage * noclickImage = [UIImage imageNamed:@"noclick"];
        [button setImage:noclickImage forState:UIControlStateNormal];
        self.counter = 0;
    }
}


- (IBAction)actionSendButton:(id)sender
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    TSMeinViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TSMeinViewController"];
    [window setRootViewController:controller];
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
