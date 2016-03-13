//
//  ContactTableViewCell.m
//  Discharge
//
//  Created by Shena Yoshida on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
// add border:
//    [self.buttonCall.layer setBorderWidth:2.0f];
//    [self.buttonCall.layer setBorderColor:[UIColor blackColor].CGColor];
    
// round slightly:
 self.buttonCall.layer.cornerRadius = 4.0f;
    self.buttonEmail.layer.cornerRadius = 4.0f;
    self.buttonSearch.layer.cornerRadius = 4.0f;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
