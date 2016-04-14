//
//  PTHomeTableViewCell.m
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "PTHomeTableViewCell.h"
#import "PTBaseModel.h"

@implementation PTHomeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.commentButton];
    }
    return self;
}

- (void)assignmentUIWithBaseModel:(PTBaseModel *)baseModel forIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    NSLog(@"assignmentUIWithBaseModel...");
    NSLog(@"baseModel = %@ %@", baseModel.content, baseModel.imgPath);
    self.contentLabel.text = baseModel.content;
    self.imgView.image = [UIImage imageNamed:baseModel.imgPath];
}

- (void)showCommentInputView {
    NSLog(@"showCommentInputView...");
    [self.delegate shouldShowKeyBoardWithIndexPath:self.indexPath];
}

#pragma mark - getter
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 55, 55)];
    }
    return _imgView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 200, 25)];
        _contentLabel.font = [UIFont systemFontOfSize:20];
    }
    return _contentLabel;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 20, 50, 25);
        [_commentButton addTarget:self action:@selector(showCommentInputView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}

@end
