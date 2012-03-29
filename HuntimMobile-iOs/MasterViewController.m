//
//  MasterViewController.m
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Jobs.h"
#import "Job.h"


#import "DetailViewController.h"
@interface MasterViewController()
@property (nonatomic, strong) Jobs *jobs;

@end


@implementation MasterViewController
@synthesize page;

@synthesize jobs = _jobs;

- (Jobs *)jobs {
    if (!_jobs) {
        _jobs = [[Jobs alloc] init];
    }
    return _jobs;
}


@synthesize tableView;
@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    page = 0;
    [self setTitle:@"Последние вакансии"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jobs.items count] + 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobCell";
    static NSString *loadingCellIdentifier = @"loadingCell";

    UITableViewCell *cell;
    if ([self.jobs.items count] == indexPath.row)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
        if (!cell) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:loadingCellIdentifier owner:self options:nil];
            cell = [nibs objectAtIndex:0];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:cell animated:YES];
            hud.xOffset = -20;
        } 
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.jobs getItemsWithPage:page++]; 
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData]; 
            });
        });
        
    }
    else{
        cell = [[[NSBundle mainBundle]loadNibNamed:@"jobCell" owner: self options:nil] objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }  
        UILabel *occupation = (UILabel *)[cell viewWithTag:1];
        occupation.layer.cornerRadius = 5;
        if (self.jobs.items.count > 0){
            [self setJobDataAtIndex:indexPath.row andCell:cell];
        }
    }
    
      
    return cell;
}

-(void)setJobDataAtIndex:(int)index andCell:(UITableViewCell *)cell{
    Job *job = (Job *)[self.jobs.items objectAtIndex:index];
    // заголовок вакансии
    UILabel *jobTitle = (UILabel *)[cell viewWithTag:4];
    [jobTitle setText:[job title]];
    
    // Компания
    UILabel *companyTitle = (UILabel *)[cell viewWithTag:3];
    [companyTitle setText:[job company_name]];
    
    // Тип занятости
    UILabel *occupation = (UILabel *)[cell viewWithTag:1];
    [occupation setText:[job OccupationInRussian]];
    if ([[job occupation] isEqualToString:@"contract"]){
        occupation.backgroundColor  = [UIColor colorWithRed:0.424 green:0.694 blue:0.396 alpha:1];
    }
    if ([[job occupation] isEqualToString:@"freelance"]){
        occupation.backgroundColor  = [UIColor colorWithRed:0.51 green:0.796 blue:0.925 alpha:1];
    }
    if ([[job occupation] isEqualToString:@"fulltime"]){
        occupation.backgroundColor  = [UIColor colorWithRed:0.929 green:0.533 blue:0.271 alpha:1];
    }
    occupation.layer.cornerRadius = 5;
    
    // Тип занятости
    UILabel *published = (UILabel *)[cell viewWithTag:2];
    [published setText:[job published]];
    
    // Тип занятости
    UILabel *city = (UILabel *)[cell viewWithTag:5];
    [city setText:[job location]];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    Job *job = (Job *)[self.jobs.items objectAtIndex:indexPath.row];
    [self.detailViewController setCurrentJob:job];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
