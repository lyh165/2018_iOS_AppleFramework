//
//  UILabel.h
//  UIKit
//
//  Copyright (c) 2006-2017 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIContentSizeCategoryAdjusting.h>

NS_ASSUME_NONNULL_BEGIN

@class UIColor, UIFont;

NS_CLASS_AVAILABLE_IOS(2_0) @interface UILabel : UIView <NSCoding, UIContentSizeCategoryAdjusting>

@property(nullable, nonatomic,copy)   NSString           *text;            // default is nil / /默认是零
@property(null_resettable, nonatomic,strong) UIFont      *font;            // default is nil (system font 17 plain) / /是零（默认系统字体17平原）

@property(null_resettable, nonatomic,strong) UIColor     *textColor;       // default is nil (text draws black) 默认是零（文本draws布莱克）
@property(nullable, nonatomic,strong) UIColor            *shadowColor;     // default is nil (no shadow) / /默认是
@property(nonatomic)        CGSize             shadowOffset;    // default is CGSizeMake(0, -1) -- a top shadow （0，1）一个高级的阴影
@property(nonatomic)        NSTextAlignment    textAlignment;   // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft) /默认是nstextalignmentnatural（之前的iOS 9，默认是nstextalignmentleft）
@property(nonatomic)        NSLineBreakMode    lineBreakMode;   // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text / /默认是nslinebreakbytruncatingtail。。。。。。。用于单和多行文本

// the underlying attributed string drawn by the label, if set, the label ignores the properties above. /的highlight财产的使用方法是用subclasses这样的事情作为热压铸入型国家。它的有用的部分，让它的基类的类作为一个用户的性质的
@property(nullable, nonatomic,copy)   NSAttributedString *attributedText NS_AVAILABLE_IOS(6_0);  // default is nil // 默认是零

// the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property 突出”为诸如属性被子类按下状态。很有用,使其基类的一部分作为一个用户属性

@property(nullable, nonatomic,strong)               UIColor *highlightedTextColor; // default is nil 默认为零
@property(nonatomic,getter=isHighlighted) BOOL     highlighted;          // default is NO 默认是没有

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // default is NO 默认是没有
@property(nonatomic,getter=isEnabled)                BOOL enabled;                 // default is YES. changes how the label is drawn 默认是肯定的。更改标签是如何绘制的

// this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
// if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
// truncated using the line break mode.
/**
 /这个决定的行数画和调用sizeToFit时该做什么。默认值是1(一行)。的值为0意味着没有限制/ /如果文本的高度达到#线或视图的高度小于允许的行号,文本/ /使用换行模式截断。
 */


@property(nonatomic) NSInteger numberOfLines;

// these next 3 properties allow the label to be autosized to fit a certain width by scaling the font size(s) by a scaling factor >= the minimum scaling factor
        // 这些未来3属性允许autosized符合一定宽度的标签缩放字体大小由一个比例因子(s)> =最低比例因子
// and to specify how the text baseline moves when it needs to shrink the font. /指定文本基线如何移动时需要缩小字体。

@property(nonatomic) BOOL adjustsFontSizeToFitWidth;         // default is NO 默认是没有
@property(nonatomic) UIBaselineAdjustment baselineAdjustment; // default is UIBaselineAdjustmentAlignBaselines 默认是UIBaselineAdjustmentAlignBaselines
@property(nonatomic) CGFloat minimumScaleFactor NS_AVAILABLE_IOS(6_0); // default is 0.0 默认是0.0


// Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate. 收紧inter-character间距在尝试适应更广泛的比可用空间如果换行模式是一种截断模式之前开始截断。
// The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc. 执行紧缩的最大数量是由系统根据上下文,如字体、线条宽度等。

/**
 
 */
@property(nonatomic) BOOL allowsDefaultTighteningForTruncation NS_AVAILABLE_IOS(9_0); // default is NO

// override points. can adjust rect before calling super.
// label has default content mode of UIViewContentModeRedraw
/**
 / /覆盖点。可以调整矩形之前调用超级。
 / /标签的UIViewContentModeRedraw默认内容模式
 */

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;
- (void)drawTextInRect:(CGRect)rect;


// Support for constraint-based layout (auto layout)
// If nonzero, this is used when determining -intrinsicContentSize for multiline labels
/**
 / /支持基于布局(自动布局)
 / /如果非零,这是在确定-intrinsicContentSize用于多行标签
 */
@property(nonatomic) CGFloat preferredMaxLayoutWidth NS_AVAILABLE_IOS(6_0);


// deprecated:

@property(nonatomic) CGFloat minimumFontSize NS_DEPRECATED_IOS(2_0, 6_0) __TVOS_PROHIBITED; // deprecated - use minimumScaleFactor. default is 0.0  弃用,使用minimumScaleFactor。默认是0.0/ /非功能性。

// Non-functional.  Hand tune by using NSKernAttributeName to affect tracking, or consider using the allowsDefaultTighteningForTruncation property. 手调整利用NSKernAttributeName影响跟踪,或考虑使用allowsDefaultTighteningForTruncation属性。
@property(nonatomic) BOOL adjustsLetterSpacingToFitWidth NS_DEPRECATED_IOS(6_0,7_0) __TVOS_PROHIBITED;

@end

NS_ASSUME_NONNULL_END
