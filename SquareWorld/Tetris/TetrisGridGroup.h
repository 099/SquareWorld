//
//  TetrisGridGroup.h
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#define TetrisGridGroupRowCount 4
#define TetrisGridGroupColumnCount 4
#define TetrisGridHeight 50

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TetrisTurnType)
{
    TetrisTurnTypeAll,
    TetrisTurnTypeLeft,
    TetrisTurnTypeRight,
};

@interface TetrisGridGroup : NSObject

@property (nonatomic) TetrisTurnType turnType;
@property (nonatomic, strong) NSMutableArray *gridList;

- (void)setNumList:(NSArray*)list;
- (void)drop:(NSInteger)speed;
- (void)moveLeft;
- (void)moveRight;
- (void)turn;
- (void)setRow:(NSInteger)row column:(NSInteger)column;
- (void)reset;

- (NSMutableArray *)moveLeftStatus;
- (NSMutableArray *)moveRightStatus;
- (NSMutableArray *)turnStatus;

@end
