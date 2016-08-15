//
//  REDBookCoverFlyweight.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookCoverFlyweight.h"

@interface REDBookCoverFlyweight ()

#pragma mark - properties
@property (nonatomic,strong) NSMutableDictionary * bookCovers;

@end

@implementation REDBookCoverFlyweight

#pragma mark - singleton
+(REDBookCoverFlyweight *)sharedFlyweight {
    static REDBookCoverFlyweight * flyweight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flyweight = [[self alloc] init];
    });
    return flyweight;
}

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.bookCovers = [@{} mutableCopy];
    } return self;
}

#pragma mark - methods
-(void)addCoverImage:(UIImage *)image forBook:(id<REDBookProtocol>)book {
    if (image && book)
    [self.bookCovers setObject:image forKey:[book name]];
}
-(UIImage *)flyweightCoverImageForBook:(id<REDBookProtocol>)book {
    return [self.bookCovers objectForKey:[book name]];
}

@end
