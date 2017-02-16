//
//  RXServerMetadata.h
//  Raio X
//
//  Created by Rafael Gonçalves on 08/05/15.
//  Copyright (c) 2015 Iterative. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Retorna a URL no ambiente setado n TCKServerMetadata.plist
 *
 *  @param path    Ex: API
 *  @param service Ex: Endpoint
 *
 *  @return URL String
 */
#define REDServiceFind(p, s) [REDServerMetadata service:s inPath:p]

static NSString *const REDServerMetadata_V1 = @"v1";

@interface REDServerMetadata : NSObject

+(NSString *)service:(NSString *const)service inPath:(NSString *)path;

@end
