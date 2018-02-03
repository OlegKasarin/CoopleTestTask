//
//  JobsViewController.m
//  CoopleTestTask
//
//  Created by apple on 1/31/18.
//  Copyright © 2018 OlegKasarin. All rights reserved.
//

#import "JobsViewController.h"
#import "JobItemCell.h"

#import "JobsInfoDataSource.h"

@interface JobsViewController ()
@property (nonatomic) JobsInfoDataSource<JobItemsDataSource>* dataSource;
@property (nonatomic) NSArray<JobModel*>* jobs;
@property (nonatomic) UIActivityIndicatorView* spinner;
@end

@implementation JobsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUserInterface];
    
    self.dataSource = [[JobsInfoDataSource alloc] init];
    
    [self fetchJobsInfo];
    [self.spinner startAnimating];
}

- (void)setupUserInterface {
    [self.tableView registerClass:[JobItemCell class]
           forCellReuseIdentifier:@"JobItemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JobItemCell" bundle:nil]
         forCellReuseIdentifier:@"JobItemCell"];
    
    [self.navigationItem setTitle:@"Jobs info"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    //Set activity indicator
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.spinner setCenter:self.view.center];
    [self.tableView addSubview:self.spinner];
}

- (void)refresh {
    [self.spinner startAnimating];
    [self fetchJobsInfo];
}

- (void)fetchJobsInfo {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.dataSource getJobsWithCompletion:^(NSArray<JobModel *> *jobsArray) {
            [self.spinner stopAnimating];
            
            strongSelf.jobs = jobsArray;
            [strongSelf.tableView reloadData];
        }];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.jobs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobItemCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JobItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobItemCell"];
    }
    
    [cell configureWithData:[self.jobs objectAtIndex:indexPath.row]];
    return cell;
}

@end
