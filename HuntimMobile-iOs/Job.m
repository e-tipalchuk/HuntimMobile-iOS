//
//  Job.m
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Job.h"
#import "HTMLParser.h"
@implementation Job

@synthesize company_name = _company_name;
@synthesize occupation = _occupation;
@synthesize published = _published;
@synthesize url = _url;
@synthesize title = _title;
@synthesize iconUrl = _iconUrl;
@synthesize location = _location;

@synthesize category = _category;
@synthesize published_date = _published_date;
@synthesize company_description = _company_description;
@synthesize company_image_url = _company_image_url;
@synthesize company_url = _company_url;
@synthesize requirements = _requirements;

-(NSString *)OccupationInRussian{
        if ([[self occupation] isEqualToString:@"fulltime"])
            return @"Фуллтайм";
        if ([[self occupation] isEqualToString:@"freelance"])
            return @"Фриланс";
        if ([[self occupation] isEqualToString:@"contract"])
            return @"Контракт";
}
-(void)parseData{
    NSError *error = nil;
    NSURL *current_url = [[NSURL alloc] initWithString:self.url];
    HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:current_url error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return;    
    }
    
    HTMLNode *bodyNode = [parser body];
   
    // Категория
    NSArray *spanNodes = [bodyNode findChildTags:@"span"];
    for (HTMLNode *node in spanNodes) {
        if ( [[node getAttributeNamed:@"class"] isEqualToString:@"category"]) {
            [self setCategory:[node contents]];
        }
    }
    
    // Основные требования
    NSArray *divNodes = [bodyNode findChildTags:@"div"];
    for (HTMLNode *node in divNodes) {
        if ( [[node getAttributeNamed:@"class"] isEqualToString:@"requirements block"]) {
            [self setRequirements:[node rawContents]];
        }
    }
    
    // Дата
    divNodes = [bodyNode findChildTags:@"div"];
    for (HTMLNode *node in divNodes) {
        if ( [[node getAttributeNamed:@"class"] isEqualToString:@"published"]) {
             NSLog(@"%@",[node contents]);
            [self setPublished_date:[node contents]];
        }
    }
   
    // Изображение и описание компании
    divNodes = [bodyNode findChildTags:@"div"];
    for (HTMLNode *node in divNodes) 
    {
        if ( [[node getAttributeNamed:@"class"] isEqualToString:@"company block"]) 
        {
            // находим изображение
            HTMLNode *imgNode = [node findChildTag:@"img"];
            [self setCompany_image_url:[imgNode getAttributeNamed:@"src"]];
            
            // находим описание компании
            NSArray *descriptionNodes = [node findChildTags:@"div"];
            for(HTMLNode *divNode in descriptionNodes)
            {
                if ([[divNode getAttributeNamed:@"class"] isEqualToString:@"description"])
                {
                    [self setCompany_description:[divNode contents]];
                }
            }
        }
    }
}
@end
