//
//  Jobs.m
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Jobs.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "Job.h"
#import "Constants.h"
@implementation Jobs

@synthesize items = _items;
@synthesize page;

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}



-(void)getItemsWithPage: (int) currentPage {
    NSString *page_string = [NSString stringWithFormat:@"?page=%d",currentPage];
    NSLog(@"%@",page_string);
    NSURL *api_url = [[NSURL alloc] initWithString:[API_URL_STRING stringByAppendingString:page_string]]; 
    NSLog(@"%@",[api_url description]);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:api_url];
    
    [request startSynchronous];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSLog(@"%@",[request responseString]);
    NSDictionary *responseDict = [parser objectWithString:[request responseString]];
    NSLog(@"%@",[responseDict description]);
    NSArray *jobs = [responseDict objectForKey:@"jobs"];
    for(NSDictionary *j in jobs) {
        Job *job = [[Job alloc] init];
        [job setCompany_name:[j objectForKey:@"company"]];
        [job setTitle:[j objectForKey:@"title"]];
        [job setPublished:[j objectForKey:@"published"]];
        [job setUrl:[j objectForKey:@"url"]];
        [job setOccupation:[j objectForKey:@"occupation"]];
        [job setIconUrl: [j objectForKey:@"icon"]];
        [job setLocation: [j objectForKey:@"location"]];
        [self.items addObject:job];
    }
}
@end
