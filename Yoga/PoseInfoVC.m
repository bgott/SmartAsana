//
//  PoseInfoVC.m
//  Yoga
//
//  Created by Brandon Gottfried on 6/6/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "PoseInfoVC.h"
#import "PoseVC.h"

@interface PoseInfoVC ()

@end

@implementation PoseInfoVC

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
    
    [self.infoText setFont: [UIFont fontWithName:@"Skia-Regular" size:30.0]];
    [self.benefitsLabel setFont: [UIFont fontWithName:@"LittleSnorlax" size:50.0]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString* text = @"";
    NSArray* bullets = [[PoseInfoVC poseBenefits] objectForKey:self.poseName];
    for (NSString* str in bullets) {
        text = [text stringByAppendingString:str];
        text = [text stringByAppendingString:@"\n\n"];
    }
    self.infoText.text = text;
}

+ (NSDictionary*)poseBenefits
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* dictPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"dict.out"];
//    NSDictionary* mydict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    


    NSURL* url = [NSURL URLWithString:@"http://yogaxml.herokuapp.com"];
    NSDictionary* mydict = [NSDictionary dictionaryWithContentsOfURL:url];
    [mydict writeToFile:dictPath atomically:YES];
    
    return mydict;
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
