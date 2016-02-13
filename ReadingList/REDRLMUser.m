//
//  REDRLMUser.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMUser.h"
#import "UIImage+Blur.h"

@implementation REDRLMUser

#pragma mark - setters
-(void)setCover:(UIImage *)cover {
    self.coverData = UIImagePNGRepresentation(cover);
}
-(void)setPhoto:(UIImage *)photo {
    self.photoData = UIImagePNGRepresentation(photo);
    self.cover = [photo applyBlurToImageWithRadius:100.f];
}

#pragma mark - getters
-(UIImage *)cover {
    return [UIImage imageWithData:self.coverData];
}
-(UIImage *)photo {
    return [UIImage imageWithData:self.photoData];
}

#pragma mark - protocol
-(BOOL)hasName {
    return self.name.length > 0;
}
-(BOOL)hasPhoto {
    return self.photoData != nil;
}

#pragma mark - overrides
+(NSArray<NSString *> *)ignoredProperties {
    return @[@"cover", @"photo"];
}

@end
