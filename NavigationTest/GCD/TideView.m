//
//  TideView.m
//  NavigationTest
//
//  Created by 王欣 on 2018/3/15.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "TideView.h"

@implementation TideView
@synthesize tileTag;
@synthesize tileDirectory;

+ layerClass
{
    return [CATiledLayer class];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return  nil;
    
    return self;
}
-(void)setTitleWidth:(CGFloat )titleWidth{
    _titleWidth = titleWidth;
    CATiledLayer * layer = (CATiledLayer*)self.layer;
    layer.tileSize = CGSizeMake(titleWidth, titleWidth);
}
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGSize tileSize = CGSizeMake(self.titleWidth, self.titleWidth);
    
    int firstCol = floorf(CGRectGetMinX(rect) / tileSize.width);
    int lastCol = floorf((CGRectGetMaxX(rect)-1) / tileSize.width);
    int firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    int lastRow = floorf((CGRectGetMaxY(rect)-1) / tileSize.height);
    
    for (int row = firstRow; row <= lastRow; row++) {
        for (int col = firstCol; col <= lastCol; col++) {
            UIImage *tile = [self tileAtCol:col row:row];
            
            if (!tile)
            {
                tile = [UIImage imageNamed:@"jj"];
            }
            __block   CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row,
                                                   tileSize.width, tileSize.height);
            dispatch_sync(dispatch_get_main_queue(), ^{
                tileRect = CGRectIntersection(self.bounds, tileRect);
            });
            
            
            [tile drawInRect:tileRect];
            [[UIColor redColor] set];
            CGContextSetLineWidth(ctx, 1.0);
            CGContextStrokeRect(ctx, tileRect);
        }
    }
}


- (UIImage*)tileAtCol:(int)col row:(int)row
{
    NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png", tileDirectory, tileTag, col, row];    
    return [UIImage imageWithContentsOfFile:path];
}


@end
