//
//  REDCreateNoteRequest.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDRequestProtocol.h"
#import "REDNotesProtocol.h"

@interface REDCreateNoteRequest : NSObject

<REDRequestProtocol>

#pragma mark - constructor
-(instancetype)initWithNote:(id<REDNotesProtocol>)note;

#pragma mark - properties
@property (nonatomic,readonly) id<REDNotesProtocol> note;

@end
