//
//  HNBMeController.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "HNBMeController.h"

@interface HNBMeController ()
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) UILabel *testLabel;
@end

@implementation HNBMeController

HNBURLRouterRegistUrl(HNBURLMe)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self designTestBtn];
    [self designTeslLabel];
    [self designCancelBtn];
}

- (void)designTestBtn{
    UIButton *btn = [UIButton new];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ApplicationDelegate.testPresentedNumber ++;
        [HNBBaseURLRouter presentControllerWithURL:HNBURLTestUrl withParams:@{@"number":@(ApplicationDelegate.testPresentedNumber)} prepreBlock:nil animated:YES completionBlock:nil];
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)designTeslLabel{
    self.testLabel = ({
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(100, 50, 0, 0));
        }];
        label.text = self.number.stringValue;
        label;
    });
}

- (void)designCancelBtn{
    UIButton *btn = [UIButton new];
    [btn setTitle:@"cancel" forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, 40));
    }];
}

- (void)setNumber:(NSNumber *)number{
    _number = number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIViewController (HNBURLRouter)
- (NSInteger)hnbIndex{
    return 0;
}

@end
