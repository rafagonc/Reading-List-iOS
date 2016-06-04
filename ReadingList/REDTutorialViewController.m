//
//  REDTutorialViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 5/30/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTutorialViewController.h"
#import "REDCloudViewController.h"
#import "REDNameViewController.h"
#import "REDWelcomeViewController.h"
#import "REDUserProtocol.h"
#import "UIColor+ReadingList.h"
#import "REDBookFindTutorialViewController.h"
#import "REDAllSetViewController.h"
#import "REDTutorialChainOfResponsibilityProtocol.h"
#import "UIViewController+NotificationShow.h"

@interface REDTutorialViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, REDAllSetViewControllerDelegate>

#pragma mark - ui
@property (nonatomic,strong) UIPageControl *pageControl;

#pragma mark - injected
@property (setter=injected:) id<REDUserProtocol> user;

#pragma mark - properties
@property (nonatomic,strong) NSArray <UIViewController<REDTutorialChainOfResponsibilityProtocol> *> * tutorialViewControllers;

@end

@implementation REDTutorialViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)}]) {
        self.tutorialViewControllers = @[[[REDWelcomeViewController alloc] init],
                                         [[REDNameViewController alloc] init],
                                         [[REDCloudViewController alloc] init],
                                         [[REDBookFindTutorialViewController alloc] init],
                                         [[REDAllSetViewController alloc] initWithDelegate:self]];
        [self setViewControllers:@[[self.tutorialViewControllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.delegate = self;
        self.dataSource = self;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageControl = [[UIPageControl alloc] init];
    [self.pageControl setNumberOfPages:self.tutorialViewControllers.count];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor red_redColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor colorWithWhite:0.9 alpha:1]];
    [self.pageControl setUserInteractionEnabled:NO];
    [self.view addSubview:self.pageControl];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews {
    [self.pageControl setFrame:CGRectMake(self.view.frame.size.width/2 - 25, self.view.frame.size.height - 30, 50, 30)];
}

#pragma mark - page
-(UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationMaskPortrait;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if ([self.tutorialViewControllers indexOfObject:(UIViewController<REDTutorialChainOfResponsibilityProtocol> *)viewController] + 1 >= self.tutorialViewControllers.count) {
        return nil;
    } else {
        NSUInteger page = [self.tutorialViewControllers indexOfObject:(UIViewController<REDTutorialChainOfResponsibilityProtocol> *)viewController] + 1;
        return [self.tutorialViewControllers objectAtIndex:page];
    }
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ((NSInteger)([self.tutorialViewControllers indexOfObject:(UIViewController<REDTutorialChainOfResponsibilityProtocol> *)viewController] - 1) < 0) {
        return nil;
    } else {
        NSUInteger page = [self.tutorialViewControllers indexOfObject:(UIViewController<REDTutorialChainOfResponsibilityProtocol> *)viewController] - 1;
        return [self.tutorialViewControllers objectAtIndex:page];
    }
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSUInteger page = [self.tutorialViewControllers indexOfObject:[self.viewControllers objectAtIndex:0]];
    [self.pageControl setCurrentPage:page]
    ;
}

#pragma mark - delegate
-(void)controllerDidFinishTutorial:(REDAllSetViewController *)controller {
    for (UIViewController<REDTutorialChainOfResponsibilityProtocol> * vc in self.tutorialViewControllers) {
        NSError * error;
        if ([vc process:self error:&error] == NO) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
            return;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
}


@end
