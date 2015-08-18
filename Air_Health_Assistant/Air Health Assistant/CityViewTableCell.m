//
//  CityViewTableCell.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-17.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "CityViewTableCell.h"

@implementation CityViewTableCell
@synthesize cityCode;
//@synthesize cityText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
