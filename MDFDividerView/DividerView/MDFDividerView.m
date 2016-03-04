//
//  MDFDividerView.m
//  Secoo-iPhone
//
//  Created by WuYikai on 16/3/3.
//  Copyright © 2016年 secoo. All rights reserved.
//

#import "MDFDividerView.h"
#import "UIImage+LVMCustomImage.h"
#import "PureLayout.h"

static NSInteger const kMDFDividerViewButtonBaseTag = 10000;

@interface MDFDividerView ()

@property (nonatomic, assign) BOOL isReload;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation MDFDividerView

#pragma mark - override -

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.selectedIndex = -1;
    UIScrollView *scrollView = [[UIScrollView alloc] initForAutoLayout];
    self.scrollView = scrollView;
    [self addSubview:scrollView];    
    [scrollView autoPinEdgesToSuperviewEdges];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!self.isReload) {
    [self reloadData];
    self.isReload = YES;
  }
}

#pragma mark - Public Methods -

- (void)reloadData {
  [self _removeDividers];
  [self _setupDividers];
}

#pragma mark - Private Methods -

- (void)_removeDividers {
  for (UIButton *divider in self.scrollView.subviews) {
    [divider removeFromSuperview];
  }
}

- (void)_setupDividers {
  NSInteger numbers = [self.dataSource numberOfDividersInDividerView:self];
  [self _handleScrollViewScrollEnableWithDividerNumber:numbers];
  
  UIImage *normalBackgroundImage = [UIImage lvm_imageWithColor:self.dividerColor
                                                          size:CGSizeMake(self.dividerWidth, self.dividerHeight)];
  UIImage *selectedBackgroundImage = [UIImage lvm_imageWithColor:self.dividerSelectedColor
                                                            size:CGSizeMake(self.dividerWidth, self.dividerHeight)];
  for (NSInteger i = 0; i < numbers; ++i) {
    NSString *title = [self.dataSource dividerView:self titleForDividerAtIndex:i];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    [button setTitleColor:self.dividerTextColor forState:UIControlStateNormal];
    [button setTitleColor:self.dividerSelectedTextColor forState:UIControlStateSelected];
    button.titleLabel.font = self.dividerFont;
    button.clipsToBounds = YES;
    button.layer.borderWidth = self.dividerBorderWidth;
    button.layer.borderColor = self.dividerBorderColor.CGColor;
    button.layer.cornerRadius = self.dividerHeight / 2.0;
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = kMDFDividerViewButtonBaseTag + i;
    [button addTarget:self action:@selector(_handleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:button];
    
    if (i == self.selectedIndex) {
      button.selected = YES;
      button.layer.borderColor = self.dividerSelectedBorderColor.CGColor;
    }
    
    CGFloat originX = self.dividerEdgeInsert + i * (self.dividerWidth + self.dividerInsert);
    [button configureForAutoLayout];
    [button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:originX];
    [button autoSetDimensionsToSize:CGSizeMake(self.dividerWidth, self.dividerHeight)];
  }
}

- (void)_handleButtonClickAction:(UIButton *)sender {
  self.selectedIndex = sender.tag - kMDFDividerViewButtonBaseTag;
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(dividerView:didSelectDividerAtIndex:)]) {
    [self.delegate dividerView:self didSelectDividerAtIndex:self.selectedIndex];
  }
}

- (void)_handleScrollViewScrollEnableWithDividerNumber:(NSInteger)number {
  CGFloat totalWidth = [self _totalWithForDividers:number] + self.dividerEdgeInsert * 2;
  if (totalWidth > self.bounds.size.width) {
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
  } else {
    self.scrollView.contentSize = CGSizeZero;
  }
}

#pragma mark - Helper

- (CGFloat)_totalWithForDividers:(NSInteger)number {
  return number * (self.dividerWidth + self.dividerInsert) - self.dividerInsert;
}

#pragma mark - setter & getter -

- (void)setSelectedIndex:(NSInteger)selectedIndex {
  _selectedIndex = selectedIndex;
  for (NSInteger i = 0; i < self.scrollView.subviews.count; ++i) {
    NSInteger tag = kMDFDividerViewButtonBaseTag + i;
    UIButton *divider = (UIButton *)[self.scrollView viewWithTag:tag];
    divider.selected = (i == selectedIndex);
    if (divider.selected) {
      divider.layer.borderColor = self.dividerSelectedBorderColor.CGColor;
    } else {
      divider.layer.borderColor = self.dividerBorderColor.CGColor;
    }
  }
}

- (CGFloat)dividerHeight {
  if (0 == _dividerHeight) {
    return 25;
  }
  return _dividerHeight;
}

- (CGFloat)dividerWidth {
  if (0 == _dividerWidth) {
    return 50;
  }
  return _dividerWidth;
}

- (CGFloat)dividerInsert {
  if (0 == _dividerInsert) {
    return 10;
  }
  return _dividerInsert;
}

- (CGFloat)dividerBorderWidth {
  if (0 == _dividerBorderWidth) {
    return 1;
  }
  return _dividerBorderWidth;
}

- (UIFont *)dividerFont {
  if (!_dividerFont) {
    return [UIFont systemFontOfSize:12];
  }
  return _dividerFont;
}

- (UIColor *)dividerColor {
  if (!_dividerColor) {
    return [UIColor whiteColor];
  }
  return _dividerColor;
}

- (UIColor *)dividerSelectedColor {
  if (!_dividerSelectedColor) {
    return [UIColor blackColor];
  }
  return _dividerSelectedColor;
}

- (UIColor *)dividerTextColor {
  if (!_dividerTextColor) {
    return [UIColor blackColor];
  }
  return _dividerTextColor;
}

- (UIColor *)dividerSelectedTextColor {
  if (!_dividerSelectedTextColor) {
    return [UIColor whiteColor];
  }
  return _dividerSelectedTextColor;
}

- (UIColor *)dividerBorderColor {
  if (!_dividerBorderColor) {
    return [UIColor lightGrayColor];
  }
  return _dividerBorderColor;
}

- (UIColor *)dividerSelectedBorderColor {
  if (!_dividerSelectedBorderColor) {
    return self.dividerSelectedColor;
  }
  return _dividerSelectedBorderColor;
}

@end
