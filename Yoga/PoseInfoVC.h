//
//  PoseInfoVC.h
//  Yoga
//
//  Created by Brandon Gottfried on 6/6/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoseInfoVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *benefitsLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoText;

@property (strong, nonatomic) NSString* poseName;

+ (NSDictionary*) poseBenefits;

@end
