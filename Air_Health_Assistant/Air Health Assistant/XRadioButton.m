//
//  XRadioButton.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "XRadioButton.h"

@implementation XRadioButton
@synthesize isChecked;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isChecked = !isChecked;
    if(isChecked){
        [self setBackgroundImage:[UIImage imageNamed: @"radioButtonChecked"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed: @"radioButtonUnChecked"] forState:UIControlStateNormal];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
