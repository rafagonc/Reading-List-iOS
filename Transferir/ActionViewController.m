//
//  ActionViewController.m
//  Transferir
//
//  Created by Rafael Gonzalves on 16/03/17.
//  Copyright © 2017 Rafael Gonzalves. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeText]) {
                // This is an image. We'll load it, then place it in our image view.
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeText options:nil completionHandler:^(NSString *text, NSError *error) {
                    if(text) {
                        NSLog(@"%@",text);
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
