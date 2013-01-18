//
//  PaintView.m
//  MyPaint
//
//  Created by Tam Tran Swink on 1/18/13.
//  Copyright (c) 2013 tpham. All rights reserved.
//

#import "PaintView.h"

@implementation PaintView
{
    CGFloat hue;
    void *cacheBitmap;
    CGContextRef cacheContext;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        hue = 0.0;
        [self initContext:frame.size];
    }
    return self;
}

- (void)initContext:(CGSize)size {
    int bitmapByteCount;
    int bitmapBytesPerRow;
    bitmapBytesPerRow = size.width * 4;
    bitmapByteCount = bitmapBytesPerRow * size.height;
    
    cacheBitmap = malloc(bitmapByteCount);
    if (cacheBitmap == NULL) return;
    cacheContext = CGBitmapContextCreate(cacheBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self drawToCache:touch];
}

- (void)drawToCache:(UITouch*)touch {
    hue += 0.005;
    if (hue > 1.0) hue = 0.0;
    UIColor *color = [UIColor colorWithHue:hue saturation:0.7 brightness:1.0 alpha:1.0];
    
    CGContextSetStrokeColorWithColor(cacheContext, [color CGColor]);
    CGContextSetLineCap(cacheContext, kCGLineCapRound);
    CGContextSetLineWidth(cacheContext, 15);
    
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGPoint newPoint = [touch locationInView:self];
    
    CGContextMoveToPoint(cacheContext, lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(cacheContext, newPoint.x, newPoint.y);
    CGContextStrokePath(cacheContext);
    
    CGRect dirtyPoint1 = CGRectMake(lastPoint.x-10, lastPoint.y-10, 20, 20);
    CGRect dirtyPoint2 = CGRectMake(newPoint.x-10, newPoint.y-10, 20, 20);
    [self setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];
}

// /*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(cacheContext);
    CGContextDrawImage(context, self.bounds, cacheImage);
    CGImageRelease(cacheImage);
}
// */

- (void)clearScreen {
    CGContextClearRect(cacheContext, self.frame);
    [self setNeedsDisplay];
}

@end
