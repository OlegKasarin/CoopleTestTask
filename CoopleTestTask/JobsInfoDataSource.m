//
//  JobsInfoDataSource.m
//  CoopleTestTask
//
//  Created by apple on 2/2/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "JobsInfoDataSource.h"

#import "DataLoader.h"
#import "DataParser.h"

// https://www.coople.com/resources/api/work-assignments/public-jobs/list?pageNum=0&pageSize=200
static NSString* const baseURL = @"https://www.coople.com/resources/api/";
static NSString* const workAssignmentsURL = @"work-assignments/public-jobs/list?pageNum=0&pageSize=200";

static NSString* const jobsInfoKey = @"jobsInfoKey";

@interface JobsInfoDataSource ()
@property (nonatomic) DataLoader* dataLoader;
@property (nonatomic) NSCache* cache;
@end

@implementation JobsInfoDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _cache = [[NSCache alloc] init];
    }
    return self;
}

- (void)getJobsWithCompletion:(void (^)(NSArray<JobModel*> *))completion {
    NSURL* url = [NSURL URLWithString:baseURL];
    self.dataLoader = [[DataLoader alloc] initWithBaseURL:url];
    
    NSURL* requestURL = [NSURL URLWithString:workAssignmentsURL
                               relativeToURL:url];
    [self.dataLoader downloadDataWithRequestURL:requestURL
                                   completetion:^(id response, NSError *error) {
        NSNumber* statusCode = response[@"status"];
        if ([statusCode integerValue] == 200) {
            NSDictionary* data = response[@"data"];
            
            DataParser* parser = [[DataParser alloc] init];
            NSArray* parsedArray = [parser parseData:data];
            
            //Save parsed array
            [self saveCacheWithArray:parsedArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(parsedArray);
            });
        } else {            
            //Use cache if exists
            NSArray* array = [self fetchCache];
            if (array != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(array);
                });
                return;
            }
        }
    }];
}

#pragma mark - Cache

- (void)saveCacheWithArray:(NSArray*)array {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* dataSave = [NSKeyedArchiver archivedDataWithRootObject:array];
    [userDefaults setObject:dataSave forKey:jobsInfoKey];
    [userDefaults synchronize];
}

- (nullable NSArray*)fetchCache {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSData* data = [userDefaults objectForKey:jobsInfoKey];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}

@end

     
