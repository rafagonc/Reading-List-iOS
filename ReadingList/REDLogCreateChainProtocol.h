//
//  REDLogCreateChainProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDReadProtocol.h"

@protocol REDLogCreateChainProtocol <NSObject>

-(BOOL)process:(id<REDReadProtocol>)read error:(NSError * __autoreleasing *)error;

@end
