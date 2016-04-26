//
//  UIView+AutoLayout.m
//  Metro
//
//  Created by zhourr_ on 16/2/29.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import "UIView+AutoLayout.h"

#define UIVIEW_WIDTH_CONSTRAINT                    @"UIVIEW_WIDTH_CONSTRAINT"
#define UIVIEW_HEIGHT_CONSTRAINT                   @"UIVIEW_HEIGHT_CONSTRAINT"

@implementation UIView (AutoLayout)

-(NSLayoutConstraint *)addWidthConstraint:(CGFloat) width{
    NSLayoutConstraint *constraint = nil;
    for (NSLayoutConstraint *addedConstraint in [self constraints]) {
        if ([UIVIEW_WIDTH_CONSTRAINT isEqualToString: constraint.identifier]) {
            constraint = addedConstraint;
            break;
        }
    }
    if (constraint) {
        constraint.constant = width;
    }else{
        // 约束
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0f
                                                   constant:width];
        [constraint setIdentifier:UIVIEW_WIDTH_CONSTRAINT];
        [self addConstraint:constraint];
    }
    return constraint;
}

-(NSLayoutConstraint *)addHeightConstraint:(CGFloat) height{
    NSLayoutConstraint *constraint = nil;
    for (NSLayoutConstraint *addedConstraint in [self constraints]) {
        if ([UIVIEW_HEIGHT_CONSTRAINT isEqualToString: constraint.identifier]) {
            constraint = addedConstraint;
            break;
        }
    }
    if (constraint) {
        constraint.constant = height;
    }else{
        // 约束
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:NSLayoutAttributeHeight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                 multiplier:1.0f
                                                   constant:height];
        [constraint setIdentifier:UIVIEW_HEIGHT_CONSTRAINT];
        [self addConstraint:constraint];
    }
    return constraint;
}

-(void)addWidthAndHeightConstraint:(CGFloat) width height:(CGFloat)height{
    [self addWidthConstraint:width];
    [self addHeightConstraint:height];
}

- (void)addWidthAndHeightScaleConstraint:(CGFloat) scale width:(CGFloat)width{
    [self addWidthConstraint:width];
    [self addHeightConstraint:width/scale];
}

- (void)addWidthEqualHeightConstraint:(CGFloat) width{
    [self addWidthConstraint:width];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0f
                                                                   constant: 0.0f];
    [self addConstraint:constraint];
}

-(NSLayoutConstraint *)addWidthConstraintWithScale:(CGFloat) scale{
    return [self addWidthConstraintWithOtherView:self.superview scale:scale];
}

- (NSLayoutConstraint *)addHeightConstraintWithScale:(CGFloat) scale{
    return [self addHeightConstraintWithOtherView:self.superview scale:scale];
}

- (NSLayoutConstraint *)addLeadingConstraint:(CGFloat) leading{
    // 约束
    return [self addLeadingConstraintWithOtherView:self.superview leading:leading];
}

- (NSLayoutConstraint *)addTopConstraint:(CGFloat) top{
    // 约束
    return [self addTopConstraintWithOtherView:self.superview top:top];
}

- (NSLayoutConstraint *)addTrailingConstraint:(CGFloat) trailing{
    // 约束
    return [self addTrailingConstraintWithOtherView:self.superview trailing:trailing];
}

- (NSLayoutConstraint *)addBottomConstraint:(CGFloat) bottom{
    // 约束
    return [self addBottomConstraintWithOtherView:self.superview bottom:bottom];
}

- (void)addLtrbConstraintWithLeading:(CGFloat) leading top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom{
    [self addLeadingConstraint:leading];
    [self addTopConstraint:top];
    [self addTrailingConstraint:trailing];
    [self addBottomConstraint:bottom];
}

- (void)addFullInSuperConstraint{
    [self addLeadingConstraint:0.0f];
    [self addTopConstraint:0.0f];
    [self addTrailingConstraint:0.0f];
    [self addBottomConstraint:0.0f];
}

- (void)addCenterXConstraint:(CGFloat) deviation{
    // x 居中
    [self addCenterXConstraintWithOtherView:self.superview deviation:deviation];
}

- (void)addCenterYConstraint:(CGFloat) deviation{
    // y 居中
    [self addCenterYConstraintWithOtherView:self.superview deviation:deviation];
}

- (void)addCenterXYConstraint{
    [self addCenterXConstraint:0.0f];
    [self addCenterYConstraint:0.0f];
}

- (void)addCenterXYConstraint:(CGFloat) deviationX deviationY:(CGFloat)deviationY{
    [self addCenterXConstraint:deviationX];
    [self addCenterYConstraint:deviationY];
}

-(NSLayoutConstraint *)addWidthConstraintWithOtherView:(UIView *) otherView scale:(CGFloat) scale{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:scale
                                                                   constant:0.0f];
    [otherView addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addHeightConstraintWithOtherView:(UIView *) otherView scale:(CGFloat) scale{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:scale
                                                                   constant:0.0f];
    [otherView addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addLeadingConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:leading];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addTopConstraintWithOtherView:(UIView *) otherView top:(CGFloat) top{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:top];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addTrailingConstraintWithOtherView:(UIView *) otherView trailing:(CGFloat) trailing{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:trailing];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)addBottomConstraintWithOtherView:(UIView *) otherView bottom:(CGFloat) bottom{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:bottom];
    [self.superview addConstraint:constraint];
    return constraint;
}

- (void)addLtrbConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom{
    [self addLeadingConstraintWithOtherView:otherView leading:leading];
    [self addTopConstraintWithOtherView:otherView top:top];
    [self addTrailingConstraintWithOtherView:otherView trailing:trailing];
    [self addBottomConstraintWithOtherView:otherView bottom:bottom];
}

- (void)addLeadingOutConstraintWithOtherView:(UIView *) otherView leading:(CGFloat) leading{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeLeading
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0f
                                                                   constant:leading];
    [self.superview addConstraint:constraint];
}

- (void)addTopOutConstraintWithOtherView:(UIView *) otherView top:(CGFloat) top{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0f
                                                                   constant:top];
    [self.superview addConstraint:constraint];
}

- (void)addTrailingOutConstraintWithOtherView:(UIView *) otherView trailing:(CGFloat) trailing{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeLeading
                                                                 multiplier:1.0f
                                                                   constant:trailing];
    [self.superview addConstraint:constraint];
}

- (void)addBottomOutConstraintWithOtherView:(UIView *) otherView bottom:(CGFloat) bottom{
    // 约束
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0f
                                                                   constant:bottom];
    [self.superview addConstraint:constraint];
}

- (void)addFullInWithOtherView:(UIView *) otherView{
    [self addLeadingConstraintWithOtherView:otherView leading:0.0f];
    [self addTopConstraintWithOtherView:otherView top:0.0f];
    [self addTrailingConstraintWithOtherView:otherView trailing:0.0f];
    [self addBottomConstraintWithOtherView:otherView bottom:0.0f];
}

- (void)addCenterXConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviation{
    // x 居中
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterX
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeCenterX
                                                                 multiplier:1.0f
                                                                   constant:deviation];
    [self.superview addConstraint:constraint];
}

- (void)addCenterYConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviation{
    // y 居中
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeCenterY
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:otherView
                                                                  attribute:NSLayoutAttributeCenterY
                                                                 multiplier:1.0f
                                                                   constant:deviation];
    [self.superview addConstraint:constraint];
}

- (void)addCenterXYConstraintWithOtherView:(UIView *) otherView{
    [self addCenterXConstraintWithOtherView:otherView deviation:0.0f];
    [self addCenterYConstraintWithOtherView:otherView deviation:0.0f];
}

- (void)addCenterXYConstraintWithOtherView:(UIView *) otherView deviation:(CGFloat) deviationX deviationY:(CGFloat)deviationY{
    [self addCenterXConstraintWithOtherView:otherView deviation:deviationX];
    [self addCenterYConstraintWithOtherView:otherView deviation:deviationY];
}

@end
