//
//  HNBTestURLRouter.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "HNBTestURLRouter.h"

@interface HNBTestURLRouter ()
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UIButton *presentBtn;
@property (nonatomic, strong) UIButton *pushBtn;
@end

@implementation HNBTestURLRouter

HNBURLRouterRegistUrl(HNBURLTestUrl)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self designPresentBtn];
    [self designPushBtn];
    [self designTeslLabel];
    [self designCancelBtn];
}

- (void)designPresentBtn{
    self.presentBtn = ({
        UIButton *btn = [UIButton new];
        [btn setTitle:@"present" forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ApplicationDelegate.testPresentedNumber ++;
            [HNBBaseURLRouter presentControllerWithURL:HNBURLTestUrl withParams:@{@"number":@(ApplicationDelegate.testPresentedNumber)} prepreBlock:nil animated:YES completionBlock:nil];
        }];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        btn;
    });
}

- (void)designPushBtn{
    self.pushBtn = ({
        UIButton *btn = [UIButton new];
        [btn setTitle:@"push" forState:UIControlStateNormal];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ApplicationDelegate.testPresentedNumber ++;
            [HNBBaseURLRouter openURL:HNBURLTestUrl withParams:@{@"number":@(ApplicationDelegate.testPresentedNumber)}];
        }];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view).centerOffset(CGPointMake(0, 40));
        }];
        btn;
    });
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
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, 80));
    }];
    if(self.navigationController){
        if(self.navigationController.viewControllers.count >=2){
            btn.hidden = YES;
        }
    }
}

- (void)setNumber:(NSNumber *)number{
    _number = number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
