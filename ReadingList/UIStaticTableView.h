//
//  UIStaticTableView.h
//  Ticket
//
//  Created by Rafael Gonçalves on 28/04/15.
//  Copyright (c) 2015 Iterative. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIStaticTableViewCellCustomizationProtocol <NSObject>

-(CGFloat)height;

@end


@interface UIStaticTableViewSection : NSObject

@property (nonatomic,strong) NSString *headerName;
@property (nonatomic,strong) NSString *footerName;

@property (nonatomic,strong) NSMutableArray *cells;

@end

@interface UIStaticTableView : UITableView



#pragma mark - Adding and Removing
-(void)addSection:(UIStaticTableViewSection *)section;
-(void)removeSection:(UIStaticTableViewSection *)section;
-(void)addCell:(UITableViewCell *)cell onSection:(UIStaticTableViewSection *)section;
-(void)addCell:(UITableViewCell *)cell onSection:(UIStaticTableViewSection *)section animated:(BOOL)animated ;
-(void)removeCell:(UITableViewCell *)cell ofSection:(UIStaticTableViewSection *)section;
-(void)removeCell:(UITableViewCell *)cell ofSection:(UIStaticTableViewSection *)section animated:(BOOL)animated;
-(void)insertCell:(UITableViewCell *)cell onIndex:(NSInteger)index ofSection:(UIStaticTableViewSection *)section;
-(void)clean;

@end
