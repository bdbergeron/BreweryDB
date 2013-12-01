//
//  BRBeerCell.m
//  Brews
//
//  Created by Bradley Bergeron on 30/11/13.
//  Copyright (c) 2013 Bradley Bergeron. All rights reserved.
//

#import "BRBeerCell.h"


#pragma mark -
@implementation BRBeerCell

- (void)awakeFromNib
{
    self.labelImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.labelImageView.layer.masksToBounds = YES;
    self.labelImageView.layer.cornerRadius = self.labelImageView.frame.size.width / 2.0;
    self.labelImageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.labelImageView.layer.shouldRasterize = YES;
    self.labelImageView.clipsToBounds = YES;

    [self prepareForReuse];

}

- (void)prepareForReuse
{
    self.nameLabel.text = nil;
    self.breweryLabel.text = nil;
    self.labelImageView.image = nil;
}

@end
