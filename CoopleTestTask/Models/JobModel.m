//
//  JobModel.m
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "JobModel.h"

@implementation JobModel

+ (JobModel*)modelWithJSON:(NSDictionary*)jobsJSON {
    JobModel* model = [[JobModel alloc] init];
    
    if (jobsJSON[@"workAssignmentName"]) {
        model.workAssignmentName = jobsJSON[@"workAssignmentName"];
    }
    if (jobsJSON[@"jobLocation"]) {
        NSDictionary* location = jobsJSON[@"jobLocation"];
        if (location[@"addressStreet"]) {
            model.addressStreet = location[@"addressStreet"];
        }
        if (location[@"zip"]) {
            model.zip = location[@"zip"];
        }
        if (location[@"city"]) {
            model.city = location[@"city"];
        }
    }
    return model;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Assignment name: %@\nAddress: %@\nZip: %@\nCity: %@", self.workAssignmentName, self.addressStreet, self.zip, self.city];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _workAssignmentName = [coder decodeObjectForKey:@"workAssignmentName"];
        _addressStreet = [coder decodeObjectForKey:@"addressStreet"];
        _zip = [coder decodeObjectForKey:@"zip"];
        _city = [coder decodeObjectForKey:@"city"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.workAssignmentName forKey:@"workAssignmentName"];
    [aCoder encodeObject:self.addressStreet forKey:@"addressStreet"];
    [aCoder encodeObject:self.zip forKey:@"zip"];
    [aCoder encodeObject:self.city forKey:@"city"];
}

@end
