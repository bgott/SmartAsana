//
//  YogaViewController.m
//  Yoga
//
//  Created by Brandon Gottfried on 5/28/14.
//  Copyright (c) 2014 cs193p. All rights reserved.
//

#import "YogaViewController.h"
#import "PoseVC.h"
#import "PoseCollectionViewCell.h"
#import "PoseController.h"
#import "CollectionHeader.h"

@interface YogaViewController ()

@property (strong, nonatomic) NSMutableArray *poseThumbnails; //NSString
@property (strong, nonatomic) NSDictionary *thumbnailToPose;

@end

@implementation YogaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated
{
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    [standardUserDefaults synchronize];
    [self.collectionView reloadData];
    
}


#define NUM_THUMBNAILS 27

// Lazy instantiation for names of thumbnails
- (NSMutableArray *)poseThumbnails {
    if (!_poseThumbnails) {
        _poseThumbnails = [[NSMutableArray alloc] init];
        for (int i = 1; i <= NUM_THUMBNAILS; i++) {
            [_poseThumbnails addObject:[NSString stringWithFormat:@"pose%d", i]];
        }
    }
    return _poseThumbnails;
}

#pragma mark - DataSource methods

// OPTIONAL: Number of sections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

// REQUIRED: Number of items in section. (Number of thumbnails)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1)
        return self.poseThumbnails.count;
    else {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults synchronize];
        NSArray *favorites = [standardUserDefaults arrayForKey:@"Favorites"];
        
        return [favorites count];
    }
}

// REQUIRED: Set up each cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PoseCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"poseCell" forIndexPath:indexPath];
    
    if (!myCell)
        myCell = [[PoseCollectionViewCell alloc] init];
    if (indexPath.section == 1) {
        myCell.imageView.image = [UIImage imageNamed:self.poseThumbnails[indexPath.row]];
    } else {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//        [standardUserDefaults synchronize];
        NSArray *favorites = [standardUserDefaults arrayForKey:@"Favorites"];
        myCell.imageView.image = [UIImage imageNamed:favorites[indexPath.row]];
    }
    return myCell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.label.textColor = [UIColor whiteColor];
        headerView.label.font = [UIFont fontWithName:@"Skia-Regular" size:30.0];
        if (indexPath.section == 0) headerView.label.text = @"Favorites";
        else headerView.label.text = @"Asanas";
        
        reusableview = headerView;
    }
    return reusableview;
}


#pragma mark - Navigation

// Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get indexPath for the selected cell
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[PoseCollectionViewCell class]]) {
        indexPath = [self.collectionView indexPathForCell:sender];
    }
    
    // Set up destination view controller
    id destVC = segue.destinationViewController;
    if (indexPath && [destVC isKindOfClass:[PoseVC class]]) {
        if ([segue.identifier isEqualToString:@"viewPose"]) {
            PoseVC *detailVC = (PoseVC *)destVC;
//            detailVC.poseImage = [UIImage imageNamed:self.poseThumbnails[indexPath.row]];
            if (indexPath.section == 1) {
                detailVC.poseName = [PoseVC poses][indexPath.row];
                detailVC.poseImage = [UIImage imageNamed:self.poseThumbnails[indexPath.row]];
                detailVC.thumbnailName = self.poseThumbnails[indexPath.row];
            } else {
                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
                NSArray *favorites = [standardUserDefaults arrayForKey:@"Favorites"];
                detailVC.poseImage = [UIImage imageNamed:favorites[indexPath.row]];
                detailVC.thumbnailName = favorites[indexPath.row];
                detailVC.poseName = [self.thumbnailToPose objectForKey:detailVC.thumbnailName];
            }
        }
    }
}

- (NSDictionary*)thumbnailToPose
{
    NSDictionary* dict = [[NSDictionary alloc] initWithObjects:[PoseVC poses] forKeys:[self poseThumbnails] ];
    return dict;
}

@end
