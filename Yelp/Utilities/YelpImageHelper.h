//
//  YelpImageHelper.h
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IMAGE_REQUEST_TIMEOUT 60

@interface YelpImageHelper : NSObject

+ (void)setImageWithURL:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage forView:(UIImageView *)imageView;

+ (UIImage *)placeHolderImageWithFrame:(CGRect)frame Color:(UIColor *)color;

@end
