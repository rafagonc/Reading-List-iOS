//
//  REDDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDDataAccessObject <NSObject>

-(NSArray *)list;
-(NSArray *)listWithPredicate:(NSPredicate *)predicate;
-(void)remove:(id)object;
-(id)create;
//-(NSString *)entityName;

@end
