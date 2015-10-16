//
//  REDDepedencyInjection.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDepedencyInjection.h"
#import "Depend/DPRegistry.h"
#import "REDDatasourceProtocol.h"
#import "REDBookDatasource.h"
#import "REDCategoryDatasource.h"
#import "REDAuthorDatasource.h"

@implementation REDDepedencyInjection

+(void)registerImplementations {
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"author"];

}

@end
