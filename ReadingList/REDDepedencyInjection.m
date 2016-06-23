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
#import "REDAuthorNameValidator.h"
#import "REDTopRatedDictionary2ModelFactory.h"
#import "REDRequestFeature.h"
#import "REDRequestFeatureImpl.h"
#import "REDBookQueryService.h"
#import "REDBookQueryServiceImpl.h"
#import "REDUserUpload.h"
#import "REDUserUploadImpl.h"
#import "REDRealmMigration.h"
#import "REDRealmMigrationV2.h"
#import "REDBookRepositoryFactory.h"
#import "REDBookRepositoryFactoryImpl.h"
#import "REDLogRepositoryFactory.h"
#import "REDLogRepositoryFactoryImpl.h"
#import "REDListBooksFactory.h"
#import "REDListLogsFactory.h"
#import "REDAnimationFactory.h"
#import "REDAnimationFactoryImpl.h"
#import "REDBookRatingValidator.h"
#import "REDShareFactory.h"
#import "REDTransientBookCollectionViewDatasource.h"
#import "REDshareFactoryImpl.h"
#import "REDLibraryDatasourceFactory.h"
#import "REDLibraryDatasourceFactoryImpl.h"
#import "REDNoteRepositoryFactory.h"
#import "REDNoteRepositoryFactoryImpl.h"


@implementation REDDepedencyInjection

+(void)registerImplementations {
    
    //migration
    [[DPRegistry sharedRegistry] registerImplementation:[[REDRealmMigrationV2 alloc] init] forProtocol:@protocol(REDRealmMigration) context:nil];

    //user
    [[DPRegistry sharedRegistry] registerImplementation:[[[REDRLMUserDataAccessObject alloc] init] user] forProtocol:@protocol(REDUserProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[[REDUserUploadImpl alloc] init] forProtocol:@protocol(REDUserUpload) context:nil];

    
    //datasources
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDLogDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"log"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"author"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDImageSearchCollectionViewDatasource class] forProtocol:@protocol(REDCollectionViewDatasourceProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDTransientBookCollectionViewDatasource class] forProtocol:@protocol(REDCollectionViewDatasourceProtocol) context:@"transientBook"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDTransientBookDatasource class] forProtocol:@protocol(REDDatasourceProtocol) context:@"transientBook"];
    
    //service
    [[DPRegistry sharedRegistry] registerImplementation:[REDHTTPRequestFactory class] forProtocol:@protocol(REDHTTPRequestFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceResponse class] forProtocol:@protocol(REDServiceResponseProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDServiceDispatcher class] forProtocol:@protocol(REDServiceDispatcherProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookRatingUploader sharedUploader] forProtocol:@protocol(REDBookUploaderProtocol) context:nil];
    
    //factories
    [[DPRegistry sharedRegistry] registerImplementation:[REDNoteRepositoryFactoryImpl class] forProtocol:@protocol(REDNoteRepositoryFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDLibraryDatasourceFactoryImpl class] forProtocol:@protocol(REDLibraryDatasourceFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAnimationFactoryImpl class] forProtocol:@protocol(REDAnimationFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDTopRatedDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"topRated"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleImageDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleImageDictionary2ModelFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleImage"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDGoogleBooksFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"googleBooks"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDReadFactory class] forProtocol:@protocol(REDReadFactoryProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDShareFactoryImpl class] forProtocol:@protocol(REDShareFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDListBooksFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDListLogsFactory class] forProtocol:@protocol(REDDictionary2ModelFactoryProtocol) context:@"log"];

    //DAOs
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMUserDataAccessObject class] forProtocol:@protocol(REDUserDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMBookDataAccessObject class] forProtocol:@protocol(REDBookDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMCategoryDataAccessObject class] forProtocol:@protocol(REDCategoryDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMAuthorDataAccessObject class] forProtocol:@protocol(REDAuthorDataAccessObject) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMReadDataAccessObject class] forProtocol:@protocol(REDReadDataAccessObject) context:nil];
    
    //validators
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookRatingValidator class] forProtocol:@protocol(REDValidator) context:@"rating"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDPagesValidator class] forProtocol:@protocol(REDValidator) context:@"pages"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookValidator class] forProtocol:@protocol(REDValidator) context:@"book"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDDateValidator class] forProtocol:@protocol(REDValidator) context:@"date"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookNameValidator class] forProtocol:@protocol(REDValidator) context:@"name"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDCategoryValidator class] forProtocol:@protocol(REDValidator) context:@"category"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorValidator class] forProtocol:@protocol(REDValidator) context:@"author"];
    [[DPRegistry sharedRegistry] registerImplementation:[REDAuthorNameValidator class] forProtocol:@protocol(REDValidator) context:@"authorName"];

    //others
    [[DPRegistry sharedRegistry] registerImplementation:[REDLogRepositoryFactoryImpl class] forProtocol:@protocol(REDLogRepositoryFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookRepositoryFactoryImpl class] forProtocol:@protocol(REDBookRepositoryFactory) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDBookQueryServiceImpl class] forProtocol:@protocol(REDBookQueryService) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRequestFeatureImpl class] forProtocol:@protocol(REDRequestFeature) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRealm class] forProtocol:@protocol(REDTransactionManager) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDPhotoPickerPresenter class] forProtocol:@protocol(REDPhotoPickerPresenterProtocol) context:nil];
    [[DPRegistry sharedRegistry] registerImplementation:[REDRLMResultsToNSArray class] forProtocol:@protocol(REDRLMArrayHelper) context:nil];



}

@end
