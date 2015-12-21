//
//  ViewController.m
//  PresentDismissTransitionDemo
//
//  Created by huangyibiao on 15/12/21.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "DetailController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIImageView *imgView = [[UIImageView alloc] init];
  imgView.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, self.view.frame.size.height - 40);
  NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
  imgView.image = [UIImage imageWithContentsOfFile:path];
  
  [self.view addSubview:imgView];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
  imgView.userInteractionEnabled = YES;
  [imgView addGestureRecognizer:tap];
}

- (void)onTap {
  DetailController *vc = [[DetailController alloc] init];
  
  [self presentViewController:vc animated:YES completion:^{
    
  }];
}

@end
