//
//  ContactNumbersViewController.m
//  Discharge
//
//  Created by Jamaal Sedayao on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "ContactNumbersViewController.h"

@interface ContactNumbersViewController ()


@end

@implementation ContactNumbersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Important Contact Numbers";
    
}

- (IBAction)callMilstein:(UIButton *)sender { //All hospital locations, not just Milstein
    
    //Milstein
    if ([sender tag] == 1){ //mainTelephone
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123052500"]];
    } else if ([sender tag] == 2){  //socialWork
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123052553"]];
    } else if ([sender tag] == 3){ //patient services
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123055904"]];
    } else if ([sender tag] == 4){ //Food&Nutrition
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123059094"]];
        
    //Allen Pavilion
    }  else if ([sender tag] == 5){ //Main
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2129324000"]];
    }  else if ([sender tag] == 6){ //Social Work
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2129324255"]];
    }  else if ([sender tag] == 7){ //patient services
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2129324321"]];
    }  else if ([sender tag] == 8){ //Food&Nutrition
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2129325180"]];
        
    //MSCHONY
    }  else if ([sender tag] == 9){ //Main
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123052500"]];
    }  else if ([sender tag] == 10){ //SocialWork
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123051753"]];
    }  else if ([sender tag] == 11){ //Patient Services
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123055904"]];
    }  else if ([sender tag] == 12){ //Food&Nutrition
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2123054901"]];
    }
    
}




@end
