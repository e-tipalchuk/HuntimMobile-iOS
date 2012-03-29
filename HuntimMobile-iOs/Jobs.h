//
//  Jobs.h
//  HuntimMobile-iOs
//
//  Created by Кирилл Кунст on 26.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Jobs : NSObject
@property (nonatomic,strong) NSMutableArray *items;
@property int *page;
-(void)getItemsWithPage:(int)currentPage;
@end

