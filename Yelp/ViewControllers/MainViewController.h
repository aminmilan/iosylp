//
//  MainViewController.h
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "UIColor+Yelp.h"
#import "YelpClient.h"
#import "Business.h"
#import "YelpTableViewCell.h"
#import "FiltersViewController.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate, FiltersViewControllerDelegate>

@end
