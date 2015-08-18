//
//  StoreItemCell.m
//  Air Health Assistant
//
//  Created by xu da on 14-6-30.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import "StoreItemCell.h"

@implementation StoreItemCell
@synthesize rowIndex;
@synthesize name;
@synthesize description;
@synthesize connectButton;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initValue
{
    // Initialization code
    //float scaleValue = [XAppProperties getProperties].scaleValue;
    float scaleValue = 1;
    //image
    CGRect frame1 = CGRectMake(10*scaleValue, 1*scaleValue, IMAGE_WIDTH, IMAGE_WIDTH);
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"item%d",rowIndex+1]];
    NSString *nameStr,*descriptionStr;
    switch (rowIndex) {
        case 0:
            nameStr = @"RT8600太空舱按摩椅（香槟色）";
            descriptionStr = @"考量现代生活空间需求，展示出全新的产品思维设计方向，前移支架不仅能给您多重享受，还能呵护您的身体健康";
            break;
        case 1:
            nameStr = @"RT8600太空舱按摩椅";
            descriptionStr = @"智能手机，平板电脑轻便、时尚、好玩，让你爱不释手？RT8600太空舱按摩椅集航天品质和卓越的操作体验为一体，让你与所爱之物全无阻隔，无线洒脱你的惬意生活！";
            break;
        case 2:
            nameStr = @"RT6900霄摇椅";
            descriptionStr = @"零重力体感，传承经典技艺；换向“零”等待等新电子技术的应用，带来星级品质，给您至尊享受。";
            break;
        case 3:
            nameStr = @"RT6161领秀按摩椅";
            descriptionStr = @"推开窗，面对的是阴霾的天空；出了门，汽车又堵到爆。汽车的喇叭声、司机之间的对骂声、远处的建筑物上的枯燥叮当声，烦恼似乎无处不在。生活看起来好像并没有什么美好的，幸好，还有RT6161按摩椅可以坐坐。";
            break;
        case 4:
            nameStr = @"RT6156 心悦.旋动椅";
            descriptionStr = @"换个角度看世界，最值得一提的是产品的创新设计，整个按摩椅可左右旋转60度，只需轻轻转动，马上带来不同凡响的按摩体验。换个角度看，世界果然大不同。";
            break;
        case 5:
            nameStr = @"RT8305按摩椅";
            descriptionStr = @"大气稳重的外形，不是它的全部标签，强大而实用的功能才是它的杀手锏。自动精准的检测、77厘米超长行程、S型曲线导轨、零重力等是它俘获使用者芳心的秘密武器。";
            break;
        default:
            break;
    }
    
    UIImageView * iView = [[UIImageView alloc]initWithImage:image];
    iView.frame = frame1;
    [self.contentView addSubview:iView];
    //name
    CGRect frame2 = CGRectMake(10*scaleValue + IMAGE_WIDTH, 10*scaleValue, self.frame.size.width-(10*scaleValue + IMAGE_WIDTH), IMAGE_WIDTH/3-(5)/2*scaleValue);
    name = [[UILabel alloc]initWithFrame:frame2];
    [name setFont:[UIFont systemFontOfSize:20*scaleValue]];
    name.backgroundColor = [UIColor clearColor];
    [name setText:nameStr];
    [self.contentView addSubview:name];
    //description
    CGRect frame3 = CGRectMake(10*scaleValue + IMAGE_WIDTH, 10*scaleValue+IMAGE_WIDTH/3, self.frame.size.width-(10*scaleValue + IMAGE_WIDTH), IMAGE_WIDTH*2/3-(5)/2*scaleValue);
    description = [[UILabel alloc]initWithFrame:frame3];
    [description setFont:[UIFont systemFontOfSize:15*scaleValue]];
    [description setTextColor:[UIColor grayColor]];
    [description setNumberOfLines:9];
    description.backgroundColor = [UIColor clearColor];
    [description setText:descriptionStr];
    [self.contentView addSubview:description];
    /*
     LocalizedString * localizedString = [LocalizedString getInstance];
     CGFloat height = frame2.origin.y-frame1.origin.y+frame2.size.height;
     CGRect frame3 = CGRectMake(self.frame.size.width-(CONNECT_BUTTON_WIDTH)*scaleValue-(10)*scaleValue, 1*scaleValue+6*scaleValue, CONNECT_BUTTON_WIDTH*scaleValue,height-12*scaleValue);
     connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     connectButton.frame = frame3;
     [[connectButton titleLabel] setFont:[UIFont boldSystemFontOfSize:25*scaleValue]];
     [connectButton setTitle:localizedString.BLUETOOTH_CONNECT_BUTTON forState:UIControlStateNormal];
     [connectButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     connectButton.backgroundColor = [UIColor clearColor];
     [self.contentView addSubview:connectButton];
     */
    //self.backgroundColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
