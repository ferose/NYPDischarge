//
//  CommunicationTableViewCell.m
//  Discharge
//
//  Created by Shena Yoshida on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "CommunicationTableViewCell.h"

@implementation CommunicationTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageView.layer.cornerRadius = 4.0f;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
