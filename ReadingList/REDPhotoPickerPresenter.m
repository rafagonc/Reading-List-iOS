//
//  TCKPhotoPickerPresenter.m
//  TicketV3
//
//  Created by Rafael Gonzalves on 10/20/15.
//  Copyright © 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDPhotoPickerPresenter.h"
#import <UIKit/UIKit.h>
#import "UIAlertController+Blocks.h"
#import "UIActionSheet+Blocks.h"

@interface REDPhotoPickerPresenter () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark - ui
@property (nonatomic,strong) UIImagePickerController *imagePickerController;

#pragma mark - callback
@property (nonatomic,copy) REDPhotoPickerPresenterProtocolCallback callback;

@end

@implementation REDPhotoPickerPresenter

#pragma mark - pick
-(void)pickPhotoFromViewController:(UIViewController *)vc hasPhoto:(BOOL)hasPhoto withCallback:(REDPhotoPickerPresenterProtocolCallback)callback {
    self.callback = callback;
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.allowsEditing = YES;
    self.imagePickerController.delegate = self;
    [UIAlertController showActionSheetInViewController:vc withTitle:@"Choose Photo" message:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle: hasPhoto ? @"Remove Photo" : nil otherButtonTitles:@[@"Camera", @"Photo Library"] popoverPresentationControllerBlock:nil tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if ([[action title] isEqualToString:@"Camera"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                });
            } else {
                if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Camera Not Available"}]);
                self.callback = nil;
            }
        } else if ([[action title] isEqualToString:@"Photo Library"]) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                });
            } else {
                if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Photo Library not Available"}]);
                self.callback = nil;
            }
        } else if ([[action title] isEqualToString:@"Remove Photo"]) {
            if (self.callback) self.callback(nil,nil);
            self.callback = nil;
        }
    }];
}

#pragma mark - delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (self.callback) self.callback(info[UIImagePickerControllerEditedImage],nil);
    self.callback = nil;;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
