//
//  CiFilterTableViewCell.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CiFilterTableViewCell.h"

@implementation CiFilterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(CiFilterModel *)model{
    _model = model;
    self.keyLab.text = model.name;
    self.valueLab.text = [NSString stringWithFormat:@"%.2lf",model.currentValue];
    self.slider.value = model.currentValue/model.maxValue;
    self.slider.maximumValue = 1.0;
    self.slider.minimumValue = 0.0;
}
- (IBAction)valueChanged:(UISlider*)sender {
    self.model.currentValue = (sender.value / sender.maximumValue) * self.model.maxValue;
    self.valueLab.text = [NSString stringWithFormat:@"%.2lf",self.model.currentValue];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ciFiltersliderValueChanged:)]) {
        [self.delegate ciFiltersliderValueChanged:nil];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
