//
//  REDLibraryDataProvider.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDLibraryViewController_Constants.h"

@interface REDLibraryDataProvider : NSObject

#pragma mark - method
-(void)dataForType:(REDLibraryType)type sync:(BOOL)sync callback:(void(^)(id data))callback error:(NSError **)error_pointer;
-(void)dataForType:(REDLibraryType)type withNameFilter:(NSString *)name callback:(void(^)(id data))callback error:(NSError **)error_pointer ;

@end
