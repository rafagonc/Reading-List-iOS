//
//  UIImage+Blur.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/11/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "UIImage+Blur.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (Blur)

-(UIImage *)applyBlurToImageWithRadius:(CGFloat)radius {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[self CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
    
}

@end
