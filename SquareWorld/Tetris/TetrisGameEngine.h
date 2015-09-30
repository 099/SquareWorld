//
//  TetrisGameEngine.h
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#define TetrisRowCount 24
#define TetrisColumnCount 10
#define TetrisCleanTime 5

#import <Foundation/Foundation.h>
#import "TetrisGridGroup.h"

typedef NS_ENUM(NSUInteger, TetrisGameStatu)
{
    TetrisGameStatuPrepare,
    TetrisGameStatuPlaying,
    TetrisGameStatuCleaning,
    TetrisGameStatuPasue,
    TetrisGameStatuOver,
};

@protocol TetrisGameEngineDelegate <NSObject>

- (void)updateTetrisStatus;
- (void)cleanTetris:(NSMutableArray *)cleanRows;


@end

@interface TetrisGameEngine : NSObject

@property (nonatomic, strong)id<TetrisGameEngineDelegate> delegate;
@property (nonatomic) TetrisGameStatu statu;
@property (nonatomic, strong) NSMutableArray *gridList;
@property (nonatomic, strong) TetrisGridGroup *currentGridGroup;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger rowScore;

- (void)start;
- (void)moveLeft;
- (void)moveRight;
- (void)moveBottom;
- (void)turn;
- (void)pasue;
- (void)resume;

+ (instancetype)game;

@end
