//
//  PrettyButton.h
//  Air Health Assistant
//
//  Created by xu da on 14-5-21.
//  Copyright (c) 2014年 xu da. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrettyButton : UIButton{
    IBOutlet UILabel *information;
    IBOutlet UIImageView *smallImage;
}
@property (strong, nonatomic) IBOutlet UILabel *information;
@property (strong, nonatomic) IBOutlet UIImageView *smallImage;

@end
