//
//  PTCommentInputView.h
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PTCommentChangeFrameBlock)(CGFloat offsetY);

@interface PTCommentInputView : UIView <UITextViewDelegate>

@property (nonatomic, strong) UITextView *inputTextView;

@property (nonatomic, copy) PTCommentChangeFrameBlock changeFrame;

@end
