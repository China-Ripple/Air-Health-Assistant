//
//  HealthConsultantTableViewController.m
//  Air Health Assistant
//
//  Created by xu da on 14-7-23.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "HealthConsultantTableViewController.h"
#import "TestTextViewController.h"
#import "XBody.h"
#import "LocalizedString.h"
@interface HealthConsultantTableViewController ()

@end

@implementation HealthConsultantTableViewController
@synthesize detailArray;
/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}*/
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //LocalizedString *localizedString = [LocalizedString getInstance];
    //self.navigationItem.title = localizedString.PAGE_TEST2;
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
    [self.navigationController.navigationBar setBackgroundImage:stretchedImage forBarMetrics:UIBarMetricsDefault];
    //导航栏字体颜色，back按钮的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [detailArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[detailArray objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:[XBody getInstance].titleFont];
    [cell.textLabel setTextColor:[XBody getInstance].detail_title_color];
    [cell.textLabel setHighlightedTextColor:[UIColor whiteColor]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    UIImage *imageHL = [UIImage imageNamed:@"cell_highlighted.png"];
    UIImage *imageHL_S = [imageHL stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [cell setSelectedBackgroundView:[[UIImageView alloc]initWithImage:imageHL_S]];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTextViewController *nextController;
    if (nextController == nil) {
        NSString *nibForController = nil;
        nibForController = @"TestTextViewController";
        nextController = [[TestTextViewController alloc] initWithNibName:nibForController bundle:nil];
    }
    XBody *xbody = [XBody getInstance];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"healthConsultant" ofType:@"plist"];
    NSDictionary *healthConsultantDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSDictionary *detailDic = [healthConsultantDic objectForKey:[xbody.healthConsultantArray objectAtIndex:indexPath.row]];
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        NSArray * dicArray = [detailDic allKeys];
        for (int i = 0; i < [dicArray count]; i++) {
            XDetailEntity *detailEntity = [[XDetailEntity alloc]init];
            detailEntity.title = dicArray[i];
            detailEntity.content = [detailDic objectForKey:dicArray[i]];
            if (detailEntity.content == nil || [detailEntity.content length] == 0) {
                detailEntity.content = @"分情况而定";
            }
            detailEntity.rowHeightP = [xbody getTextHeight:[UIScreen mainScreen].bounds.size.width text:detailEntity.content];
            detailEntity.rowHeightL = [xbody getTextHeight:[UIScreen mainScreen].bounds.size.height text:detailEntity.content];
            
            [mutableArray addObject:detailEntity];
        }
    nextController.detailArray = mutableArray;
    [self.navigationController pushViewController:nextController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XBody *xbody = [XBody getInstance];
    int height = TABLECELL_HIGHT;
     if(xbody.currentDeviceType == XDeviceTypeIPad) {
         height = TABLECELL_HIGHT_IPAD;
    }
    return height;
}
@end
