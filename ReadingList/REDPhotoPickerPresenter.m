//
//  TCKPhotoPickerPresenter.m
//  TicketV3
//
//  Created by Rafael Gonzalves on 10/20/15.
//  Copyright © 2015 Rafael Gonçalves. All rights reserved.
//

#import "REDPhotoPickerPresenter.h"
#import <UIKit/UIKit.h>
#import "UIActionSheet+Blocks.h"

@interface REDPhotoPickerPresenter () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark - ui
@property (nonatomic,strong) UIImagePickerController *imagePickerController;

#pragma mark - callback
@property (nonatomic,copy) REDPhotoPickerPresenterProtocolCallback callback;

@end

@implementation REDPhotoPickerPresenter

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma mark - picker protocol
-(void)pickPhotoFromViewController:(UIViewController *)vc hasPhoto:(BOOL)hasPhoto withCallback:(REDPhotoPickerPresenterProtocolCallback)callback {
    self.callback = callback;
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.allowsEditing = YES;
    self.imagePickerController.delegate = self;
    if (hasPhoto) {
        [UIActionSheet showInView:vc.view withTitle:@"Escolher Foto" cancelButtonTitle:@"Cancelar" destructiveButtonTitle:@"Remove Photo" otherButtonTitles:@[@"Camera", @"Photo Library"] tapBlock:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                } else {
                    if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Camera Not Available"}]);
                    self.callback = nil;
                }
            } else if (buttonIndex == 2) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                } else {
                    if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Photo Library not Available"}]);
                    self.callback = nil;
                }
            } else if (buttonIndex == 0) {
                if (self.callback) self.callback(nil,nil);
                self.callback = nil;
            }
        }];
    } else {
        [UIActionSheet showInView:vc.view withTitle:@"Escolher Foto" cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@[@"Camera", @"Photo Library"] tapBlock:^(UIActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                } else {
                    if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey :  @"Camera Not Available"}]);
                    self.callback = nil;
                }
            } else if (buttonIndex == 1) {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [vc presentViewController:self.imagePickerController animated:YES completion:nil];
                } else {
                    if (self.callback) self.callback(nil,[NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey :  @"Photo Library Not Available"}]);
                    self.callback = nil;
                }
            }
        }];
    }

    return;
}
#pragma GCC diagnostic pop


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
