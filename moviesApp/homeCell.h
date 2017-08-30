//
//  homeCell.h
//  moviesApp
//
//  Created by Bhavik Darji on 29/08/17.
//  Copyright © 2017 Maulik Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORGContainerCellView.h"
@interface homeCell : UITableViewCell

@property (strong, nonatomic) ORGContainerCellView *collectionView;

- (void)setCollectionData:(NSArray *)collectionData;

@end
