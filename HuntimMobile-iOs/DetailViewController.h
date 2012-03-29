//
//  DetailViewController.h
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"
#import "MBProgressHUD.h"
@interface DetailViewController : UIViewController <MBProgressHUDDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Job *currentJob;
@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyTitle;
@property (weak, nonatomic) IBOutlet UILabel *publishedDate;
@property (weak, nonatomic) IBOutlet UILabel *occupationLabel;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITextView *companyDescription;
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UIWebView *requirementsBlock;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
-(void)loadData;
-(void)clearData;
@end
