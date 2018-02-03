//
//  DataLoader.m
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "DataLoader.h"
#import <AFNetworking.h>


@interface DataLoader ()
@property (nonatomic) AFHTTPSessionManager* sessionManager;
@end

@implementation DataLoader

- (DataLoader*)initWithBaseURL:(NSURL*)url {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url
                                                   sessionConfiguration:configuration];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

//TODO: -pageNum and -pageSize params
- (void)downloadDataWithRequestURL:(NSURL*)url completetion:(CompletionBlock)completion {
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(nil, error);
        } else {
            NSLog(@"%@\n%@", response, responseObject);
            completion(responseObject, nil);
        }
    }];
    [dataTask resume];
}

@end
