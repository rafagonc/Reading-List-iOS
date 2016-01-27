//
//  TCKPhotoPickerPresenterProtocol.h
//  TicketV3
//
//  Created by Rafael Gonzalves on 10/20/15.
//  Copyright © 2015 Rafael Gonçalves. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^REDPhotoPickerPresenterProtocolCallback)(UIImage *image, NSError *error);

@protocol REDPhotoPickerPresenterProtocol <NSObject>

-(void)pickPhotoFromViewController:(UIViewController *)vc hasPhoto:(BOOL)hasPhoto withCallback:(REDPhotoPickerPresenterProtocolCallback)callback;

@end
