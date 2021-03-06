//
//  Business.m
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import "Business.h"

@implementation Business

+ (NSArray *)businessesWithData:(id)data {
    NSMutableArray * businesses = [[NSMutableArray alloc] init];
    for (NSDictionary * entry in data[@"businesses"]) {
        Business * business = [[Business alloc] init];
        business.name = entry[@"name"];
        business.imageURL = entry[@"image_url"];
        business.ratingImgURL = entry[@"rating_img_url"];
        business.reviewCount = [entry[@"review_count"] floatValue];
        business.distance = [entry[@"distance"] floatValue];

        NSMutableArray * address = [entry[@"location"][@"display_address"] mutableCopy];
        if (address.count > 0) {
            [address removeObjectAtIndex:address.count-1];
        }
        business.displayAddress = [address componentsJoinedByString:@", "];

        
        NSArray * categories = entry[@"categories"];
        business.categories = [[NSMutableArray alloc] init];
        for (NSArray * category in categories) {
            [business.categories addObject:category[0]];
        }

        [businesses addObject:business];
    }
    return businesses;
}

- (NSString *)reviewCountString {
    NSString * review = (_reviewCount > 1) ? @"Reviews" : @"Review";
    return [NSString stringWithFormat:@"%ld %@", (long)_reviewCount, review];
}

- (NSString *)categoriesString {
    return [_categories componentsJoinedByString:@", "];
}

- (NSString *)distanceString {
    return [NSString stringWithFormat:@"%.2f mi", _distance];
}

@end
