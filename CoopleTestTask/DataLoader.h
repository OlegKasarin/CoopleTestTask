//
//  DataLoader.h
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(id response, NSError* error);

@interface DataLoader : NSObject
- (DataLoader*)initWithBaseURL:(NSURL*)url;
- (void)downloadDataWithRequestURL:(NSURL*)url completetion:(CompletionBlock)completion;
@end
