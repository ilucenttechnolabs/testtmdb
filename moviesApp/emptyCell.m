//
//  emptyCell.m
//  moviesApp
//
//  Created by Bhavik Darji on 29/08/17.
//  Copyright © 2017 Maulik Patel. All rights reserved.
//

#import "emptyCell.h"

@implementation emptyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.view_content.layer.cornerRadius=6;
    self.view_content.clipsToBounds=YES;
    self.view_content.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.view_content.layer.borderWidth=1;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
