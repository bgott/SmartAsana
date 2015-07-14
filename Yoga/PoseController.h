//
//  PoseController.h
//  Yoga
//
//  Created by Brandon Gottfried on 6/6/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoseController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSString *poseName;

+ (NSArray*) poses;

@end
