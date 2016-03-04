//
//  ViewController.m
//  MDFDividerView
//
//  Created by WuYikai on 16/3/3.
//  Copyright © 2016年 secoo. All rights reserved.
//

#import "ViewController.h"
#import "MDFDividerView.h"

@interface ViewController ()<MDFDividerViewDataSource, MDFDividerViewDelegate>
@property (nonatomic, strong) NSArray<NSString *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.dataSource = @[@"hehe", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei", @"haha", @"heihei"];
  
  MDFDividerView *dividerView = [[MDFDividerView alloc] initWithFrame:CGRectMake(10, 70, 300, 60)];
  dividerView.dividerEdgeInsert = 10;
  dividerView.selectedIndex = 1;
  dividerView.dataSource = self;
  dividerView.delegate = self;
  [self.view addSubview:dividerView];
}

- (NSInteger)numberOfDividersInDividerView:(MDFDividerView *)dividerView {
  return self.dataSource.count;
}

- (NSString *)dividerView:(MDFDividerView *)dividerView titleForDividerAtIndex:(NSInteger)index {
  return self.dataSource[index];
}

- (void)dividerView:(MDFDividerView *)dividerView didSelectDividerAtIndex:(NSInteger)index {
  NSLog(@"点击了：%@", self.dataSource[index]);
}

@end
