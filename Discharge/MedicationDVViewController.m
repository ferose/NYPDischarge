//
//  MedicationDVViewController.m
//  Discharge
//
//  Created by Henna Ahmed on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "MedicationDVViewController.h"
#import "Networking.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MedicationDVViewController ()
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *dosage;
@property (weak, nonatomic) IBOutlet UILabel *frequency;
@property (weak, nonatomic) IBOutlet UITextView *instruction;
@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic) IBOutlet UITextView *cause;
@end


@implementation MedicationDVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drugName.text = self.medication.name;
    self.dosage.text = self.medication.dosage;
    self.frequency.text = self.medication.frequency;
    self.cause.text = self.medication.cause;
    self.instruction.text = self.medication.instructions;
    
    [self makeImageAPICall:self.medication.name];
    
    
    // Do any additional setup after loading the view.
}

- (void)makeImageAPICall:(NSString*)imageName{
    imageName = [imageName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [[Networking shared] queryPillName:imageName success:^(NSDictionary *response) {
        
        NSString *urlString = [response[@"nlmRxImages"] firstObject][@"imageUrl"];
        
        NSURL *imageURL = [NSURL URLWithString:urlString];
        
        [self.drugImage sd_setImageWithURL:imageURL];
        
    } failure:^(NSError *error) {
        
    }];
    
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
