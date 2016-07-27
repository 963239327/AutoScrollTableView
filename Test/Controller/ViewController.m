//
//  ViewController.m
//  Test
//
//  Created by linzhennan on 16/3/23.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "ViewController.h"
#import "PTCommentInputView.h"
#import "PTHomeTableViewCell.h"
#import "PTModel.h"
#import "PTBaseModel.h"
#import "PTCommentInputViewDelegate.h"
#import "UIMenuController+PTContentLabel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, PTCommentInputViewDelegate>
@property (nonatomic, strong) PTCommentInputView *myView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"孩子玩什么";
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.myView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKey:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShowOrHide:) name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShowOrHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cid" forIndexPath:indexPath];
    cell.delegate = self;
    PTBaseModel *baseModel = [self.dataSource objectAtIndex:indexPath.row];
    [cell assignmentUIWithBaseModel:baseModel forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0f;
}

#pragma mark - PTCommentInputViewDelegate
- (void)shouldShowKeyBoardWithIndexPath:(NSIndexPath *)indexPath {
    [self.myView.inputTextView becomeFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    });
}

#pragma mark - action
- (void)didShowKey:(NSNotification *)notific {
    NSDictionary *userInfo = notific.userInfo;
    
    // Get the origin of the keyboard when it's displayed.
    CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Get the duration of the animation.
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGFloat h = 0.0f;
        if (fabs(rect.origin.y - [UIScreen mainScreen].bounds.size.height) < 1e-3) {
            self.myTableView.frame = CGRectMake(0, 0, self.myTableView.frame.size.width, self.view.frame.size.height);
        } else {
            h = self.myView.inputTextView.frame.size.height;
            self.myTableView.frame = CGRectMake(0, 0, self.myTableView.frame.size.width, rect.origin.y - h - 65);
        }
        self.myView.frame = CGRectMake(0,  rect.origin.y-64-h, [UIScreen mainScreen].bounds.size.width, 25);
    }];
}

- (void)menuControllerWillShowOrHide:(NSNotification *)notification {
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if ([notification.name isEqualToString:UIMenuControllerWillShowMenuNotification]) {
        menu.label.backgroundColor = [UIColor orangeColor];
    } else {
        menu.label.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - 键盘消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

// 先在storyboard中设置view的Class为UIControl，然后右键view选择Touch Down建立事件方法
- (IBAction)View_TouchDown:(id)sender {
    [self.view endEditing:YES];
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

/**
 *  点击tableview时隐藏键盘
 */
- (void)commentTableViewTouchInSide{
    [self.view endEditing:YES];
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - getter
- (PTCommentInputView *)myView {
    if (!_myView) {
        _myView = [[PTCommentInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, 25)];
       
        __weak typeof(self) weakSelf = self;
        _myView.changeFrame = ^(CGFloat offsetY) {
            CGRect frame = weakSelf.myTableView.frame;
            CGPoint offset = weakSelf.myTableView.contentOffset;
            offset.y = offset.y + frame.size.height - offsetY;
            frame.size.height = offsetY;
            weakSelf.myTableView.frame = frame;
            [weakSelf.myTableView setContentOffset:offset animated:YES];
        };
    }
    return _myView;
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[PTHomeTableViewCell class] forCellReuseIdentifier:@"cid"];
        // 给tableView添加手势以隐藏键盘
        UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
        tableViewGesture.numberOfTapsRequired = 1;
        tableViewGesture.cancelsTouchesInView = NO;
        [_myTableView addGestureRecognizer:tableViewGesture];
    }
    return _myTableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[PTModel alloc] init].dataList;
    }
    return _dataSource;
}

@end
