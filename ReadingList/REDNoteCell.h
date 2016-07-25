//
//  REDNoteCellTableViewCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDNotesProtocol.h"
#import "UIStaticTableView.h"

@class REDNoteCell;
@protocol REDNoteCellDelegate <NSObject>

-(void)noteCell:(REDNoteCell *)cell wantsToOpenNote:(id<REDNotesProtocol>)note;
-(void)noteCell:(REDNoteCell *)cell wantsToDeleteNote:(id<REDNotesProtocol>)note;

@end

@interface REDNoteCell : UITableViewCell

<UIStaticTableViewCellCustomizationProtocol>

-(void)setNote:(id<REDNotesProtocol>)note;

@property (nonatomic,weak) id<REDNoteCellDelegate> delegate;

@end
