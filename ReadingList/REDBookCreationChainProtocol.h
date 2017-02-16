//
//  REDBookCreationChainProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookProtocol.h"


@protocol REDBookCreationChainProtocol <NSObject>

-(BOOL)setNewValuesOnBook:(id<REDBookProtocol>)book error:(NSError **)error;

@end
