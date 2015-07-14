//
//  ViewController.h
//  Yoga
//
//  Created by Brandon Gottfried on 6/6/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSString* appTitle;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *pagePreviews;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
