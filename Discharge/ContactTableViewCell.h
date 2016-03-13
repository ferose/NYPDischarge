//
//  ContactTableViewCell.h
//  Discharge
//
//  Created by Shena Yoshida on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *buttonCall;
@property (weak, nonatomic) IBOutlet UIView *buttonEmail;
@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;

@end
