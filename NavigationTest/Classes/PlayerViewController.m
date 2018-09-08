//
//  AVPlayerViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/23.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVKit/AVKit.h>
@interface PlayerViewController ()
@property (nonatomic,strong)AVPlayer * player;
@property (nonatomic,strong)AVPlayerLayer * playeLayer;
@property (nonatomic,strong)AVPlayerItem * item;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.playeLayer];
    self.playeLayer.player = self.player;
    self.playeLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9/16);
    self.playeLayer.backgroundColor = [UIColor purpleColor].CGColor;
    [self.player replaceCurrentItemWithPlayerItem:self.item];
    [self addObserVer];
    NSLog(@"%@",self.player.currentItem);
    [self.player play];
    
    
    // Do any additional setup after loading the view.
}
-(void)addObserVer{
    if (self.item){
        [self.item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil ];
    }
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self.player play];
    NSLog(@"%@",change);
}
-(void)dealloc{
    if (self.item) {
        [self.item removeObserver:self forKeyPath:@"status"];
    }
    
}
-(AVPlayer *)player{
    if(!_player){
        _player = [[AVPlayer alloc]init];
    }return _player;
}
-(AVPlayerItem *)item{
    if(!_item){
        NSString * path = [[NSBundle mainBundle]pathForResource:@"十" ofType:@"mp4"];
        AVPlayerItem * tiem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:path]];
        _item = tiem;
    }return _item;
}
-(AVPlayerLayer *)playeLayer{
    if(!_playeLayer){
        _playeLayer = [AVPlayerLayer layer];
    }return _playeLayer;
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
