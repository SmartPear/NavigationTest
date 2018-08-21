//
//  CiFilterView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/8/10.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "CiFilterView.h"
#import "CiFilterModel.h"
#import "CiFilterTableViewCell.h"

@interface CiFilterView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,CiFilterTableViewCellDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableDictionary * dict;
@property (nonatomic,strong)NSMutableArray * keys;
@property (nonatomic,strong)NSMutableArray * values;
@property (nonatomic,strong)NSMutableArray * models;


@end
@implementation CiFilterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
        [self makeGes];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }return self;
}

-(void)makeGes{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}


-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self animationClose];
}
//设置子视图
-(void)initSubViews{
    [self addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.6);
    }];
    
    [self layoutIfNeeded];
    
}
-(void)animationClose{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.6);
        make.top.equalTo(self.mas_bottom);
    }];

    [UIView animateWithDuration:0.25 animations:^{
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self == nil) {
            return ;
        }
        
    }];
}
-(void)ciFiltersliderValueChanged:(NSArray*)arr{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ciFiltersliderValueChanged:)]) {
        
        [self.delegate ciFiltersliderValueChanged:self.models];
    }
}


-(void)animationShowOnView:(UIView*)view{
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    [view layoutIfNeeded];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.6);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
       self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
   
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CiFilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CiFilterTableViewCell" forIndexPath:indexPath];
    CiFilterModel * model = self.models[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    return  cell;
}


-(UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"CiFilterTableViewCell" bundle:nil] forCellReuseIdentifier:@"CiFilterTableViewCell"];
        _tableView.delegate =self;
        _tableView.rowHeight = 50;
        _tableView.dataSource =self;
    }return _tableView;
}


-(NSMutableArray *)keys{
    if (!_keys) {
        _keys = [NSMutableArray arrayWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t", nil];
    }return _keys;
}
-(NSMutableArray *)values{
    if (!_values) {
        _values = [NSMutableArray arrayWithObjects:@(1.9f),@(-0.3f),@(-0.2f),@(-0.0f),@(-87.3f),@(-0.2f),@(1.7f),@(-0.1f),@(0.0f),@(-87.0f),@(-0.1f),@(-0.6f),@(2.0f),@(0.0f),@(87.0f),@(0.0f),@(0.0f),@(0.0f),@(0.0f),@(1.0f), nil];
    }return _values;
}
-(NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
        for (int i = 0; i < self.keys.count; i++) {
            CiFilterModel * model = [[CiFilterModel alloc]init];
            NSNumber * nvalue = self.values[i];
            CGFloat value = nvalue.floatValue;
            model.name = self.keys[i];
            model.currentValue = value;
            if (value == 0) {
                value = 1;
            }
            model.maxValue = value * 2;
            model.minValue = -value * 2;
            
         
            [_models addObject:model];
        }
    }return _models;
}
@end
