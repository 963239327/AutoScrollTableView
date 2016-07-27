//
//  UIMenuController+PTContentLabel.m
//  Test
//
//  Created by iCodeWoods on 16/7/27.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "UIMenuController+PTContentLabel.h"
#import <objc/runtime.h>

static NSString *const labelKey;

@implementation UIMenuController (PTContentLabel)

- (void)setLabel:(UILabel *)label {
    objc_setAssociatedObject(self, &labelKey, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)label {
    UILabel *label = objc_getAssociatedObject(self, &labelKey);
    if (!label) {
        label = [[UILabel alloc] init];
    }
    return label;
}

@end
