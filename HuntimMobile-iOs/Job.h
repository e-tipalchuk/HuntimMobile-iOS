//
//  Job.h
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Job : NSObject
@property (nonatomic, strong) NSString *company_name;
@property (nonatomic, strong) NSString *occupation;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *iconUrl;

@property (nonatomic,strong) NSString *published_date;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *requirements;
@property (nonatomic,strong) NSString *company_description;
@property (nonatomic,strong) NSString *company_image_url;
@property (nonatomic,strong) NSString *company_url;

-(NSString *)OccupationInRussian;
-(void)parseData;
@end
