//
//  REDBookRepositoryFactory.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookRepository.h"

@protocol REDBookRepositoryFactory <NSObject>

-(id<REDBookRepository>)repository;

@end
