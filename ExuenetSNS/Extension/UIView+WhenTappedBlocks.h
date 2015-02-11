//
//  UIView+WhenTappedBlocks.h
//  LOLOrz
//
//  Created by Jake Marsh on 3/7/11.
//  Copyright 2011 Rubber Duck Software. All rights reserved.
//

#if NS_BLOCKS_AVAILABLE

#import <UIKit/UIKit.h>

typedef void (^JMWhenTappedBlock)();

@interface UIView (JMWhenTappedBlocks) <UIGestureRecognizerDelegate>

/*!
 *  单击View
 *
 *  @param block 代码执行块
 */
- (void)whenTapped:(JMWhenTappedBlock)block;

/*!
 *  双击View
 *
 *  @param block 代码执行块
 */
- (void)whenDoubleTapped:(JMWhenTappedBlock)block;

/*!
 *  两个手指点击
 *
 *  @param block 代码执行块
 */
- (void)whenTwoFingerTapped:(JMWhenTappedBlock)block;

/*!
 *  当手指刚触碰到UIView时 触发该事件
 *
 *  @param block 代码执行块
 */
- (void)whenTouchedDown:(JMWhenTappedBlock)block;

/*!
 *  当手指离开UIView时 触发该事件
 *
 *  @param block 代码执行块
 */
- (void)whenTouchedUp:(JMWhenTappedBlock)block;

@end

#endif
