//
//  HNBInteractionController.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "HNBInteractionController.h"

@interface HNBInteractionController ()

@end

@implementation HNBInteractionController
HNBURLRouterRegistUrl(HNBURLInteraction)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIViewController (HNBURLRouter)
- (NSInteger)hnbIndex{
    return 2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
