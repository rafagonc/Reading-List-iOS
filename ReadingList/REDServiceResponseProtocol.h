//
//  REDServiceResponseProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDServiceResponseProtocol <NSObject>

@property (nonatomic,strong) id data;
@property (nonatomic,strong) NSError *error;
@property (nonatomic,assign) BOOL success;

@end
