//
//  REDAddNoteViewController.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "PopoverViewController.h"
#import "REDBookProtocol.h"
#import "REDNotesProtocol.h"

@class REDAddNoteViewController;

@protocol REDAddNoteViewControllerDelegate <NSObject>

-(void)addNoteViewController:(REDAddNoteViewController *)addNoteViewController didJustAddNote:(id<REDNotesProtocol>)note;

@end

@interface REDAddNoteViewController : PopoverViewController

#pragma mark - constructor
-(instancetype)initWithBook:(id<REDBookProtocol>)book;
-(instancetype)initWithBook:(id<REDBookProtocol>)book andNote:(id<REDNotesProtocol>)notesx;

#pragma mark - delegate
@property (nonatomic,weak) id<REDAddNoteViewControllerDelegate> delegate;

@end
