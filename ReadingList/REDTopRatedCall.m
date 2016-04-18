//
//  REDTopRatedCall.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTopRatedCall.h"
#import "REDServiceCall_Protected.h"
#import "REDServiceResponseProtocol.h"
#import "REDDictionary2ModelFactoryProtocol.h"
#import "REDHTTPRequestFactoryProtocol.h"
#import "NSDictionary+Validation.h"

@interface REDTopRatedCall ()

@property (setter=injected_topRated:) id<REDDictionary2ModelFactoryProtocol> parser;
@property (setter=injected:) id<REDServiceResponseProtocol> response;

@end

@implementation REDTopRatedCall

-(void)startWithRequest:(id<REDRequestProtocol>)request2 withCompletion:(void (^)(void))completion {
    self.request = request2;
//    [self call:^(id responseObject, NSError *error) {
//        if (error) {
//            [self.response setSuccess:NO];
//            [self.response setError:error];
//            [self error:self.response];
//        } else {
//            [self.parser setInput:responseObject];
//            [self.response setData:[self.parser outputForMany]];
//            [self.response setSuccess:YES];
//            [self success:self.response];
//        }
//    }];
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache",
                               @"postman-token": @"e26faa94-01e3-1078-e415-c38dd3554252" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://reading-list-prod.herokuapp.com/book/top"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        if (error) {
                                                            self.response.success = NO;
                                                            self.response.error = error;
                                                            [self error:self.response];
                                                            //                                                        callback(nil, error);
                                                        } else {
                                                            NSError* error;
                                                            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                            if ([json isKindOfClass:[NSDictionary class]]) {
                                                                if ([[json objectForKey:@"error"] isEqual:[NSNull null]] == NO ) {
                                                                    self.response.success = NO;
                                                                    self.response.error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : [json objectForKey:@"error"]}];
                                                                    [self error:self.response];
                                                            }
                                                            } else {
                                                                self.response.success = YES;
                                                                [self.parser setInput:json];
                                                                self.response.data = [self.parser outputForMany];
                                                                [self success:self.response];
                                                            }
                                                        }
                                                        
                                                    });
                                                }];
    [dataTask resume];
}
-(BOOL)canCacheResult {
    return NO;
}

@end
