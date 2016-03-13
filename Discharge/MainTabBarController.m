//
//  MainTabBarController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "MainTabBarController.h"
#import "NavController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavController *communication = [[UIStoryboard storyboardWithName:@"Communication" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([NavController class])];
    NavController *medication = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([NavController class])];
    NavController *info = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([NavController class])];
    NavController *question = [[UIStoryboard storyboardWithName:@"Question" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([NavController class])];
    // Do any additional setup after loading the view.
    self.viewControllers = @[communication, medication, info, question];
    
    
    self.tabBar.tintColor = [UIColor whiteColor];
    

    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];
    
    
    

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
