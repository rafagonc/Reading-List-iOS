//
//  REDLibraryDataProvider.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryDataProvider.h"
#import "REDBookRepository.h"
#import "REDBookRepositoryFactory.h"
#import "REDAuthorDataAccessObject.h"
#import "REDBookDataAccessObject.h"
#import "REDCategoryDataAccessObject.h"
#import "REDUserProtocol.h"
#import "REDReadDataAccessObject.h"

@interface REDLibraryDataProvider ()

#pragma mark - injected
@property (setter=injected1:) id<REDUserProtocol> user;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookFactoryRepository;
@property (setter=injected3:) id<REDCategoryDataAccessObject> categoriesDataAccessObject;
@property (setter=injected4:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected5:) id<REDAuthorDataAccessObject> authorDataAccessObject;
@property (setter=injected6:) id<REDReadDataAccessObject> readDataAccessObject;


@end

@implementation REDLibraryDataProvider

-(void)dataForType:(REDLibraryType)type sync:(BOOL)sync callback:(void(^)(id data))callback error:(NSError **)error_pointer {
    switch (type) {
        case REDLibraryTypeBooks: {
            if (sync) {
                [[self.bookFactoryRepository repository] listForUser:self.user callback:^(NSArray<id<REDBookProtocol>> *books) {
                    callback(books);
                } error:^(NSError *error) {
                    *error_pointer = error;
                }];
            } else {
                callback([self.bookDataAccessObject allBooksSorted]);
            }
        }
            break;
        case REDLibraryTypeAuthor:
            callback([self.authorDataAccessObject authorsSortedByName]);
            break;
        case REDLibraryTypeCategories:
            callback([self.categoriesDataAccessObject categoriesSortedByName]);
            break;
        case REDLibraryTypeLogs:
            callback([self.readDataAccessObject logsOrderedByDate]);
            break;
            
        default:
            callback(@[]);
            *error_pointer = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Data could not be loaded!"}];
            break;
    }
    callback = nil;
}
-(void)dataForType:(REDLibraryType)type withNameFilter:(NSString *)name callback:(void(^)(id data))callback error:(NSError **)error_pointer {
    switch (type) {
        case REDLibraryTypeBooks:
            callback([self.bookDataAccessObject searchBooksWithString:name]);
            break;
        case REDLibraryTypeAuthor:
            callback([self.authorDataAccessObject authorsByName:name]);
            break;
        case REDLibraryTypeCategories:
            callback([self.categoriesDataAccessObject categoriesByName:name]);
            break;
        case REDLibraryTypeLogs:
            callback([self.readDataAccessObject logsOrderedByDate]);
            break;
            
        default:
            callback(@[]);
            *error_pointer = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Data could not be loaded!"}];
            break;
    }
    callback = nil;
}

@end
