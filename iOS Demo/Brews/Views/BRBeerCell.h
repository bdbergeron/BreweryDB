//
//  BRBeerCell.h
//  Brews
//
//  Created by Bradley Bergeron on 30/11/13.
//  Copyright (c) 2013 Bradley Bergeron. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark -
@interface BRBeerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *breweryLabel;
@property (nonatomic, weak) IBOutlet UIImageView *labelImageView;

@end
