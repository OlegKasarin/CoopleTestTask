//
//  JobsInfoDataSource.h
//  CoopleTestTask
//
//  Created by apple on 2/2/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JobModel;

@protocol JobItemsDataSource <NSObject>
- (void)getJobsWithCompletion:(void (^)(NSArray<JobModel*>*))completion;
@end


@interface JobsInfoDataSource : NSObject <JobItemsDataSource>

@end




