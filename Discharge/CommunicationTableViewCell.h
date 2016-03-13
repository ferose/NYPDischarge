//
//  CommunicationTableViewCell.h
//  Discharge
//
//  Created by Shena Yoshida on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunicationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *labelDate;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelTime;
@property (strong, nonatomic) IBOutlet UILabel *labelTreatment;

@end
 