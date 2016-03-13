//
//  Networking.h
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

+(instancetype)shared;

-(void)queryResource:(NSString *)resource
          withParams:(NSDictionary *)params
             success:(void (^)(NSDictionary *result))success
             failure:(void (^)(NSError *error))failure;

-(void)queryPillName:(NSString *)pillName
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *))failure;
@end
