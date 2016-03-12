//
//  MedicationDVViewController.m
//  Discharge
//
//  Created by Henna Ahmed on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "MedicationDVViewController.h"

@interface MedicationDVViewController ()
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *dosage;
@property (weak, nonatomic) IBOutlet UILabel *frequency;

@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@end

@implementation MedicationDVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
