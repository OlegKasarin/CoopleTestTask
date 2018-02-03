//
//  DataParser.m
//  CoopleTestTask
//
//  Created by apple on 2/2/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "DataParser.h"
#import "JobModel.h"

@implementation DataParser
- (NSArray*)parseData:(NSDictionary*)dict {
    NSMutableArray<JobModel*>* models = [[NSMutableArray alloc] init];
    
    NSArray* array = dict[@"items"];
    for (NSDictionary* dict in array) {
        JobModel* model = [JobModel modelWithJSON:dict];
        [models addObject:model];
    }
    return [models copy];
}
@end
