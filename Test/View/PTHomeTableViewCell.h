//
//  PTHomeTableViewCell.h
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTCommentInputViewDelegate.h"

@class PTBaseModel;

@interface PTHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, assign) id<PTCommentInputViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)assignmentUIWithBaseModel:(PTBaseModel *)baseModel forIndexPath:(NSIndexPath *)indexPath;

@end
