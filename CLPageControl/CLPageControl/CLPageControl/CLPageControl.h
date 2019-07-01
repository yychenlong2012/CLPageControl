//
//  CLPageControl.h
//  CLPageControl
//
//  Created by goat on 2019/6/29.
//  Copyright © 2019 3Pomelos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLPageControl;

@protocol ClPageControlDelegate <NSObject>
@optional
//点击point后触发
-(void)pageControl:(CLPageControl *)pageControl didSelectPointAtIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_BEGIN

@interface CLPageControl : UIControl

@property(nonatomic,weak) id<ClPageControlDelegate> delegate;

@property(nonatomic,assign) NSInteger numberOfPages;
@property(nonatomic,assign) NSInteger currentPage;

/*
 * 用于装饰pageControl的圆点，如不传则显示颜色，存放图片名
 */
@property(nonatomic,strong) NSArray *pageIndicatorImageArray;          //普通状态下的圆点图片
@property(nonatomic,strong) NSArray *currentPageIndicatorImageArray;   //当前选中的圆点图片

@property(nonatomic,strong) UIColor *pageIndicatorTintColor;           //普通状态下圆点的颜色
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;    //当前状态下圆点的颜色

/*
 * 用于控制圆点的大小，默认等高等宽且为3
 */
@property(nonatomic,assign) CGFloat pointWeight;          //圆点的宽度
@property(nonatomic,assign) CGFloat pointHeight;          //圆点的高度

/*
 * 是否裁剪圆角 默认为YES
 */
@property(nonatomic,assign) BOOL isCutPoint;
/*
 * 圆点之间的间隔 默认5
 */
@property(nonatomic,assign) CGFloat pointMargin;


@end

NS_ASSUME_NONNULL_END
