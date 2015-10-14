//
//  REDStaticData.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDStaticData.h"
#import "REDEntityCreator.h"
#import "REDDataStack.h"
#import "REDCategoryProtocol.h"

static NSString * const REDStaticDataCreatedFlag = @"REDStaticDataCreatedFlag";

@interface REDStaticData ()

@property (nonatomic,readonly) NSUserDefaults *userDefaults;

@end

@implementation REDStaticData

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - methods
-(void)createStaticData {
    if ([self.userDefaults objectForKey:REDStaticDataCreatedFlag] == nil) {
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
                            @"Children's Book",
                            @"Christian Books",
                            @"Comics",
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
                            @"Romance",
                            @"Science & Math",
                            @"Science Fiction",
                            @"Spots & Outdoors",
                            @"Teen & Young Adult",
                            @"Test Preparation",
                            @"Travel"];
    
    for (NSString *name in categories) {
        id<REDCategoryProtocol> category  = (id<REDCategoryProtocol>)[REDEntityCreator newEntityWithProtocol:@protocol(REDCategoryProtocol)];
        [category setName:name];
    }
    
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
