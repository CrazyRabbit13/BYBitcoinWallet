//
//  ContractCtrl.m
//  BYBitcoinWallet
//
//  Created by BaoYin on 2018/1/19.
//  Copyright © 2018年 BaoYin Sun. All rights reserved.
//

#import "ContractCtrl.h"
#import "HMSegmentedControl.h"
#import "ContractInfoView.h"
#import "ContractDealView.h"

@interface ContractCtrl ()

@property (nonatomic, strong) HMSegmentedControl *navigator;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ContractInfoView *contractInfoView;
@property (nonatomic, strong) ContractDealView *contractDealView;

@end

@implementation ContractCtrl

#pragma mark -
#pragma mark - override method
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[BYWebSocketManager shareManager] by_close:^(NSInteger code, NSString *reason, BOOL wasClean) {
//        NSLog(@"code = %zd,reason = %@",code,reason);
//    }];
}

#pragma mark -
#pragma mark - private method
- (void)by_layoutNavigation {
    [self hideNavigationBar:NO animated:NO];
    [self layoutNavigationBar:nil titleColor:nil titleFont:nil leftBarButtonItem:nil rightBarButtonItem:nil];
}

- (void)by_setupSubviews {
    [self.view addSubview:self.navigator];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contractInfoView];
    [self.scrollView addSubview:self.contractDealView];
    
    [self.navigator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(by_autoResize(44));
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(by_autoResize(44), 0, 0, 0));
    }];
    
    [self.contractInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.width.mas_equalTo(BYScreen_width);
    }];
    
    [self.contractDealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contractInfoView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(BYScreen_width);
    }];
}

- (void)by_bindViewModel {
//    NSString *url = @"wss://real.okex.com:10441/websocket/ok_sub_spot_X_ticker";
//
//    [[BYWebSocketManager shareManager] by_open:url connect:^{
//        NSLog(@"成功连接");
//        [[BYWebSocketManager shareManager] by_send:@"{'event':'addChannel','channel':'ok_sub_spot_ltc_btc_ticker'}"];
//    } receive:^(id message, BYSocketReceiveType type) {
//        if (type == BYSocketReceiveTypeForMessage) {
//            NSLog(@"接收 类型1--%@",message);
//        }
//        else if (type == BYSocketReceiveTypeForPong){
//            NSLog(@"接收 类型2--%@",message);
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"连接失败");
//    }];
}

#pragma mark -
#pragma mark - lazy loading
- (HMSegmentedControl *)navigator {
    if (!_navigator) {
        NSArray *titles = @[@"交易", @"挂单", @"持仓"];
        _navigator = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
        [_navigator addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _navigator;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (ContractInfoView *)contractInfoView {
    if (!_contractInfoView) {
        _contractInfoView = [[ContractInfoView alloc] init];
    }
    return _contractInfoView;
}

- (ContractDealView *)contractDealView {
    if (!_contractDealView) {
        _contractDealView = [[ContractDealView alloc] init];
    }
    return _contractDealView;
}


#pragma mark -
#pragma mark -



#pragma mark -
#pragma mark - Navigator delegate
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
}

@end

