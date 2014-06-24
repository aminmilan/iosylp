//
//  YelpCategories.h
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CATEGORIES_TEXT_FILE @"categories.txt"

@interface YelpCategories : NSObject

/*
 key is the human readable category, value is the category_filter
 */
+(NSDictionary *)categoriesDict;
+(NSArray *)categories;

@end
