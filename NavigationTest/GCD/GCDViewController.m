//
//  GCDViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/15.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "GCDViewController.h"
#import "TideView.h"
#import "MBProgressHUD+Add.h"
@interface GCDViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) dispatch_semaphore_t  semaphore;
@property (nonatomic,strong) NSMutableArray *imgaes;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UIImage * mainImage;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) TideView * tideView;
@property (nonatomic,strong) UIButton * rightBtn;


@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.semaphore = dispatch_semaphore_create(1);
    self.view.backgroundColor = [UIColor yellowColor];
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2 + 100);
    self.scrollView.center = self.view.center;
    [self.scrollView addSubview:self.tideView];
    self.tideView.frame = self.scrollView.bounds;
    self.tideView.backgroundColor = [UIColor yellowColor];
    [self loadImages];
    self.scrollView.delegate = self;
    //设置最大伸缩比例
    _scrollView.maximumZoomScale=2.0;
    //设置最小伸缩比例
    _scrollView.minimumZoomScale=0.1;
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;

    [self.tideView setTileTag:@"bigimage_"];
    [self.tideView setTileDirectory:documentPath];
    [self.scrollView addSubview:self.tideView];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:(UIBarButtonItemStyleDone) target:self action:@selector(rigthAction:)];
    self.navigationItem.rightBarButtonItem = item;
    
}

//右上角按钮事件
-(void)rigthAction:(UIBarButtonItem*)item{
    MBProgressHUD * hud = [MBProgressHUD showMessag:@"" toView:self.view];
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString * imagePath = self.imgaes.firstObject;
    self.mainImage = [UIImage imageWithContentsOfFile:imagePath];
    for (int i = 1; i < self.imgaes.count; i++)
    {
        dispatch_group_async(group, queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSString * nextPath = self.imgaes[i];
            UIImage * nextimage = [UIImage imageWithContentsOfFile:nextPath];
            if (nextimage) {
                self.mainImage = [self combineWithLeftImg:self.mainImage rightImg:nextimage withMargin:0];
            }else{
                NSLog(@"未找到图片");
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                hud.label.text = [NSString stringWithFormat:@"拼接图片%d",i];
                hud.detailsLabel.text =  [NSString stringWithFormat:@"%@",NSStringFromCGSize(self.mainImage.size)];
            });
            dispatch_semaphore_signal(semaphore);
        });
    }
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    dispatch_group_async(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSData * data = UIImageJPEGRepresentation(self.mainImage, 1);
        NSString * newfile = [NSString stringWithFormat:@"%@/qaaa.jpg",documentPath];
        [data writeToFile:newfile options:(NSDataWritingFileProtectionMask) error:nil];
        [self saveTilesOfSize:(CGSize){256, 256} forImage:self.mainImage toDirectory:documentPath usingPrefix:@"bigimage_"];
        dispatch_semaphore_signal(semaphore);
        
    });
    
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        [hud hideShowSuccessWithMessage:[NSString stringWithFormat:@"完成 %@",NSStringFromCGSize(self.mainImage.size)]];
        CGSize newsize = CGSizeMake(self.mainImage.size.width * self.scrollView.frame.size.height / self.mainImage.size.height, self.scrollView.frame.size.height);
        self.scrollView.contentSize = newsize;
        self.tideView.titleWidth = (256 * self.scrollView.bounds.size.height )/self.mainImage.size.height;
        self.tideView.frame = CGRectMake(0, 0, newsize.width, newsize.height);
        self.mainImage = nil;
        [self.tideView setNeedsDisplay];
    });
    
    

}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.tideView.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.tideView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.tideView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.tideView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.tideView.frame.size.width) * 0.5 : 0;
    self.tideView.frame = frame;
    self.scrollView.contentSize = CGSizeMake(self.tideView.frame.size.width + 30, self.tideView.frame.size.height + 30);
}

//读取本地图片
-(void)loadImages{
    [self.imgaes removeAllObjects];
    //装载图片路径
    for (int i = 0; i<42; i++) {
        NSString * str = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"西狭颂%03d",i] ofType:@"jpg"];
        if (str!=nil) {
            [self.imgaes addObject:str];
        }
    }
    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.tideView;
}
- (UIImage *) combineWithLeftImg:(UIImage*)leftImage rightImg:(UIImage*)rightImage withMargin:(NSInteger)margin{
    if (rightImage == nil) {
        return leftImage;
    }
    CGSize leftSize = leftImage.size;
    CGSize rightNewSize = CGSizeMake(rightImage.size.width/rightImage.size.height * leftSize.height , leftSize.height);
    CGFloat width = leftImage.size.width + rightNewSize.width + margin;
    CGFloat height = leftImage.size.height;
    CGSize offScreenSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
    CGRect rectL = CGRectMake(0, 0, leftImage.size.width, height);
    [leftImage drawInRect:rectL];
    CGRect rectR = CGRectMake(rectL.origin.x + leftImage.size.width + margin, 0, rightNewSize.width, height);
    [rightImage drawInRect:rectR];
    UIImage * imagez = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    rightImage = nil;
    leftImage = nil;
    return imagez;
}

-(NSMutableArray *)imgaes{
    if (!_imgaes) {
        _imgaes = [[NSMutableArray alloc]init];
    }return _imgaes;
}

- (void)saveTilesOfSize:(CGSize)size
               forImage:(UIImage*)image
            toDirectory:(NSString*)directoryPath
            usingPrefix:(NSString*)prefix
{
 
    CGFloat cols = [image size].width / size.width;
    CGFloat rows = [image size].height / size.height;
    
    int fullColumns = floorf(cols);
    int fullRows = floorf(rows);
    
    CGFloat remainderWidth = [image size].width -
    (fullColumns * size.width);
    CGFloat remainderHeight = [image size].height -
    (fullRows * size.height);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    //开启图形上下文 将heView的所有内容渲染到图形上下文中
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:context];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    @autoreleasepool{
        for (int y = 0; y < fullRows; ++y) {
            for (int x = 0; x < fullColumns; ++x) {
                CGSize tileSize = size;
                if (x + 1 == fullColumns && remainderWidth > 0) {
                    // Last column
                    tileSize.width = remainderWidth;
                }
                if (y + 1 == fullRows && remainderHeight > 0) {
                    // Last row
                    tileSize.height = remainderHeight;
                }
                CGRect fra = (CGRect){{x*size.width, y*size.height},
                    tileSize};
                CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
                UIImage *sub = [UIImage imageWithCGImage:ref];
                CGImageRelease(ref);
                NSData *imageData = UIImagePNGRepresentation(sub);
                NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png",
                                  directoryPath, prefix, x, y];
                NSLog(@"************* path :%@",path);
                [imageData writeToFile:path atomically:NO];
                imageData = nil;
                sub = nil;
                
            }
        }
    }
    UIGraphicsEndImageContext();
}



-(TideView *)tideView{
    if (!_tideView) {
        _tideView = [[TideView alloc]init];
    }return _tideView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }return _scrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
