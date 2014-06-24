//
//  RadiusCell.m
//  Yelp
//
//  Created by Milan Amin on 6/19/14.
//  Copyright (c) 2014 Milan Amin. All rights reserved.
//

#import "RadiusCell.h"

@implementation RadiusCell

- (void)awakeFromNib
{
    _slider.minimumValue = RADIUS_MIN;
    _slider.maximumValue = RADIUS_MAX;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRadius:(NSInteger)radius {
    _radius = radius;
    _radiusLabel.text = [NSString stringWithFormat:@"%ld", (long)radius];
    _slider.value = radius;
}

- (IBAction)sliderValueChanged:(id)sender {
    UISlider * slider = (UISlider *)sender;
    float value = slider.value;
    [self setRadius:value];
    [self.delegate sliderValueChanged:value];
}
@end
