//
//  StoreItemCell.h
//  Air Health Assistant
//
//  Created by xu da on 14-6-30.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBody.h"

#define IMAGE_WIDTH                 STORE_TABLECELL_IMAGE_WIDTH

@protocol StoreItemCellDelegate
-(void)itemClick:(id)sender index:(NSUInteger)rowIndex information:(NSString *)inf;
@end
@interface StoreItemCell : UITableViewCell{
    NSUInteger rowIndex;
    UILabel *name;
    UILabel *description;
    UIButton *connectButton;
    id <StoreItemCellDelegate> delegate;
}
@property NSUInteger rowIndex;
@property UILabel *name;
@property UILabel *description;
@property UIButton *connectButton;
@property id <StoreItemCellDelegate> delegate;
- (void)initValue;

@end
