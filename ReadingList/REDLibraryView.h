//
//  REDLibraryView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDLibraryViewController_Constants.h"
#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"

@class REDLibraryView;
@protocol REDLibraryViewDelegate <NSObject>

-(void)libraryViewDidUpdate:(REDLibraryView *)libraryView;

@end

@protocol REDLibraryViewDatasourceDelegate <NSObject>

-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource didDeleteBook:(id<REDBookProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource didSelectBook:(id<REDBookProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource didSelectAuthor:(id<REDAuthorProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource wantsToEditAuthor:(id<REDAuthorProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource didSelectCategory:(id<REDCategoryProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource wantsToEditCategory:(id<REDCategoryProtocol>)book error:(NSError *)error;
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>) datasource didChangeEditing:(BOOL)editing;



@end

@interface REDLibraryView : UIView


#pragma makr - properties
@property (nonatomic,assign) BOOL editing;
@property (nonatomic,assign) REDLibraryType type;
@property (nonatomic,weak) id<REDLibraryViewDelegate> delegate;
@property (nonatomic,strong) id<REDDatasourceProtocol> datasource;
@property (nonatomic,strong) id<REDLibraryViewDatasourceDelegate> datasourceDelegate;

#pragma mark - setter
-(void)setType:(REDLibraryType)type andSync:(BOOL)sync;

#pragma mark - searching (im high)
-(void)pleaseSirSearchForThisBooks:(NSString *)searchText;
-(void)stopSearchNowSir;

#pragma mark - methods
-(void)update;
-(void)sync;

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
