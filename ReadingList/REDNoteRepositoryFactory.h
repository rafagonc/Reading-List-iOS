//
//  REDNoteRepositoryFactory.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 6/23/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDNoteRepository.h"

@protocol REDNoteRepositoryFactory <NSObject>

-(id<REDNoteRepository>)repository;

@end
