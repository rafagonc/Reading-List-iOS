//
//  REDStaticData.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDStaticData.h"
#import "REDDataStack.h"
#import "REDCategoryProtocol.h"
#import "REDBookProtocol.h"
#import "REDAuthorProtocol.h"
#import "REDCategoryDataAccessObject.h"
#import "REDBookDataAccessObject.h"
#import "REDCloudDataStack.h"
#import "REDAuthorDataAccessObject.h"

static NSString * const REDStaticDataCreatedFlag = @"REDStaticDataCreatedFlag";

@interface REDStaticData ()

#pragma mark - properties
@property (nonatomic,readonly) NSUserDefaults *userDefaults;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDCategoryDataAccessObject> categoryDataAccessObject;
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected:,readonly) id<REDAuthorDataAccessObject> authorDataAccessObject;

@end

@implementation REDStaticData

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - methods
-(void)createStaticData {
    if ([self.userDefaults objectForKey:REDStaticDataCreatedFlag] == nil && [self.categoryDataAccessObject list].count == 0) {
        [self createCategories];
        
        //save flag
        [self.userDefaults setObject:@1 forKey:REDStaticDataCreatedFlag];
        [self.userDefaults synchronize];
    }
}

#pragma mark - specifics
-(void)createCategories {
    NSArray *categories = @[@"Arts & Photohgraphy",
                            @"Biographies & Memories",
                            @"Business & Money",
                            @"Christian Books",
                            @"Comics",
                            @"Children's Book",
                            @"Computers & Technology",
                            @"Cookbooks, Food & Wine",
                            @"Crafts, Hobbies & Home",
                            @"Education & Teaching",
                            @"Engineering & Transportation",
                            @"Gay & Lesbian",
                            @"Health & Fitness",
                            @"History",
                            @"Humor & Entertainment",
                            @"Law",
                            @"Literatute & Fiction",
                            @"Medical Books",
                            @"Mystery, Thriller & Suspense",
                            @"Parenting & Relationships",
                            @"Politics & Social",
                            @"Reference",
                            @"Religion",
                            @"Science & Math",
                            @"Science Fiction",
                            @"Spots & Outdoors",
                            @"Teen & Young Adult",
                            @"Test Preparation",
                            @"Travel"];
    
    for (NSString *name in categories) {
        id<REDCategoryProtocol> category  = [self.categoryDataAccessObject create];
        [category setName:name];
    }
    
    id<REDCategoryProtocol> romanceCategory = [self.categoryDataAccessObject create];
    [romanceCategory setName:@"Romance"];
    
    id<REDAuthorProtocol> author = [self.authorDataAccessObject create];
    [author setName:@"William Shakespeare"];
    
    id<REDBookProtocol> book = [self.bookDataAccessObject create];
    [book setName:@"Romeo And Juliet"];
    [book setAuthor:author];
    [book setPagesValue:323];
    [book setPagesReadValue:0];
    [book setCategory:romanceCategory];
    [book setCoverImage:[UIImage imageNamed:@"romeo-and-juliet.jpg"]];
    
    [[REDCloudDataStack sharedManager] commit];
    [[REDDataStack sharedManager] commit];
}

#pragma mark - getters and setters
-(NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - factory method
+(void)craateStaticData {
    [[[self alloc] init] createStaticData];
}

@end
