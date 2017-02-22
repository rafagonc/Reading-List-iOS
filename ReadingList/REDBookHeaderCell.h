//
//  REDBookHeaderCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"
#import "REDBookCreationChainProtocol.h"
#import "UIStaticTableView.h"

@class REDBookHeaderCell;
@protocol REDBookHeaderCellDelegate <NSObject>

-(void)didSelectAuthorInBookHeaderCell:(REDBookHeaderCell *)headerCell;
-(void)didSelectCoverInBookHeaderCell:(REDBookHeaderCell *)headerCell;
-(void)didSelectSnippetTextViewInBookHeaderCell:(REDBookHeaderCell *)headerCell;
-(void)bookHeaderCellWantsToAddNote:(REDBookHeaderCell *)cell;
-(void)bookHeaderCellWantsToShareProgress:(REDBookHeaderCell *)cell;



@end


@interface REDBookHeaderCell : UITableViewCell

<REDBookCreationChainProtocol, UIStaticTableViewCellCustomizationProtocol>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;

#pragma mark - properties
@property (nonatomic,assign) BOOL didChangeRate;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,strong) NSString *snippet;
@property (nonatomic,strong) NSString *coverURL;
@property (nonatomic,weak) id<REDBookProtocol> book;
@property (nonatomic,strong) id<REDAuthorProtocol> author;
@property (nonatomic,weak) id<REDBookHeaderCellDelegate> delegate;
@property (nonatomic,strong) UIImage *coverImage;

#pragma mark - getters
-(CGFloat)rating;

@end
