//
//  PTHomeTableViewCell.m
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "PTHomeTableViewCell.h"
#import "PTBaseModel.h"
#import "ViewController.h"
#import "UIMenuController+PTContentLabel.h"
#import "PTActionLabel.h"

@implementation PTHomeTableViewCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.commentButton];
    }
    return self;
}

#pragma mark - public method
- (void)assignmentUIWithBaseModel:(PTBaseModel *)baseModel forIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    self.contentLabel.text = baseModel.content;
    self.imgView.image = [UIImage imageNamed:baseModel.imgPath];
}

#pragma mark - PTCommentInputViewDelegate
- (IBAction)showCommentInputView:(UIButton *)sender {
    [self.delegate shouldShowKeyBoardWithIndexPath:self.indexPath];
}

#pragma mark - action
- (void)onClickTap:(UIGestureRecognizer *)recognizer {
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
        return;
    }
    
    [menu setLabel:self.contentLabel];
    [self.contentLabel becomeFirstResponder];
    
    UIMenuItem *replyMenuItem = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(onClickReply:)];
    UIMenuItem *copyMenuItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(onClickCopy:)];
    UIMenuItem *voteDownMenuItem = [[UIMenuItem alloc] initWithTitle:@"踩" action:@selector(onClickVoteDown:)];
    UIMenuItem *shareMenuItem = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(onClickShare:)];
    menu.menuItems = @[replyMenuItem, copyMenuItem, voteDownMenuItem, shareMenuItem];
    [menu setTargetRect:self.contentLabel.frame inView:self];
    [menu setMenuVisible:YES animated:YES];
}

- (IBAction)onClickReply:(id)sender {
    NSLog(@"onClickReply...");
}

- (IBAction)onClickCopy:(id)sender {
    NSLog(@"onClickCopy...");
}

- (IBAction)onClickVoteDown:(id)sender {
    NSLog(@"onClickVoteDown...");
}

- (IBAction)onClickShare:(id)sender {
    NSLog(@"onClickShare...");
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(onClickReply:) || action == @selector(onClickCopy:) || action == @selector(onClickVoteDown:) || action == @selector(onClickShare:));
}

#pragma mark - getter
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 55, 55)];
    }
    return _imgView;
}

- (PTActionLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[PTActionLabel alloc] initWithFrame:CGRectMake(75, 20, 200, 25)];
        _contentLabel.font = [UIFont systemFontOfSize:20];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTap:)];
        [_contentLabel addGestureRecognizer:tap];
    }
    return _contentLabel;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 20, 50, 25);
        [_commentButton addTarget:self action:@selector(showCommentInputView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

@end
