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
#import "REDHTTPRequestFactoryProtocol.h"
#import "REDHTTPRequestFactory.h"
#import "REDServiceResponseProtocol.h"
#import "REDServiceResponse.h"
#import "REDServiceDispatcher.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDGoogleImageDictionary2ModelFactory.h"
#import "REDCollectionViewDatasourceProtocol.h"
#import "REDImageSearchCollectionViewDatasource.h"

@implementation REDDepedencyInjection

+(void)registerImplementations {
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"author"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDHTTPRequestFactory class] forProtocol:@protocol(REDHTTPRequestFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceResponse class] forProtocol:@protocol(REDServiceResponseProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceDispatcher class] forProtocol:@protocol(REDServiceDispatcherProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleImageDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDImageSearchCollectionViewDatasource class] forProtocol:@protocol(REDCollectionViewDatasourceProtocol) context:@"googleImage"];

}

@end
