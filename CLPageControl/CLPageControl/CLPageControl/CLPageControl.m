//
//  CLPageControl.m
//  CLPageControl
//
//  Created by goat on 2019/6/29.
//  Copyright © 2019 3Pomelos. All rights reserved.
//

#import "CLPageControl.h"

@implementation CLPageControl{
    NSMutableArray <UIImageView *>*_pointArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pointArray = [NSMutableArray array];
        
        //设置默认值
        _numberOfPages = 0;
        _currentPage = 0;
        _pageIndicatorTintColor = [UIColor whiteColor];
        _currentPageIndicatorTintColor = [UIColor grayColor];
        _pointHeight = 3;
        _pointWeight = 3;
        _isCutPoint = YES;
        _pointMargin = 5;
        
    }
    return self;
}

-(void)setNumberOfPages:(NSInteger)numberOfPages{
    if (_numberOfPages == numberOfPages) {
        return;
    }
    _numberOfPages = numberOfPages;
    [self createPoint];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    
    if (_pointArray.count == 0) {
        [self createPoint];
    }else{
        //切换到当前页
        for (NSInteger i = 0; i<_pointArray.count; i++) {
            UIImageView *point = _pointArray[i];
            if (i == currentPage) {  //当前页
                if (i < self.currentPageIndicatorImageArray.count) {  //表示有图片
                    point.image = [UIImage imageNamed:self.currentPageIndicatorImageArray[i]];
                    point.backgroundColor = [UIColor clearColor];
                }else{
                    point.image = nil;
                    point.backgroundColor = self.currentPageIndicatorTintColor;
                }
            }else{
                if (i < self.pageIndicatorImageArray.count) {
                    point.image = [UIImage imageNamed:self.pageIndicatorImageArray[i]];
                    point.backgroundColor = [UIColor clearColor];
                }else{
                    point.image = nil;
                    point.backgroundColor = self.pageIndicatorTintColor;
                }
            }
        }
    }
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    if ([self compareColor:_pageIndicatorTintColor anotherColor:pageIndicatorTintColor]) {
        return;
    }
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    //如果设置了图片则忽略颜色
    if (self.pageIndicatorImageArray == nil) {
        [self createPoint];
    }
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    if ([self compareColor:_currentPageIndicatorTintColor anotherColor:currentPageIndicatorTintColor]) {
        return;
    }
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self createPoint];
}

-(void)setPageIndicatorImageArray:(NSArray *)pageIndicatorImageArray{
    _pageIndicatorImageArray = pageIndicatorImageArray;
    [self createPoint];
}

-(void)setCurrentPageIndicatorImageArray:(NSArray *)currentPageIndicatorImageArray{
    _currentPageIndicatorImageArray = currentPageIndicatorImageArray;
    [self createPoint];
}

-(void)setPointHeight:(CGFloat)pointHeight{
    if (_pointHeight == pointHeight) {
        return;
    }
    _pointHeight = pointHeight;
    [self createPoint];
}

-(void)setPointWeight:(CGFloat)pointWeight{
    if (_pointWeight == pointWeight) {
        return;
    }
    _pointWeight = pointWeight;
    [self createPoint];
}

-(void)setPointMargin:(CGFloat)pointMargin{
    if (_pointMargin == pointMargin) {
        return;
    }
    _pointMargin = pointMargin;
    [self createPoint];
}

-(void)setIsCutPoint:(BOOL)isCutPoint{
    if (_isCutPoint == isCutPoint) {
        return;
    }
    _isCutPoint = isCutPoint;
    if (_pointArray.count == 0) {
        [self createPoint];
    }else{
        //改变圆角
        if (isCutPoint) {
            for (UIImageView *point in _pointArray) {
                CAShapeLayer *mask = [CAShapeLayer layer];
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:point.bounds cornerRadius:self.pointHeight/2.0];
                mask.path = path.CGPath;
                point.layer.mask = mask;
            }
        }else{
            for (UIImageView *point in _pointArray) {
                point.layer.mask = nil;
            }
        }
    }
}


-(void)createPoint{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_pointArray removeAllObjects];
    
    if (self.numberOfPages == 0) {
        return;
    }
    
    if (self.pointHeight == 0 || self.pointWeight == 0) {
        return;
    }
    
    for (NSInteger i = 0; i<self.numberOfPages; i++) {
        UIImageView *point = [UIImageView new];
        point.tag = i;
        
        //设置图片或者颜色
        if (i == self.currentPage) {   //当前页
            if (i < self.currentPageIndicatorImageArray.count) {  //表示有图片
                point.image = [UIImage imageNamed:self.currentPageIndicatorImageArray[i]];
                point.backgroundColor = [UIColor clearColor];
            }else{
                point.image = nil;
                point.backgroundColor = self.currentPageIndicatorTintColor;
            }
            
        }else{
            
            if (i < self.pageIndicatorImageArray.count) {
                point.image = [UIImage imageNamed:self.pageIndicatorImageArray[i]];
                point.backgroundColor = [UIColor clearColor];
            }else{
                point.image = nil;
                point.backgroundColor = self.pageIndicatorTintColor;
            }
        }
        
        //设置点击事件
        point.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointClick:)];
        [point addGestureRecognizer:tap];
        
        //设置圆点尺寸
        point.frame = CGRectMake((self.pointMargin + self.pointWeight)*i, 0, self.pointWeight, self.pointHeight);
        //设置圆角
        if (self.isCutPoint) {
            CAShapeLayer *mask = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:point.bounds cornerRadius:self.pointHeight/2.0];
            mask.path = path.CGPath;
            point.layer.mask = mask;
        }
        
        [self addSubview:point];
        [_pointArray addObject:point];
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.pointWeight*self.numberOfPages + self.pointMargin*(self.numberOfPages-1), self.pointHeight);
}


//比较两个颜色是否相同
-(BOOL)compareColor:(UIColor*)color1 anotherColor:(UIColor*)color2{
    if (CGColorEqualToColor(color1.CGColor, color2.CGColor)) {
        return YES;
    }else {
        return NO;
    }
}

-(void)layoutSubviews{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.pointWeight*self.numberOfPages + self.pointMargin*(self.numberOfPages-1), self.pointHeight);
}


-(void)pointClick:(UIGestureRecognizer *)ges{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageControl:didSelectPointAtIndex:)]) {
        [self.delegate pageControl:self didSelectPointAtIndex:ges.view.tag];
    }
}


@end
