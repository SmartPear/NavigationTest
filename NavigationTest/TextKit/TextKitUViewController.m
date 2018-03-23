//
//  TextKitUViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/5.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "TextKitUViewController.h"

@interface TextKitUViewController ()<NSLayoutManagerDelegate>
@property (nonatomic,strong) UITextView * textView;
@property (nonatomic,strong) NSLayoutManager * lManger;
@property (nonatomic,strong) NSTextContainer * textContainer;


@end

@implementation TextKitUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textView];
    [self.lManger addTextContainer:self.textContainer];
    [self.textView.textStorage addLayoutManager:self.lManger];
    // Do any additional setup after loading the view.
}
//
-(void)layoutManagerDidInvalidateLayout:(NSLayoutManager *)sender{
    
    NSLog(@"%@",sender);
}

-(NSLayoutManager *)lManger{
    if (!_lManger) {
        _lManger = [[NSLayoutManager alloc]init];
        _lManger.delegate  = self;
    }return _lManger;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.frame = CGRectMake(0, 0, 300, 300);
        _textView.center = self.view.center;
    }return _textView;
}
-(NSTextContainer *)textContainer{
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc]initWithSize:CGSizeMake(300, 300)];
    }return _textContainer;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
