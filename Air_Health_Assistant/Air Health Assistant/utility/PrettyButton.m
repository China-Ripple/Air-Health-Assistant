//
//  PrettyButton.m
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "PrettyButton.h"

@implementation PrettyButton

@synthesize information;
@synthesize smallImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"PrettyButton %@",self.information);
        [self.information setText:@"PrettyButton"];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 255.0/255.0, 255.0/255.0, 255.0/255.0, 1);
    
    CGContextSetRGBFillColor(context, 155/255.0, 155/255.0, 155/255.0, 1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, 60);
    CGPathAddLineToPoint(path, NULL, 320, 60);
    CGPathAddLineToPoint(path, NULL, 320, 0);
    CGPathCloseSubpath(path);
    
    CGContextSaveGState(context);
    //shadow
    // CGContextSetShadow(context, CGSizeMake(5*scaleValue, 5*scaleValue), 20.0*scaleValue);
    //draw bound
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    //draw inner
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFill);
    
    CGPoint startPoint,endPoint;
    startPoint = CGPointMake(0, 0);
    endPoint = CGPointMake(320, 60);
    //draw gradient
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        150 / 255.0, 150 / 255.0, 150 / 255.0, 1,
        70 / 255.0, 70 / 255.0, 115.0 / 255.0, 1,
        50 / 255.0,  50 / 255.0, 60 / 255.0, 1,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
}*/

@end
