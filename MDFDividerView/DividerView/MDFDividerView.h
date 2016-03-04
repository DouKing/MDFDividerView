//
//  MDFDividerView.h
//  Secoo-iPhone
//
//  Created by WuYikai on 16/3/3.
//  Copyright © 2016年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MDFDividerView;

@protocol MDFDividerViewDataSource <NSObject>
@required
- (NSInteger)numberOfDividersInDividerView:(MDFDividerView *)dividerView;
- (nullable NSString *)dividerView:(MDFDividerView *)dividerView titleForDividerAtIndex:(NSInteger)index;

@end

@protocol MDFDividerViewDelegate <NSObject>

- (void)dividerView:(MDFDividerView *)dividerView didSelectDividerAtIndex:(NSInteger)index;

@end

@interface MDFDividerView : UIView

@property (nonatomic, weak) id<MDFDividerViewDataSource> dataSource;
@property (nonatomic, weak) id<MDFDividerViewDelegate> delegate;

/**
 *  默认选中，-1表示不选中，默认为-1
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong, nullable) UIColor *dividerColor;
@property (nonatomic, strong, nullable) UIColor *dividerTextColor;
@property (nonatomic, strong, nullable) UIColor *dividerSelectedColor;
@property (nonatomic, strong, nullable) UIColor *dividerSelectedTextColor;
@property (nonatomic, strong, nullable) UIColor *dividerBorderColor;
@property (nonatomic, strong, nullable) UIColor *dividerSelectedBorderColor;

@property (nonatomic, strong, nullable) UIFont  *dividerFont;

@property (nonatomic, assign) CGFloat dividerBorderWidth;
@property (nonatomic, assign) CGFloat dividerWidth;
@property (nonatomic, assign) CGFloat dividerHeight;
@property (nonatomic, assign) CGFloat dividerInsert;
@property (nonatomic, assign) CGFloat dividerEdgeInsert;

- (void)reloadData;

@end


NS_ASSUME_NONNULL_END