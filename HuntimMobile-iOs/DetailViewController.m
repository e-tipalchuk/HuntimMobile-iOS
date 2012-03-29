//
//  DetailViewController.m
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "MBProgressHUD.h"
@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize currentJob = _currentJob;

@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize companyTitle = _companyTitle;
@synthesize companyDescription = _companyDescription;
@synthesize companyImage = _companyImage;
@synthesize requirementsBlock = _requirementsBlock;
@synthesize jobTitle = _jobTitle;
@synthesize publishedDate = _publishedDate;
@synthesize occupationLabel = _occupationLabel;
@synthesize cityLabel = _cityLabel;
@synthesize categoryLabel = _categoryLabel;


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

-(void)clearData{
    [self.jobTitle setText:nil];
    [self.companyTitle setText:nil];
    [self.publishedDate setText:nil];
    [self.companyDescription setText:nil];
    [self.occupationLabel setText:nil];
    [self.cityLabel setText:nil];
    [self.requirementsBlock loadHTMLString:nil baseURL:NULL];
    [self.categoryLabel setText:nil];
}
-(void)loadData{
    [self.jobTitle setText:[self.currentJob title]];
    [self.companyTitle setText:[self.currentJob company_name]];
    [self.publishedDate setText:[self.currentJob published_date]];
    [self.companyDescription setText:[self.currentJob company_description]];
    [self.occupationLabel setText:[self.currentJob occupation]];
    [self.cityLabel setText:[self.currentJob location]];
    [self.requirementsBlock loadHTMLString:[self.currentJob requirements] baseURL:NULL];
    
    [self.categoryLabel setText:[self.currentJob category]];
}

-(void)hudWasHidden:(MBProgressHUD *)hud{
    [self loadData];
}
- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [self setCompanyTitle:nil];
    [self setPublishedDate:nil];
    [self setOccupationLabel:nil];
    [self setCityLabel:nil];
    [self setCategoryLabel:nil];
    [self setCompanyTitle:nil];
    [self setCompanyDescription:nil];
    [self setCompanyImage:nil];
    [self setRequirementsBlock:nil];
    [self setJobTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self clearData];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [hud showWhileExecuting:@selector(parseData) onTarget:[self currentJob] withObject:nil animated:YES];
    [self.view addSubview:hud];
    [hud setDelegate:self];
    [self setTitle:[self.currentJob title]];
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

@end
