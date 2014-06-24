//
//  YelpImageHelper.m
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import "YelpImageHelper.h"
#import "UIImageView+AFNetworking.h"

@implementation YelpImageHelper

+ (void)setImageWithURL:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage forView:(UIImageView *)imageView {
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:IMAGE_REQUEST_TIMEOUT];
     [imageView setImageWithURLRequest:request
                       placeholderImage:placeHolderImage
                                success:nil
                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  
     }];
}

// generate place holder image
+ (UIImage *)placeHolderImageWithFrame:(CGRect)frame Color:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    [color setFill];
    UIRectFill(frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
