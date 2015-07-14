//
//  PageContentViewController.m
//  Yoga
//
//  Created by Brandon Gottfried on 6/6/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "PageContentViewController.h"
#import "ViewController.h"

@interface PageContentViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tutorialImage;

@end

@implementation PageContentViewController

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
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.tutorialImage.image = [UIImage imageNamed:self.previewImg];
    self.titleLabel.text = self.titleText;
    self.headingLabel.text = self.headingText;
    [[self titleLabel] setFont:[UIFont fontWithName:@"Skia-Regular" size:30.0]];
    [[self headingLabel] setFont:[UIFont fontWithName:@"LittleSnorlax" size:145.0]];
    self.headingLabel.textColor = [UIColor colorWithRed:(float)0 green:(float)255/255 blue:(float)153/255 alpha:1.0];
    //self.titleLabel.textColor = [UIColor colorWithRed:((float)255/255) green:((float)51/255) blue:((float)102/255) alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
