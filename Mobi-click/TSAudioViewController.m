//
//  TSAudioViewController.m
//  Mobi-click
//
//  Created by Mac on 07.10.16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "TSAudioViewController.h"
#import "TSTableViewCell.h"
#import "TSPrefixHeader.pch"

@interface TSAudioViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *loudspeackerPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *microphonePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ringtonesPickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TSAudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.loudspeackerPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.microphonePickerView.layer.borderColor = [BLUE_COLOR CGColor];
    self.ringtonesPickerView.layer.borderColor = [BLUE_COLOR CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Rington %ld", indexPath.row + 1];
    cell.textLabel.font = [UIFont fontWithName:@"System Bold" size:17];
    
    return  cell;
    
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
