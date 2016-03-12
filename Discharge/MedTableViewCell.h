//
//  MedTableViewCell.h
//  Discharge
//
//  Created by Henna Ahmed on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *dosage;
@property (weak, nonatomic) IBOutlet UILabel *frequency;

@end
