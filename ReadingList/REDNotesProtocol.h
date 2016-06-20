//
//  REDNotesProtocol.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDNotesProtocol <NSObject>

@property (nonatomic,assign) NSInteger identifier;
@property (nonatomic,strong,nonnull) NSString * text;
@property (nonatomic,strong,nonnull) NSString * bookName;

@end
