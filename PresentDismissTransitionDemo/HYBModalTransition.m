//
//  HYBModalTransition.m
//  PresentDismissTransitionDemo
//
//  Created by huangyibiao on 15/12/21.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBModalTransition.h"

@interface HYBModalTransition ()

@property (nonatomic, assign) HYBModalTransitionType type;
@property (nonatomic, assign) CGFloat presentHeight;
@property (nonatomic, assign) CGPoint scale;
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation HYBModalTransition

+ (HYBModalTransition *)transitionWithType:(HYBModalTransitionType)type
                                  duration:(NSTimeInterval)duration
                             presentHeight:(CGFloat)presentHeight
                                     scale:(CGPoint)scale {
  HYBModalTransition *transition = [[HYBModalTransition alloc] init];
  
  transition.type = type;
  transition.presentHeight = presentHeight;
  transition.scale = scale;
  transition.duration = duration;
  
  return transition;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animationEnded:(BOOL)transitionCompleted {
  NSLog(@"%s", __FUNCTION__);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  switch (self.type) {
    case kHYBModalTransitionPresent: {
      [self present:transitionContext];
      break;
    }
    case kHYBModalTransitionDismiss: {
      [self dismiss:transitionContext];
      break;
    }
    default: {
      break;
    }
  }
}

#pragma mark - Private
- (void)present:(id<UIViewControllerContextTransitioning>)transitonContext {
  UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitonContext containerView];
  
  // 对fromVC.view的截图添加动画效果
  UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
  tempView.frame = fromVC.view.frame;
  
  // 对截图添加动画，则fromVC可以隐藏
  fromVC.view.hidden = YES;
  
  // 要实现转场，必须加入到containerView中
  [containerView addSubview:tempView];
  [containerView addSubview:toVC.view];
  
  // 我们要设置外部所传参数
  // 设置呈现的高度
  toVC.view.frame = CGRectMake(0,
                               containerView.frame.size.height,
                               containerView.frame.size.width,
                               self.presentHeight);
  
  // 开始动画
  __weak __typeof(self) weakSelf = self;
  [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 / 0.5 options:0 animations:^{
    // 在Y方向移动指定的高度
    toVC.view.transform = CGAffineTransformMakeTranslation(0, -weakSelf.presentHeight);
    
    // 让截图缩放
    tempView.transform = CGAffineTransformMakeScale(weakSelf.scale.x, weakSelf.scale.y);
  } completion:^(BOOL finished) {
    if (finished) {
      [transitonContext completeTransition:YES];
    }
  }];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitonContext {
  UIViewController *fromVC = [transitonContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitonContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *containerView = [transitonContext containerView];
  
  // 取出present时的截图用于动画
  UIView *tempView = containerView.subviews.lastObject;
  
  // 开始动画
  [UIView animateWithDuration:self.duration animations:^{
    toVC.view.transform = CGAffineTransformIdentity;
    fromVC.view.transform = CGAffineTransformIdentity;
 
  } completion:^(BOOL finished) {
    if (finished) {
      [transitonContext completeTransition:YES];
      toVC.view.hidden = NO;
      
      // 将截图去掉
      [tempView removeFromSuperview];
    }
  }];
}

@end
