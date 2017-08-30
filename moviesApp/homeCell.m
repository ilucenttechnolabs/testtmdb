//
//  homeCell.m
//  moviesApp
//
//  Created by Bhavik Darji on 29/08/17.
//  Copyright © 2017 Maulik Patel. All rights reserved.
//

#import "homeCell.h"

@implementation homeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"ORGContainerCellView" owner:self options:nil][0];
        _collectionView.frame = self.bounds;
        [self.contentView addSubview:_collectionView];
    }
    return self;
}
- (void)setCollectionData:(NSArray *)collectionData
{
    [_collectionView setCollectionData:collectionData];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
