//
//  ViewController.m
//  CLPageControl
//
//  Created by goat on 2019/6/29.
//  Copyright © 2019 3Pomelos. All rights reserved.
//

#import "ViewController.h"
#import "CLPageControl.h"

@interface ViewController ()<ClPageControlDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CLPageControl *page = [CLPageControl new];
    page.delegate = self;
    page.numberOfPages = 7;
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pointHeight = 20;
    page.pointWeight = 20;
    page.currentPage = 1;
    page.pointMargin = 10;
//    page.pageIndicatorImageArray = @[@"normal",@"normal",@"normal",@"normal",@"normal",@"normal",@"normal"];
//    page.currentPageIndicatorImageArray = @[@"select",@"select",@"select",@"select",@"select",@"select",@"select"];
    page.frame = CGRectMake(50, 50, 10*7+10*6, 20);
    [self.view addSubview:page];
    
   
}


-(void)pageControl:(CLPageControl *)pageControl didSelectPointAtIndex:(NSInteger)index{
    NSLog(@"点击%ld",(long)index);
}

@end
