//
//  PTModel.m
//  Test
//
//  Created by linzhennan on 16/3/24.
//  Copyright © 2016年 Zhennan Lin. All rights reserved.
//

#import "PTModel.h"
#import "PTBaseModel.h"

@implementation PTModel

- (instancetype)init {
    if (self = [super init]) {
        self.dataList = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            PTBaseModel *baseModel = [[PTBaseModel alloc] init];
            baseModel.imgPath = @"lala";
            baseModel.content = [NSString stringWithFormat:@"这是第 %d 条内容", i];
            [self.dataList addObject:baseModel];
        }
    }
    return self;
}

@end
