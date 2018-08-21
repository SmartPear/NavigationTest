//
//  CiFilterTableViewCell.h
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CiFilterModel.h"
@protocol CiFilterTableViewCellDelegate<NSObject>
-(void)ciFiltersliderValueChanged:(NSArray*)arr;
@end
@interface CiFilterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *keyLab;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic,strong)CiFilterModel * model;
@property (nonatomic,weak)id<CiFilterTableViewCellDelegate>delegate;
@end
