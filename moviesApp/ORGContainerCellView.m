//
//  ORGContainerCellView.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "ORGContainerCellView.h"
#import "ORGArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@interface ORGContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end

@implementation ORGContainerCellView

- (void)awakeFromNib {

    self.collectionView.backgroundColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 220);
    [self.collectionView setCollectionViewLayout:flowLayout];

    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData
{
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORGArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ORGArticleCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    cell.articleTitle.text = [cellData objectForKey:@"title"];
    
    NSString *path=[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w185//%@",[cellData objectForKey:@"poster_path"]];
    NSLog(@"path == %@",path);
    cell.imageMovie.imageURL=[NSURL URLWithString:path];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // retrive image on global queue
//        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:path]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            // assign cell image on main thread
//         //   cell.imageMovie.image = img;
//        });
//    });
//    [cell.imageMovie sd_setImageWithURL:[NSURL URLWithString:path]];
  // cell.imageMovie.image=[UIImage imageNamed:@"800px_COLOURBOX17174300.jpg"];
//    AsyncImageView *im=[[AsyncImageView alloc]init];
//    im.frame=CGRectMake(0, 0, 100, 100);
//    im.imageURL=[NSURL URLWithString:@"https://image.tmdb.org/t/p/w185/q0R4crx2SehcEEQEkYObktdeFy.jpg"];
//    im.backgroundColor=[UIColor redColor];
//    [cell.contentView addSubview:im];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}


@end
