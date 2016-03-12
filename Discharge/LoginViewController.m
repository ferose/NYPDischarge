//
//  LoginViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+LayoutExtension.h"
#import <AFNetworking/AFNetworking.h>
#import "Networking.h"
#import "User.h"

@interface LoginViewController ()

@property (nonatomic) UIViewController *root;
@property (weak, nonatomic) IBOutlet UITextField *identificationTextField;
@property (weak, nonatomic) IBOutlet UILabel *alertTextLabel;


@property (nonatomic) NSUserDefaults *defaults;

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
    self.defaults = [NSUserDefaults standardUserDefaults];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)transitionToMainView
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    UIView *introSnapshot = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
    window.rootViewController = self.root;
    
    UIView *homeSnapshot = [self.root.view snapshotViewAfterScreenUpdates:YES];
    UIView *blackView = [[UIView alloc] initWithFrame:homeSnapshot.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    
    
    [self.root.view addSubview:blackView];
    [self.root.view addSubview:homeSnapshot];
    [self.root.view addSubview:introSnapshot];
    
    introSnapshot.layer.shadowColor = [UIColor blackColor].CGColor;
    introSnapshot.layer.shadowOffset = CGSizeMake(0, 0);
    introSnapshot.layer.shadowOpacity = 0.5;
    introSnapshot.layer.shadowRadius = 10.0;
    
    CGFloat margin = 20;
    homeSnapshot.alpha = 0;
    homeSnapshot.frame = CGRectMake(margin, margin, homeSnapshot.width-2*margin, homeSnapshot.height-margin);
    
    [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        introSnapshot.y += introSnapshot.height;
        homeSnapshot.frame = blackView.bounds;
        homeSnapshot.alpha = 1;
    } completion:^(BOOL finished) {
        [introSnapshot removeFromSuperview];
        [blackView removeFromSuperview];
        [homeSnapshot removeFromSuperview];
    }];
}

- (IBAction)didTapStart:(id)sender {

    [[Networking shared] queryResource:@"Patient" withParams:@{@"id": self.identificationTextField.text} success:^(NSDictionary *result) {
        if([[result objectForKey:@"entry"] count] > 0){
            [[User currentUser] setIdentification:self.identificationTextField.text];
            [self transitionToMainView];
        }
        else{
            self.alertTextLabel.text= @"That identification number is incorrect";
        }
    } failure:^(NSError *error) {
        self.alertTextLabel.text= @"That identification number is incorrect";
    }];

}

@end
