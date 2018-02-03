//
//  JobModel.h
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobModel : NSObject <NSCoding>
@property (copy, nonatomic) NSString* workAssignmentName;
@property (copy, nonatomic) NSString* addressStreet;
@property (copy, nonatomic) NSString* zip;
@property (copy, nonatomic) NSString* city;

+ (JobModel*)modelWithJSON:(NSDictionary*)jobsJSON;

@end
