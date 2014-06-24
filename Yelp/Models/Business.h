//
//  Business.h
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * imageURL;
@property (nonatomic, strong) NSString * ratingImgURL;
@property (nonatomic) NSInteger reviewCount;
@property (nonatomic, strong) NSString * displayAddress;
@property (nonatomic) CGFloat distance;
@property (nonatomic, strong) NSMutableArray * categories;

+ (NSArray *)businessesWithData:(id)data;
- (NSString *)distanceString;
- (NSString *)reviewCountString;
- (NSString *)categoriesString;

@end
