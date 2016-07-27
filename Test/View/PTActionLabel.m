//
//  PTActionLabel.m
//  Test
//
//  Created by iCodeWoods on 16/7/27.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "PTActionLabel.h"

@implementation PTActionLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES; // 用户交互的总开关
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
