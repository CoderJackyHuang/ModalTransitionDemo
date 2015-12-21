//
//  HYBModalTransition.h
//  PresentDismissTransitionDemo
//
//  Created by huangyibiao on 15/12/21.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYBModalTransitionType) {
  kHYBModalTransitionPresent = 1 << 1,
  kHYBModalTransitionDismiss = 1 << 2
};

@interface HYBModalTransition : NSObject <UIViewControllerAnimatedTransitioning>

/*!
 *  @author 黄仪标, 15-12-21 11:12:44
 *
 *  指定动画类型
 *
 *  @param type          动画类型
 *  @param duration      动画时长
 *  @param presentHeight 弹出呈现的高度
 *  @param scale         fromVC的绽放系数
 *
 *  @return 
 */
+ (HYBModalTransition *)transitionWithType:(HYBModalTransitionType)type
                                  duration:(NSTimeInterval)duration
                             presentHeight:(CGFloat)presentHeight
                                     scale:(CGPoint)scale;

@end
