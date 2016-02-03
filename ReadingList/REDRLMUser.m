//
//  REDRLMUser.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMUser.h"

@implementation REDRLMUser

#pragma mark - setters
-(void)setCover:(UIImage *)cover {
    _coverData = UIImagePNGRepresentation(cover);
}
-(void)setPhoto:(UIImage *)photo {
    _photoData = UIImagePNGRepresentation(photo);
}

#pragma mark - getters
-(UIImage *)cover {
    return [UIImage imageWithData:_coverData];
}
-(UIImage *)photo {
    return [UIImage imageWithData:_photoData];
}

#pragma mark - protocol
-(BOOL)hasName {
    return self.name.length > 0;
}
-(BOOL)hasPhoto {
    return self.photoData != nil;
}

@end
