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
#import "REDBookDataAccessObject.h"
#import "REDBookDataAccessObjectImpl.h"
#import "REDCategoryDataAccessObject.h"
#import "REDCategoryDataAccessObjectImpl.h"
#import "REDAuthorDataAccessObject.h"
#import "REDAuthorDataAccessObjectImpl.h"
#import "REDGoogleBooksFactory.h"
#import "REDTransientBookDatasource.h"
#import "REDBookUploaderProtocol.h"
#import "REDBookRatingUploader.h"
#import "REDReadFactoryProtocol.h"
#import "REDReadFactory.h"
#import "REDReadDataAccessObject.h"
#import "REDReadDataAccessObjectImpl.h"

@implementation REDDepedencyInjection

+(void)registerImplementations {
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"author"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDHTTPRequestFactory class] forProtocol:@protocol(REDHTTPRequestFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceResponse class] forProtocol:@protocol(REDServiceResponseProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceDispatcher class] forProtocol:@protocol(REDServiceDispatcherProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleImageDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleBooksFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleBooks"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDImageSearchCollectionViewDatasource class] forProtocol:@protocol(REDCollectionViewDatasourceProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDataAccessObjectImpl class] forProtocol:@protocol(REDBookDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDataAccessObjectImpl class] forProtocol:@protocol(REDCategoryDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDataAccessObjectImpl class] forProtocol:@protocol(REDAuthorDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDTransientBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"transientBook"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookRatingUploader sharedUploader] forProtocol:@protocol(REDBookUploaderProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDReadFactory class] forProtocol:@protocol(REDReadFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDReadDataAccessObjectImpl class] forProtocol:@protocol(REDReadDataAccessObject) context:nil];


}

@end
