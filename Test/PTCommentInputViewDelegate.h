//
//  PTCommentInputViewDelegate.h
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTCommentInputViewDelegate <NSObject>

- (void)shouldShowKeyBoardWithIndexPath:(NSIndexPath *)indexPath;

@end
