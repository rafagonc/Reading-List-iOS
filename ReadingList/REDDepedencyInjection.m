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
#import "REDLogDatasource.h"
#import "REDValidator.h"
#import "REDBookNameValidator.h"
#import "REDAuthorValidator.h"
#import "REDCategoryValidator.h"
#import "REDPhotoPickerPresenter.h"
#import "REDPhotoPickerPresenterProtocol.h"
#import "REDUserProtocol.h"
#import "REDUserDataAccessObject.h"
#import "REDUserDataAccessObjectImpl.h"
#import "REDBookValidator.h"
#import "REDPagesValidator.h"
#import "REDDateValidator.h"
#import "REDRLMReadDataAccessObject.h"
#import "REDRLMBookDataAccessObject.h"
#import "REDRLMCategoryDataAccessObject.h"
#import "REDRLMAuthorDataAccessObject.h"
#import "REDRLMUserDataAccessObject.h"
#import "REDRLMArrayHelper.h"
#import "REDRLMResultsToNSArray.h"
#import "REDRealm.h"
#import "REDTransactionManager.h"

@implementation REDDepedencyInjection

+(void)registerImplementations {
    
    //user
    [[DPRegistry sharedRegistry] registerImplementation:[[[REDUserDataAccessObjectImpl alloc] init] user] forProtocol:@protocol(REDUserProtocol) context:nil];
    
    //datasources
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDLogDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"log"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"author"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDImageSearchCollectionViewDatasource class] forProtocol:@protocol(REDCollectionViewDatasourceProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDTransientBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"transientBook"];
    
    //service
    [[DPRegistry sharedRegistry] registerImplementation:[REDHTTPRequestFactory class] forProtocol:@protocol(REDHTTPRequestFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceResponse class] forProtocol:@protocol(REDServiceResponseProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceDispatcher class] forProtocol:@protocol(REDServiceDispatcherProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookRatingUploader sharedUploader] forProtocol:@protocol(REDBookUploaderProtocol) context:nil];
    
    //factories
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleImageDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleBooksFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleBooks"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDReadFactory class] forProtocol:@protocol(REDReadFactoryProtocol) context:nil];
    
    //DAOs
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMUserDataAccessObject class] forProtocol:@protocol(REDUserDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMBookDataAccessObject class] forProtocol:@protocol(REDBookDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMCategoryDataAccessObject class] forProtocol:@protocol(REDCategoryDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMAuthorDataAccessObject class] forProtocol:@protocol(REDAuthorDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMReadDataAccessObject class] forProtocol:@protocol(REDReadDataAccessObject) context:nil];
    
    //validators
    [[DPRegistry sharedRegistry] registerImplementation:[REDPagesValidator class] forProtocol:@protocol(REDValidator) context:@"pages"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookValidator class] forProtocol:@protocol(REDValidator) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDDateValidator class] forProtocol:@protocol(REDValidator) context:@"date"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookNameValidator class] forProtocol:@protocol(REDValidator) context:@"name"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryValidator class] forProtocol:@protocol(REDValidator) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorValidator class] forProtocol:@protocol(REDValidator) context:@"author"];
    
    //others
    [[DPRegistry sharedRegistry] registerImplementation:[REDRealm class] forProtocol:@protocol(REDTransactionManager) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDPhotoPickerPresenter class] forProtocol:@protocol(REDPhotoPickerPresenterProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMResultsToNSArray class] forProtocol:@protocol(REDRLMArrayHelper) context:nil];



}

@end
