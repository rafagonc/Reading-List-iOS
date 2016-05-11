//
//  RXServerMetadata.m
//  Raio X
//
//  Created by Rafael Gonçalves on 08/05/15.
//  Copyright (c) 2015 Iterative. All rights reserved.
//

#import "REDServerMetadata.h"

static const NSString * REDServiceMetadataActiveEnvironmentKey = @"Active Environment";
static const NSString * REDServiceMetadataEnvironmentsKey = @"Environments";

@interface REDServerMetadata ()

@property (nonatomic,strong,readonly) NSDictionary *serverPropertyList;

@end

@implementation REDServerMetadata

#pragma mark - Constructor
-(instancetype)init {
    if (self = [super init]) {
        _serverPropertyList = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"plist"]];
    } return self;
}

#pragma mark - Factory Method
+(NSString *)service:(NSString *const)service inPath:(NSString *)path {
    REDServerMetadata * metadata = [[REDServerMetadata alloc] init];
    return [metadata concatenatePath:path toService:service];
}

#pragma mark - Methods
-(NSString *)URLForPath:(NSString *)path {
    NSDictionary * enviroment = [_serverPropertyList objectForKey:REDServiceMetadataEnvironmentsKey][_serverPropertyList[REDServiceMetadataActiveEnvironmentKey]];
    return enviroment[path];
}
-(NSString *)concatenatePath:(NSString *)path toService:(NSString *)service {
    NSString *urlPath = [self URLForPath:path];
    return [NSString stringWithFormat:@"%@%@", urlPath, service ? service : @""];
}

#pragma mark -  Dealloc
-(void)dealloc {

}

@end
