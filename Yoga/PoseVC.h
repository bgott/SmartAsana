//
//  PoseVC.h
//  Yoga
//
//  Created by Brandon Gottfried on 6/2/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoseController.h"

@interface PoseVC : UIViewController

@property (strong, nonatomic) UIImage *poseImage;
@property (strong, nonatomic) NSString *poseName;
@property (strong, nonatomic) NSString *thumbnailName;

+ (NSArray*)poses;

@end
