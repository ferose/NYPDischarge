//
//  LoginViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic) UIViewController *root;

@end

@implementation LoginViewController

+ (void)launchLogin
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *root = window.rootViewController;
    
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    vc.root = root;
    
    window.rootViewController = vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)didTapStart:(id)sender {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    window.rootViewController = self.root;
    
    
}

@end
