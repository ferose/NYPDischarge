//
//  User.h
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(instancetype)currentUser;

-(BOOL)isLoggedIn;

@end
