//
//  REDRLMDefaultDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMDefaultDataAccessObject.h"
#import <Realm/Realm.h>

@interface REDRLMDefaultDataAccessObject ()

@property (nonatomic,strong) RLMRealm *realm;

@end

@implementation REDRLMDefaultDataAccessObject

#pragma mark - default
-(void)remove:(id)object {
    [self.realm beginWriteTransaction];
    [self.realm deleteObject:object];
    [self.realm commitWriteTransaction];
}

#pragma mark - entity
-(NSString *)entityName {
    return nil;
}

@end
