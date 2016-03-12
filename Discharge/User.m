//
//  User.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)currentUser
{
    static User *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

@end
