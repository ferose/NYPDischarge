//
//  LoginViewController.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "LoginViewController.h"
#import "UIView+LayoutExtension.h"

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

@end
