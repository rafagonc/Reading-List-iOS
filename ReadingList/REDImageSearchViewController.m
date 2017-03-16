//
//  REDImageSearchViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDImageSearchViewController.h"
#import "REDNavigationBarCustomizer.h"
#import "REDImageSearchRequest.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDServiceResponseProtocol.h"
#import "REDCollectionViewDatasourceProtocol.h"
#import "REDNavigationBarCustomizer.h"
#import "REDImageSearchCollectionViewDatasourceDelegate.h"
#import "UIViewController+Loading.h"
#import "UIViewController+NotificationShow.h"
#import "PhotoTweaksViewController.h"
#import "DZNWebViewController.h"
#import "UIColor+ReadingList.h"

@interface REDImageSearchViewController () <REDImageSearchCollectionViewDatasourceDelegate, UIImagePickerControllerDelegate, PhotoTweaksViewControllerDelegate, UINavigationControllerDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

#pragma mark - injected
@property (setter=injected:) id<REDServiceDispatcherProtocol> dispatcher;
@property (setter=injected_googleImage:) id<REDCollectionViewDatasourceProtocol> datasource;

#pragma mark - property
@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *authorName;

@end

@implementation REDImageSearchViewController

#pragma mark - init
-(instancetype)initWithBookName:(NSString *)bookName andAuthor:(NSString *)author {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.authorName = author;
        self.bookName = bookName;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Cover";
    
    [Localytics tagScreen:self.title];
    
//    self.collectionView.dataSource = self.datasource;
//    self.collectionView.delegate = self.datasource;
//    [self.datasource setDelegate:self];
//    [self.collectionView reloadData];
    [self setUpBarButtonItems];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    UIBarButtonItem * libraryButton = [[UIBarButtonItem alloc] initWithTitle:@"Library" style:UIBarButtonItemStylePlain target:self action:@selector(libraryAction:)];
    UIBarButtonItem * cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraAction:)];
    [self.navigationItem setRightBarButtonItems:@[cameraButton,libraryButton]];
}

#pragma mark - service
-(void)consume {
    REDImageSearchRequest *request = [[REDImageSearchRequest alloc] initWithQuery:[self query]];
    [request nextPage];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        [self.datasource setData:[response data]];
        [self.collectionView reloadData];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];
    }
}

#pragma mark - delegates
-(void)datasource:(id<REDCollectionViewDatasourceProtocol>)datasource didSelectImage:(UIImage *)image andURL:(NSString *)url error:(NSError *)error {
    if (!error) {
        [self finishWithImage:image andURL:url];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    PhotoTweaksViewController *photoTweaksViewController = [[PhotoTweaksViewController alloc] initWithImage:image];
    photoTweaksViewController.delegate = self;
    [picker pushViewController:photoTweaksViewController animated:YES];
}
-(void)photoTweaksControllerDidCancel:(PhotoTweaksViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}
-(void)photoTweaksController:(PhotoTweaksViewController *)controller didFinishWithCroppedImage:(UIImage *)croppedImage {
    [controller dismissViewControllerAnimated:YES completion:^{
        [self finishWithImage:croppedImage andURL:nil];
    }];
}

#pragma mark - getters
-(NSString *)query {
    return [NSString stringWithFormat:@"%@ - %@", self.bookName, self.authorName];
}

#pragma mark - methods
-(void)finishWithImage:(UIImage *)image andURL:(NSString *)url {
    if (self.callback) self.callback(image, url);
    self.callback = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actions
-(void)cancelAction:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cameraAction:(UIBarButtonItem *)item {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setAllowsEditing:NO];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Camera not available"];
    }
}
-(void)openBrowerAction:(id)sender {
    NSURL *URL = [NSURL URLWithString:[[NSString stringWithFormat:@"http://www.google.com/search?q=%@ %@ book cover&tbm=isch", self.bookName, self.authorName] stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    
    DZNWebViewController *WVC = [[DZNWebViewController alloc] initWithURL:URL];
    
    WVC.supportedWebNavigationTools = DZNWebNavigationToolAll;
    WVC.supportedWebActions = DZNWebActionAll;
    WVC.showLoadingProgress = YES;
    WVC.allowHistory = YES;
    WVC.hideBarsWithGestures = YES;
    
    [WVC.view setTintColor:[UIColor red_redColor]];
    
    [self.navigationController pushViewController:WVC animated:YES];
}
-(void)libraryAction:(UIBarButtonItem *)item {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setAllowsEditing:NO];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Library not available"];
    }
}
-(void)dismissBrowser {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
