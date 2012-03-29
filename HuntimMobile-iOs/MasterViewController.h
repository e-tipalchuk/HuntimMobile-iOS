//
//  MasterViewController.h
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jobs.h"
#import "Job.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property int *page;
@property (strong, nonatomic) DetailViewController *detailViewController;

-(void)setJobDataAtIndex:(int) index andCell:(UITableViewCell *) cell;
@end
