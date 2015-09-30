//
//  NumGameEngine.h
//  Num
//
//  Created by songrixi on 15-2-11.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NumMoveDirection){
    NumMoveDirectionLeft,
    NumMoveDirectionRight,
    NumMoveDirectionUp,
    NumMoveDirectionDown,
};

typedef NS_ENUM(NSUInteger, NumGameStatu) {
    NumGameStatuPrepare,
    NumGameStatuPlaying,
    NumGameStatuOver,
    NumGameStatuSuccess,
};

@interface NumGameEngine : NSObject

@property (nonatomic)NumGameStatu statu;
@property (nonatomic, strong)NSArray *numList;
@property (nonatomic)NSInteger score;

+  (instancetype)game;

- (void)start;

- (void)move:(NumMoveDirection)direction;

- (NSInteger)numAtIndex:(NSInteger)row column:(NSInteger)column;


@end
