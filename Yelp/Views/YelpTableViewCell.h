//
//  YelpTableViewCell.h
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface YelpTableViewCell : UITableViewCell

@property (nonatomic, strong) Business * business;

- (void)setBusiness:(Business *)business;

@end
