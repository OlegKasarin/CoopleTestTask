//
//  JobItemCell.m
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "JobItemCell.h"
#import "JobModel.h"

@interface JobItemCell ()
@property (weak, nonatomic) IBOutlet UILabel *workNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@end

@implementation JobItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)configureWithData:(JobModel*)model {
    self.workNameLabel.text = model.workAssignmentName;
    self.addressLabel.text = model.addressStreet;
    self.zipLabel.text = model.zip;
    self.cityLabel.text = model.city;
}

@end
