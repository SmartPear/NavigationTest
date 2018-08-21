//
//  CustomCollectionViewCell.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/6.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CustomCollectionViewCell.h"
@interface CustomCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (nonatomic,strong)UILongPressGestureRecognizer * longPress;
@end
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.whiteView addGestureRecognizer:self.longPress];
    // Initialization code
}
- (IBAction)deleteAction:(UIButton *)sender {
    if (self.deleteAction) {
        self.deleteAction(self);
    }
}

//长按事件
- (void)longPressAction:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ( self.block) {
            self.block();
        }
    }
}

-(UILongPressGestureRecognizer *)longPress{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]init];
        _longPress.minimumPressDuration = 0.3;
        [_longPress addTarget:self action:@selector(longPressAction:)];
    }return _longPress;
}
@end
