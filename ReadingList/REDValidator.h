//
//  REDValidator.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDValidator <NSObject>

-(BOOL)validate:(id)obj error:(NSError * __autoreleasing *)error;

@end