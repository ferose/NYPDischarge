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
#import <RSBarcodes/RSBarcodes.h>
#import "Networking.h"
#import "User.h"
#import "ClusterPrePermissions.h"

@interface LoginViewController ()<UIScrollViewDelegate>

@property (nonatomic) UIViewController *root;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic) NSMutableArray<UIViewController *> *introVCs;
@property (nonatomic) BOOL transitioning;

@end

@implementation LoginViewController

+ (void)launchLogin
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *root = window.rootViewController;
    
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Intro" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    vc.root = root;
    
    window.rootViewController = vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    NSMutableArray<UIViewController *> *introVCs = [NSMutableArray new];
    
    int numSlides = 4;

    for (int i = 0; i < numSlides; i++)
    {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Intro" bundle:nil] instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"Slide%@", @(i)]];
        [vc viewDidLoad];
        
        if (i == numSlides-1) {
            RSScannerViewController *scannerVC = (RSScannerViewController *)vc;
            scannerVC.stopOnFirst = NO;
            [scannerVC setBarcodesHandler:^(NSArray *barcodeObjects) {
                NSString *result = [[barcodeObjects firstObject] stringValue];
                [self attemptLogin:result];
            }];
        }
        
        vc.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        
        [introVCs addObject:vc];
    }
    
    self.pageControl.numberOfPages = introVCs.count;
    self.introVCs = introVCs;
    
    
    for (int i = 0; i < self.introVCs.count; i++)
    {
        UIViewController *vc = introVCs[i];
        
        // X
        [vc.view addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[itemView(%@)]", @(self.view.width)]
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil
                                 views:@{@"itemView":vc.view}]];
        if (i == 0)
        {
            [self.scrollView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"H:|[itemView]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                             views:@{@"itemView":vc.view}]];
        }
        else
        {
            UIViewController *prevVC = introVCs[i-1];
            [self.scrollView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"H:[prevItemView][itemView]"
                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                             metrics:nil
                                             views:@{@"itemView":vc.view,@"prevItemView":prevVC.view}]];
        }
        
        // Y
        [vc.view addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[itemView(%@)]", @(self.view.height)]
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil
                                 views:@{@"itemView":vc.view}]];
        [self.scrollView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:@"V:|[itemView]"
                                         options:NSLayoutFormatDirectionLeadingToTrailing
                                         metrics:nil
                                         views:@{@"itemView":vc.view}]];
    }
    
    [self.scrollView setContentSize:CGSizeMake(self.view.width*self.introVCs.count, self.view.height)];
}


- (NSInteger) currentPage
{
    CGFloat currentX = self.scrollView.contentOffset.x+self.view.width/2;
    CGFloat currentPage = (currentX/self.view.width);
    if (currentPage < 0)
        currentPage = 0;
    if (currentPage >= self.introVCs.count)
        currentPage = self.introVCs.count-1;
    return currentPage;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = [self currentPage];
    self.pageControl.currentPage = currentPage;
    
#if TARGET_IPHONE_SIMULATOR
    if (currentPage == self.introVCs.count-1) {
        [self attemptLogin:@"56cb4093b5d8bf3b55f5a220"];
    }
#endif
}

- (void)transitionToMainView
{
    if (self.transitioning) {
        return;
    }
    self.transitioning = YES;
    
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
        
        [self askPushNotifs];
    }];
}

- (void)askPushNotifs
{
    ClusterPrePermissions *permissions = [ClusterPrePermissions sharedPermissions];
    [permissions showPushNotificationPermissionsWithType:ClusterPushNotificationTypeBadge|ClusterPushNotificationTypeSound|ClusterPushNotificationTypeAlert
                                                   title:@"Pill Notifications" message:@"Would you like to be notified when it's time to take your pills?" denyButtonTitle:@"NO" grantButtonTitle:@"YES" completionHandler:^(BOOL hasPermission, ClusterDialogResult userDialogResult, ClusterDialogResult systemDialogResult) {
                                                       
                                                   }];
}

- (void)attemptLogin:(NSString *)loginID
{
    if (!loginID.length) {
        return;
    }
    [[Networking shared] queryResource:@"Patient" withParams:@{@"id": loginID} success:^(NSDictionary *result) {
        if([[result objectForKey:@"entry"] count] > 0 || true){
            [[User currentUser] setIdentification:loginID];
            [self transitionToMainView];
        }
        else{
//            self.alertTextLabel.text= @"That identification number is incorrect";
        }
        
    } failure:^(NSError *error) {
//        self.alertTextLabel.text= @"That identification number is incorrect";
    }];
}


@end
