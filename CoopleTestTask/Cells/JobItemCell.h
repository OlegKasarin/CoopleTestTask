//
//  JobItemCell.h
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JobModel;

@interface JobItemCell : UITableViewCell
- (void)configureWithData:(JobModel*)model;
@end
