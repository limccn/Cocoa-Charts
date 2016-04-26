//
//  UIView+AutoLayout.h
//  Metro
//
//  Created by zhourr_ on 16/2/29.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/*******************************************************************************
 * To Self
 *******************************************************************************/

/**
 * 约束宽度
 */
- (NSLayoutConstraint *)addWidthConstraint:(CGFloat) width;

/**
 * 约束高度
 */
- (NSLayoutConstraint *)addHeightConstraint:(CGFloat) height;

/**
 * 约束宽度,高度
 */
- (void)addWidthAndHeightConstraint:(CGFloat) width height:(CGFloat)height;

/**
 * 约束宽高比
 */
- (void)addWidthAndHeightScaleConstraint:(CGFloat) scale width:(CGFloat)width;

/**
 * 约束宽度高度相等
 */
- (void)addWidthEqualHeightConstraint:(CGFloat) width;

/*******************************************************************************
 * To SuperView
 *******************************************************************************/

/**
 * 约束宽度
 */
-(NSLayoutConstraint *)addWidthConstraintWithScale:(CGFloat) scale;

/**
 * 约束高度
 */
- (NSLayoutConstraint *)addHeightConstraintWithScale:(CGFloat) scale;

/**
 * 约束与父控件左边距
 */
- (NSLayoutConstraint *)addLeadingConstraint:(CGFloat) leading;

/**
 * 约束与父控件上边距
 */
- (NSLayoutConstraint *)addTopConstraint:(CGFloat) top;

/**
 * 约束与父控件右边距
 */
- (NSLayoutConstraint *)addTrailingConstraint:(CGFloat) trailing;

/**
 * 约束与父控件下边距
 */
- (NSLayoutConstraint *)addBottomConstraint:(CGFloat) bottom;

/**
 * 约束与父控件左上右下边距
 */
- (void)addLtrbConstraintWithLeading:(CGFloat) leading top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom;

/**
 * 在 SuperView 内充满
 */
- (void)addFullInSuperConstraint;

/**
 * 约束在父控件x居中
 */
- (void)addCenterXConstraint:(CGFloat) deviation;

/**
 * 约束在父控件y居中
 */
- (void)addCenterYConstraint:(CGFloat) deviation;

/**
 * 约束在父控件x,y居中
 */
- (void)addCenterXYConstraint;

/**
 * 约束在父控件x,y居中
 */
- (void)addCenterXYConstraint:(CGFloat) deviationX deviationY:(CGFloat)deviationY;

/*******************************************************************************
 * To Other View
 *******************************************************************************/

/**
 * 约束宽度
 */
-(NSLayoutConstraint *)addWidthConstraintWithOtherView:(UIView *) otherView scale:(CGFloat) scale;

/**
 * 约束高度
 */
- (NSLayoutConstraint *)addHeightConstraintWithOtherView:(UIView *) otherView scale:(CGFloat) scale;

/**
 * 约束相对 otherView 左边距
 */
- (NSLayoutConstraint *)addLeadingConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading;

/**
 * 约束相对 otherView 上边距
 */
- (NSLayoutConstraint *)addTopConstraintWithOtherView:(UIView *) otherView top:(CGFloat) top;

/**
 * 约束相对 otherView 右边距
 */
- (NSLayoutConstraint *)addTrailingConstraintWithOtherView:(UIView *) otherView trailing:(CGFloat) trailing;

/**
 * 约束相对 otherView 下边距
 */
- (NSLayoutConstraint *)addBottomConstraintWithOtherView:(UIView *) otherView bottom:(CGFloat) bottom;

/**
 * 约束相对 otherView 左上右下边距
 */
- (void)addLtrbConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom;

/**
 * 约束相对 otherView 左边距
 */
- (void)addLeadingOutConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading;

/**
 * 约束相对 otherView 上边距
 */
- (void)addTopOutConstraintWithOtherView:(UIView *) otherView top:(CGFloat) top;

/**
 * 约束相对 otherView 右边距
 */
- (void)addTrailingOutConstraintWithOtherView:(UIView *) otherView trailing:(CGFloat) trailing;

/**
 * 约束相对 otherView 下边距
 */
- (void)addBottomOutConstraintWithOtherView:(UIView *) otherView bottom:(CGFloat) bottom;

/**
 * 约束相对 otherView 内充满
 */
- (void)addFullInWithOtherView:(UIView *) otherView;

/**
 * 约束相对 otherView x居中
 */
- (void)addCenterXConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviation;

/**
 * 约束相对 otherView y居中
 */
- (void)addCenterYConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviation;

/**
 * 约束相对 otherView x,y居中
 */
- (void)addCenterXYConstraintWithOtherView:(UIView *) otherView;

/**
 * 约束相对 otherView x,y居中
 */
- (void)addCenterXYConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviationX deviationY:(CGFloat)deviationY;

@end
