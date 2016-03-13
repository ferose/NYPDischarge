//
//  Networking.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "Networking.h"
#import "AFHTTPSessionManager.h"
#import "User.h"

@interface Networking()

@property (nonatomic) AFHTTPSessionManager *manager;

@end

@implementation Networking

+(instancetype)shared
{
    static Networking *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.manager = [[AFHTTPSessionManager alloc] init];
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

-(void)queryResource:(NSString *)resource
          withParams:(NSDictionary *)params
             success:(void (^)(NSDictionary *))success
             failure:(void (^)(NSError *))failure
{
    if (!params) {
        params = @{};
    }
    NSMutableDictionary *mutableParams = [params mutableCopy];
    if ([[User currentUser] identification]) {
        mutableParams[@"patient"] = [[User currentUser] identification];
    }
    [self.manager GET:[NSString stringWithFormat:@"https://navhealth.herokuapp.com/api/fhir/%@", resource] parameters:mutableParams progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)queryPillName:(NSString *)pillName
             success:(void (^)(NSDictionary *result))success
             failure:(void (^)(NSError *error))failure
{
    pillName = [pillName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    [self.manager GET:@"https://rximage.nlm.nih.gov/api/rximage/1/rxnav" parameters:@{@"name": pillName} progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)imageURLForPillName:(NSString *)pillName
                completion:(void (^)(NSURL *imageURL))completion
{
    [self queryPillName:pillName success:^(NSDictionary *result) {
        NSString *urlString = [result[@"nlmRxImages"] firstObject][@"imageUrl"];
        NSURL *imageURL = [NSURL URLWithString:urlString];
        completion(imageURL);
    } failure:^(NSError *error) {
        completion(nil);
    }];
}
@end
