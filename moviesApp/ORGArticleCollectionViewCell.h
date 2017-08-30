//
//  ORGArticleCollectionViewCell.h
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/23/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface ORGArticleCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *view_Content;
@property (weak) IBOutlet UILabel *articleTitle;
@property (strong, nonatomic) IBOutlet AsyncImageView *image;
@property (strong, nonatomic) IBOutlet AsyncImageView *imageMovie;


@end
