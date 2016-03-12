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

@interface LoginViewController ()

@property (nonatomic) UIViewController *root;
@property (weak, nonatomic) IBOutlet UITextField *identificationTextField;
@property (weak, nonatomic) IBOutlet UILabel *alertTextLabel;
@property (nonatomic) AFHTTPSessionManager *manager;
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
    // Do any additional setup after loading the view from its nib.
    self.manager = [[AFHTTPSessionManager alloc] init];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];    
    self.defaults = [NSUserDefaults standardUserDefaults];
    


    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapStart:(id)sender {
    
    NSString * url = [[NSString stringWithFormat:@"https://navhealth.herokuapp.com/api/fhir/Patient?id=%@", self.identificationTextField.text] stringByAddingPercentEscapesUsingEncoding:
                      NSASCIIStringEncoding];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        
        if([[json objectForKey:@"entry"] count] > 0){
            [self.defaults setObject:self.identificationTextField.text forKey:@"id"];
            
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
        else{
            self.alertTextLabel.text= @"That identification number is incorrect";
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        
    }];

    

}

@end
