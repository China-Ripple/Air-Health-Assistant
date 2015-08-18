//
//  TestTableViewCell.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "TestTableViewCell.h"
#import "XBody.h"

@implementation TestTableViewCell

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
- (void)initValue:(NSString *)textStr :(int)row :(int)height
{
    // Initialization code
    //float scaleValue = [XAppProperties getProperties].scaleValue;
    /*
    //1.计算文本的宽度
    UIFont* theFont = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
    CGSize sizeNameW = [textStr sizeWithFont:theFont
                          constrainedToSize:CGSizeMake(MAXFLOAT, 0.0)
                              lineBreakMode:NSLineBreakByWordWrapping];
    //2.计算文本的高度
    CGSize sizeNameH = [textStr sizeWithFont:theFont
                          constrainedToSize:CGSizeMake(100.0, MAXFLOAT)
                              lineBreakMode:NSLineBreakByWordWrapping];*/
    //标题
    CGRect frame1 = CGRectMake(0, 0, self.frame.size.width, 40);
   UILabel *title = [[UILabel alloc]initWithFrame:frame1];
    [title setFont:[UIFont systemFontOfSize:TEXT_FONT_SIZE*4/3]];
    [title setTextAlignment:NSTextAlignmentCenter];
    title.backgroundColor = [UIColor clearColor];
    [title setText:[NSString stringWithFormat:@"title%d",row]];
    [self.contentView addSubview:title];

    //文本
    CGRect frame2 = CGRectMake(0, 40, self.frame.size.width, height - 40);
    UILabel *content = [[UILabel alloc]initWithFrame:frame2];
    [content setFont:[UIFont systemFontOfSize:TEXT_FONT_SIZE]];
    [content setTextAlignment:NSTextAlignmentCenter];
    [content setNumberOfLines:99];
    content.backgroundColor = [UIColor clearColor];
    [content setText:textStr];

    [self.contentView addSubview:content];
}
@end
