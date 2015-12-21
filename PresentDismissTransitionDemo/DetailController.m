//
//  DetailController.m
//  PresentDismissTransitionDemo
//
//  Created by huangyibiao on 15/12/21.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "DetailController.h"
#import "HYBModalTransition.h"


@implementation DetailController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor greenColor];
  
  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, 350);
  NSString *path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"];
  imgView.image = [UIImage imageWithContentsOfFile:path];
  
  [self.view addSubview:imgView];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
  imgView.userInteractionEnabled = YES;
  [imgView addGestureRecognizer:tap];
  
  // 配置一下代理防呈现样式为自定义
  self.transitioningDelegate = self;
  self.modalPresentationStyle =  UIModalPresentationCustom;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
   return [HYBModalTransition transitionWithType:kHYBModalTransitionPresent duration:0.5 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
  return [HYBModalTransition transitionWithType:kHYBModalTransitionDismiss duration:0.25 presentHeight:350 scale:CGPointMake(0.9, 0.9)];
}

#pragma mark - Private
- (void)onTap {
  [self dismissViewControllerAnimated:YES completion:^{
    
  }];
}
@end
