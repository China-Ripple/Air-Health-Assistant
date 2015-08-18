//
//  ExerciseDetailViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-19.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "XBody.h"

#define TEXT_GAP VIEW_MARGIN

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController
@synthesize detailArray;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refreshContent];
    [[self.tabBarController tabBar] setHidden:YES];
    /*
    //设置导航栏背景
    NSString *navigatorImage;
    XBody *xbody = [XBody getInstance];
    if (xbody.currentDeviceType == XDeviceTypeIPhone4) {
        navigatorImage = NAVIGATIONBAR_MERGE_640x960;
    }else if(xbody.currentDeviceType == XDeviceTypeIPhone5) {
        navigatorImage = NAVIGATIONBAR_MERGE_640x1136;
    }else if(xbody.currentDeviceType == XDeviceTypeIPad) {
        navigatorImage = NAVIGATIONBAR_MERGE_1024x768;
    }
    UIImage *image = [UIImage imageNamed:navigatorImage];
    UIImage *stretchedImage = [image stretchableImageWithLeftCapWidth:10 topCapHeight:5];
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];*/
    //导航栏字体颜色，back按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
-(void)refreshContent{
    XBody *xbody = [XBody getInstance];
    
    int textGap = VIEW_MARGIN;
    int titleHeight = TITLE_HEIGHT;
    int lineGap = LINE_GAP;
    int imageSize = IMAGE_SIZE;
    int imageSizeSmallW = IMAGE_SIZE_SMALL_W;
    int imageSizeSmallH = IMAGE_SIZE_SMALL_H;
    if(xbody.currentDeviceType == XDeviceTypeIPad) {
        textGap = VIEW_MARGIN_IPAD;
        titleHeight = TITLE_HEIGHT_IPAD;
        lineGap = LINE_GAP_IPAD;
        imageSize = IMAGE_SIZE_IPAD;
        imageSizeSmallW = IMAGE_SIZE_SMALL_W_IPAD;
        imageSizeSmallH = IMAGE_SIZE_SMALL_H_IPAD;
    }

    for(UIView *view in [scrollView subviews]){
        [view removeFromSuperview];
    }
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    BOOL isLandscape = (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight);
    int tmpHeigh = 0;
    int width;
    if (!isLandscape) {
        width = [UIScreen mainScreen].bounds.size.width;
    }else{
        width = [UIScreen mainScreen].bounds.size.height;
    }
/*
    UIDeviceOrientation currentOrientation = [ [UIDevice currentDevice] orientation];
    BOOL isLandscape = (currentOrientation == UIDeviceOrientationLandscapeLeft || currentOrientation == UIDeviceOrientationLandscapeRight);
    NSLog(@"[isLandscape]:%d,%f",isLandscape,[UIScreen mainScreen].bounds.size.height);
    int tmpHeigh = 0;
    int width;
    
    if (!isLandscape) {
        width = [UIScreen mainScreen].bounds.size.width;
    }else{
        width = [UIScreen mainScreen].bounds.size.height;
    }*/

    for (int rowIndex = 0; rowIndex < [detailArray count]; rowIndex++) {
        XDetailEntity *detailEntity = [detailArray objectAtIndex:rowIndex];
        
        int rowHeight;
        if (isLandscape) {
            rowHeight = detailEntity.rowHeightL;
        }else{
            rowHeight = detailEntity.rowHeightP;
        }
        //线条
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(textGap, tmpHeigh, width - 2*textGap, 1)];
        [lineView setBackgroundColor:xbody.detail_line_color];
        [scrollView addSubview:lineView];
        //tmpHeigh+=LINE_GAP;
        tmpHeigh+=textGap;
        //标题
        CGRect frame1 = CGRectMake(textGap, tmpHeigh, width - 2*textGap, titleHeight);
        UILabel *title = [[UILabel alloc]initWithFrame:frame1];
        [title setFont:xbody.titleFont];
        [title setTextColor:xbody.detail_title_color];
        [title setTextAlignment:NSTextAlignmentCenter];
        title.backgroundColor = [UIColor clearColor];
        [title setText:detailEntity.title];
        [scrollView addSubview:title];
        tmpHeigh+=titleHeight;
        tmpHeigh+=textGap;
        //图像
        UIView *iView = [[UIView alloc]initWithFrame:CGRectMake(0, tmpHeigh, width - 2*textGap, imageSize)];
     /*   UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
        [imageView setFrame:[UIScreen mainScreen].bounds];
        [imageView setAutoresizesSubviews:YES];
        [scrollView addSubview:imageView];
*/
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:detailEntity.image]];
        [image setFrame:CGRectMake((width - imageSize)/2, 0, imageSize, imageSize)];
        [iView setAutoresizesSubviews:YES];
        [iView addSubview:image];
        [scrollView addSubview:iView];

        //自动缩放图形
        image.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        tmpHeigh+=imageSize;
        tmpHeigh+=textGap;
        //文本
        NSString *textStr = detailEntity.content;
        
        CGRect frame2 = CGRectMake(textGap, tmpHeigh, width - 2*textGap, rowHeight - titleHeight);
        UILabel *content = [[UILabel alloc]initWithFrame:frame2];
        [content setFont:xbody.textFont];
        [content setTextAlignment:NSTextAlignmentLeft];
        [content setNumberOfLines:99];
        [content setTextColor:xbody.detail_content_color];
        content.backgroundColor = [UIColor clearColor];
        [content setText:textStr];
        [scrollView addSubview:content];
        tmpHeigh+=textGap;
        tmpHeigh+=rowHeight - titleHeight;
    }
    
    //self.frame = CGRectMake(0, 0, 320, 480);
    UIScrollView *sView = (UIScrollView*)scrollView;
    [sView setContentSize:CGSizeMake(width, tmpHeigh)];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self refreshContent];
}
@end
