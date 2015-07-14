//
//  PoseVC.m
//  Yoga
//
//  Created by Brandon Gottfried on 6/2/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "PoseVC.h"
#import "PoseInfoVC.h"

#define MAX_FAVORITES 27

@interface PoseVC () <UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UISwitch *translateSwitch;

@property (weak, nonatomic) IBOutlet UIButton *favButton;

//@property (nonatomic) BOOL isFavorited;

@end

@implementation PoseVC

- (IBAction)translate:(id)sender {
    if ([self.translateSwitch isOn]) {
        self.label.text = [[PoseVC sanskrit] objectForKey:self.poseName];
    } else {
        self.label.text = [self poseName];
    }
}

- (IBAction)favorited:(id)sender {
    self.favButton.selected = !self.favButton.isSelected;
    if (!self.favButton.isSelected) return;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *favorites = [standardUserDefaults arrayForKey:@"Favorites"];
    
    NSMutableArray *updatedFavorites;
    if ([favorites containsObject:self.thumbnailName]) {
        return;
//        updatedFavorites = [[NSMutableArray alloc] init];
//        for (NSString* thumb in favorites) {
//            if (![thumb isEqualToString:self.thumbnailName])
//                [updatedFavorites addObject:thumb];
//            
//        }
    } else {
        updatedFavorites = [[NSMutableArray alloc] initWithObjects:self.thumbnailName, nil];
        if (favorites) {
            if ([favorites count] < MAX_FAVORITES) {
                [updatedFavorites addObjectsFromArray:favorites];
            } else {
                NSRange top = {0, [favorites count]};
                NSArray *first = [favorites subarrayWithRange:top];
                [updatedFavorites addObjectsFromArray:first];
            }
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:updatedFavorites forKey:@"Favorites"];
    [standardUserDefaults synchronize];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.imageView.image = [self poseImage];
    self.label.text = [self poseName];
    
    [self.favButton setTitle:@"☆" forState:UIControlStateNormal];
    [self.favButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    self.favButton.titleLabel.font = [UIFont fontWithName:@"Skia-Regular" size:40.0];
    self.favButton.adjustsImageWhenHighlighted = NO;
    
    [self.favButton setTitle:@"★" forState:UIControlStateSelected];
    [self.favButton setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [self.favButton setBackgroundImage:nil forState:UIControlStateSelected];
    
    [[self label] setFont:[UIFont fontWithName:@"Skia-Regular" size:50.0]];
    self.label.textColor = [UIColor colorWithRed:(float)0 green:(float)255/255 blue:(float)153/255 alpha:1.0];
    [self.translateSwitch setTintColor:[UIColor colorWithRed:(float)0 green:(float)255/255 blue:(float)153/255 alpha:1.0] ];
        [self.translateSwitch setOnTintColor:[UIColor colorWithRed:(float)0 green:(float)255/255 blue:(float)153/255 alpha:1.0] ];
//    [self.translateSwitch setThumbTintColor:  [UIColor colorWithRed:((float)255/255) green:((float)51/255) blue:((float)102/255) alpha:1.0]];
    
    [self.translateSwitch setOn:NO];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *favorites = [standardUserDefaults arrayForKey:@"Favorites"];
    if ([favorites containsObject:self.thumbnailName]) {
        [self favorited:self.favButton];
    }

}


#pragma mark - View Controller Lifecycle

//- (void)awakeFromNib
//{
//    self.splitViewController.delegate = self;
//    // see UISplitViewControllerDelegate methods below
//}

#pragma mark - Properties

//- (UIImageView *)imageView
//{
//    if (!_imageView) _imageView = [[UIImageView alloc] init];
//    return _imageView;
//}

// image property does not use an _image instance variable
// instead it just reports/sets the image in the imageView property
// thus we don't need @synthesize even though we implement both setter and getter

//- (UIImage *)image
//{
//    return self.imageView.image;
//}

//- (void)setImage:(UIImage *)image
//{
//    // self.scrollView could be nil here if outlet-setting has not happened yet
//    self.scrollView.zoomScale = 1;
//    self.scrollView.contentSize = image ? image.size : CGSizeZero;
//    
//    self.imageView.image = image; // does not change the frame of the UIImageView
//    [self.imageView sizeToFit];   // update the frame of the UIImageView
////    self.imageView.center = [self.scrollView center];
//}

//- (void)setScrollView:(UIScrollView *)scrollView
//{
//    _scrollView = scrollView;
//    
//    // next three lines are necessary for zooming
//    _scrollView.minimumZoomScale = 0.2;
//    _scrollView.maximumZoomScale = 2.0;
//    _scrollView.delegate = self;
//    
//    // next line is necessary in case self.image gets set before self.scrollView does
//    // for example, prepareForSegue:sender: is called before outlet-setting phase
//    self.scrollView.contentSize = self.poseImage ? self.poseImage.size : CGSizeZero;
//}

#pragma mark - UIScrollViewDelegate

// mandatory zooming method in UIScrollViewDelegate protocol

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return self.imageView;
//}

+ (NSArray*)poses
{
    return @[@"Standing Deep Breathing", @"Standing Deep Breathing II", @"Half Moon", @"Awkward Pose", @"Eagle Pose", @"Standing Head to Knee", @"Standing Bow Pose", @"Balancing Stick", @"Standing Separate Leg Stretching Pose", @"Triangle Pose", @"Standing Separate Leg Head to Knee Pose", @"Tree Pose", @"Toe Stand", @"Dead Body Pose", @"Wind Removing Pose", @"Situp", @"Cobra Pose", @"Locust Pose", @"Full Locust Pose", @"Bow Pose", @"Fixed Firm Pose", @"Half Tortoise Pose", @"Camel Pose", @"Rabbit Pose", @"Head to Knee Streching Pose", @"Spine Twisting Pose", @"Blowing Firm Pose"];
}

+ (NSDictionary*)sanskrit
{
    NSArray* sanskrit = @[@"Pranayama I", @"Pranayama II", @"Ardha Chandrasana", @"Utkatasana", @"Garurasana",
                                                   @"Dandayamana – JanuShirasana", @"Dandayamana – Dhanuraiana", @"Tuladandasana",
                                                   @"Dandytamana – Bibhaktaeada – Paschimottanasana", @"Trikanasana", @"Dandayamana – Bibhaktapada – Janushirasana", @"Tadasana", @"Padangustasana", @"Savasana",
                                                   @"Pavanamuktasana", @"Sit Up", @"Bhujangasana", @"Salabhasana", @"Poorna – Salabhasana",
                                                   @"Dhanurasana", @"Supta – Vajrasana", @"Ardha – Kurmasana", @"Ustrasana",
                                                   @"Sasangasana", @"Janushirasana with Paschimottanasana", @"Ardha – Matsyendrasana",
                                                   @"Kapalbhati in Vajrasana"];

    NSDictionary* dict =  [NSDictionary dictionaryWithObjects:sanskrit forKeys:[PoseVC poses] ];
    NSLog(@"translate dict : %@", dict);
    
    return dict;
}


#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    self.navigationItem.leftBarButtonItem = barButtonItem;
    barButtonItem.title = aViewController.title;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
    //self.navigationItem.leftBarButtonItem = barButtonItem;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PoseInfo"]) {
        PoseInfoVC *pivc = (PoseInfoVC *)segue.destinationViewController;
        pivc.poseName = [self poseName];
    }
}


@end
