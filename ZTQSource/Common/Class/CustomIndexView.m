//
//  CustomIndexView.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/21.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "CustomIndexView.h"
@interface CustomIndexView(){
    BOOL isLayedOut;
    CGFloat fontSize;
}


@property (nonatomic, strong) NSArray *letters;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat letterHeight;
@property (nonatomic, assign) CGPoint startPoint;

@end
@implementation CustomIndexView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
         if (frame.size.height > 480) {
            self.letterHeight = 14;
            fontSize = 12;
        } else {
            self.letterHeight = 12;
            fontSize = 11;
        }
    }
    return self;
}
- (void)reloadData{
    self.letters = [_delegate tableViewIndexTitle:self];
    self.indexes = [_delegate tableViewIndexTitle:self];
    isLayedOut = NO;
    [self layoutSubviews];

}
- (void)setup{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineWidth = 1.0f;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.lineJoin = kCALineCapSquare;
    _shapeLayer.strokeColor = [[UIColor clearColor] CGColor];
    _shapeLayer.strokeEnd = 1.0f;
    self.layer.masksToBounds = NO;
}

//- (void)setTableViewIndexDelegate:(id<indexDelegate>)tableViewIndexDelegate
//{
//    _delegate = tableViewIndexDelegate;
//    self.letters = [_delegate tableViewIndexTitle:self];
//    isLayedOut = NO;
//    [self layoutSubviews];
//}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setup];
    
    if (!isLayedOut){
        
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        _shapeLayer.frame = CGRectMake(0, (CGRectGetHeight(self.frame) - (self.indexes.count * self.letterHeight)) / 2, CGRectGetWidth(self.layer.frame), self.indexes.count * self.letterHeight);
        _startPoint = _shapeLayer.frame.origin;
//        _shapeLayer.backgroundColor = [UIColor redColor].CGColor;
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, CGRectGetHeight(self.frame) - (self.indexes.count * self.letterHeight))];
        
        [self.letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * self.letterHeight;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, self.letterHeight)];
            [_shapeLayer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        
        _shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:_shapeLayer];
        
        isLayedOut = YES;
    }
}

- (void)reloadLayout:(UIEdgeInsets)edgeInsets
{
    CGRect rect = self.frame;
    rect.size.height = self.indexes.count * self.letterHeight;
    rect.origin.y = edgeInsets.top + ([self superview].bounds.size.height - edgeInsets.top - edgeInsets.bottom - rect.size.height) / 2;
    self.frame = rect;
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setFont:@"ArialMT"];
    [textLayer setFontSize:size];
    [textLayer setFrame:frame];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [textLayer setForegroundColor:_indexColor ? _indexColor.CGColor:[UIColor blueColor].CGColor];
    [textLayer setString:string];
    return textLayer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendEventToDelegate:event];
    [self.delegate tableViewIndexTouchesBegan:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendEventToDelegate:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.delegate tableViewIndexTouchesEnd:self];
}

- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger indx = ((NSInteger) floorf(point.y - _startPoint.y) / self.letterHeight);
    
    if (indx< 0 || indx > self.letters.count - 1) {
        return;
    }
    
    [self.delegate tableViewIndex:self didSelectSectionAtIndex:indx withTitle:self.letters[indx]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
