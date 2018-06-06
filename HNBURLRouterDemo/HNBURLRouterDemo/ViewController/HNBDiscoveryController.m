//
//  HNBDiscoveryController.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "HNBDiscoveryController.h"

@interface HNBDiscoveryController ()

@end

@implementation HNBDiscoveryController
HNBURLRouterRegistUrl(HNBURLDiscovery)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self designClickBtn];
    [self designClickInteraction];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)designClickBtn{
    UIButton *btn = [UIButton new];
    [btn setTitle:@"toMe" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HNBBaseURLRouter openURL:HNBURLMe];
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)designClickInteraction{
    UIButton *btn = [UIButton new];
    [btn setTitle:@"toInteraction" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [HNBBaseURLRouter openURL:HNBURLInteraction];
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, 40));
    }];
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
