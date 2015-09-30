//
//  NumGameEngine.m
//  Num
//
//  Created by songrixi on 15-2-11.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "NumGameEngine.h"

@interface NumGameEngine ()

@property (nonatomic, strong) NSMutableArray *numGrids;

@end

@implementation NumGameEngine

+ (instancetype)game
{
    static NumGameEngine *game = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        game = [[NumGameEngine alloc] init];
    });
    return game;
}

- (void)start
{
    self.statu = NumGameStatuPrepare;
    self.score = 0;
    if (self.numList == nil) {
        self.numList = [[NSArray alloc] initWithObjects:@0, @2, @4, @8, @16, @32, @64, @128, @256, @512, @1024, @2048, nil];
    }
    
    self.numGrids = [[NSMutableArray alloc] init];
    for (NSInteger column = 0; column < 4; column++) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for (NSInteger row = 0; row < 4; row++) {
            [arr addObject:self.numList[0]];
        }
        [self.numGrids addObject:arr];
    }
    [self randomSetOneNum];
    [self randomSetOneNum];
    self.statu = NumGameStatuPlaying;
}

- (void)move:(NumMoveDirection)direction
{
    BOOL hasMove = NO;
    switch (direction) {
        case NumMoveDirectionLeft:
            hasMove = [self moveLeft];
            break;
        case NumMoveDirectionRight:
            hasMove = [self moveRight];
            break;
        case NumMoveDirectionUp:
            hasMove = [self moveUp];
            break;
        case NumMoveDirectionDown:
            hasMove = [self moveDown];
            break;
        default:
            break;
    }
    
    if (hasMove) {
        [self randomSetOneNum];
        [self checkGameOver];
    }
}

-(BOOL)moveLeft
{
    BOOL hasMove = NO;
    for (NSInteger column = 0; column < 4; column++)
    {
        NSInteger endRow = 0;
        for (NSInteger row = 1; row < 4; row++)
        {
            if (self.numGrids[column][row] != self.numList[0])
            {
                if (self.numGrids[column][row] == self.numGrids[column][endRow])
                {
                    self.numGrids[column][row] = self.numList[0];
                    NSInteger index = [self indexAtNumList:self.numGrids[column][endRow]];
                    self.numGrids[column][endRow] = self.numList[index + 1];
                    endRow = row;
                    hasMove = YES;
                    [self calculateScore:index + 1];
                }
                else
                {
                    if (self.numGrids[column][endRow] == self.numList[0]) {
                        self.numGrids[column][endRow] = self.numGrids[column][row];
                        self.numGrids[column][row] = self.numList[0];
                        hasMove = YES;
                    }
                    else
                    {
                        if (row - endRow > 1 && self.numGrids[column][endRow + 1] == self.numList[0]) {
                            self.numGrids[column][endRow + 1] = self.numGrids[column][row];
                            self.numGrids[column][row] = self.numList[0];
                            hasMove = YES;
                        }
                        endRow = row;
                    }
                }
            }
            
        }
    }
    return hasMove;

}

-(BOOL)moveRight
{
    BOOL hasMove = NO;
    for (NSInteger column = 0; column < 4; column++)
    {
        NSInteger endRow = 3;
        for (NSInteger row = 2; row >= 0; row--)
        {
            if (self.numGrids[column][row] != self.numList[0])
            {
                if (self.numGrids[column][row] == self.numGrids[column][endRow])
                {
                    self.numGrids[column][row] = self.numList[0];
                    NSInteger index = [self indexAtNumList:self.numGrids[column][endRow]];
                    self.numGrids[column][endRow] = self.numList[index + 1];
                    endRow = row;
                    hasMove = YES;
                    [self calculateScore:index + 1];
                }
                else
                {
                    if (self.numGrids[column][endRow] == self.numList[0]) {
                        self.numGrids[column][endRow] = self.numGrids[column][row];
                        self.numGrids[column][row] = self.numList[0];
                        hasMove = YES;
                    }
                    else
                    {
                        if (endRow - row > 1 && self.numGrids[column][endRow - 1] == self.numList[0]) {
                            self.numGrids[column][endRow - 1] = self.numGrids[column][row];
                            self.numGrids[column][row] = self.numList[0];
                            hasMove = YES;
                        }
                        endRow = row;
                    }
                }
            }

        }
    }
    return hasMove;
}

-(BOOL)moveUp
{
    BOOL hasMove = NO;
    for (NSInteger row = 0; row < 4; row++)
    {
        NSInteger endColumn = 0;
        for (NSInteger column = 1; column < 4; column++)
        {
            if (self.numGrids[column][row] != self.numList[0])
            {
                if (self.numGrids[column][row] == self.numGrids[endColumn][row])
                {
                    self.numGrids[column][row] = self.numList[0];
                    NSInteger index = [self indexAtNumList:self.numGrids[endColumn][row]];
                    self.numGrids[endColumn][row] = self.numList[index + 1];
                    endColumn = column;
                    hasMove = YES;
                    [self calculateScore:index + 1];
                }
                else
                {
                    if (self.numGrids[endColumn][row] == self.numList[0])
                    {
                        self.numGrids[endColumn][row] = self.numGrids[column][row];
                        self.numGrids[column][row] = self.numList[0];
                        hasMove = YES;
                    }
                    else
                    {
                        if (column - endColumn > 1 && self.numGrids[endColumn + 1][row] == self.numList[0]) {
                            self.numGrids[endColumn + 1][row] = self.numGrids[column][row];
                            self.numGrids[column][row] = self.numList[0];
                            hasMove = YES;
                        }
                        endColumn = column;
                    }
                }
            }
        }
    }
    return hasMove;
}

-(BOOL)moveDown
{
    BOOL hasMove = NO;
    for (NSInteger row = 0; row < 4; row++)
    {
        NSInteger endColumn = 3;
        for (NSInteger column = 2; column >= 0; column--)
        {
            if (self.numGrids[column][row] != self.numList[0])
            {
                if (self.numGrids[column][row] == self.numGrids[endColumn][row])
                {
                    self.numGrids[column][row] = self.numList[0];
                    NSInteger index = [self indexAtNumList:self.numGrids[endColumn][row]];
                    self.numGrids[endColumn][row] = self.numList[index + 1];
                    endColumn = column;
                    hasMove = YES;
                    [self calculateScore:index + 1];
                }
                else
                {
                    if (self.numGrids[endColumn][row] == self.numList[0])
                    {
                        self.numGrids[endColumn][row] = self.numGrids[column][row];
                        self.numGrids[column][row] = self.numList[0];
                        hasMove = YES;
                    }
                    else
                    {
                        if (endColumn - column > 1 && self.numGrids[endColumn - 1][row] == self.numList[0]) {
                            self.numGrids[endColumn - 1][row] = self.numGrids[column][row];
                            self.numGrids[column][row] = self.numList[0];
                            hasMove = YES;
                        }
                        endColumn = column;
                    }
                }
            }
        }
    }
    return hasMove;

}

- (NSInteger)indexAtNumList:(NSNumber *)num
{
    for (NSInteger i = 0; i < self.numList.count; i++) {
        if (self.numList[i] == num) {
            return i;
        }
    }
    return 0;
}

- (void)calculateScore:(NSInteger)index
{
    NSNumber *num = self.numList[index];
    self.score += num.intValue;
}

- (NSInteger)numAtIndex:(NSInteger)row column:(NSInteger)column
{
    NSNumber *result = self.numGrids[row][column];
    return result.intValue;
}

- (void)randomSetOneNum
{
    NSMutableArray *randomList = [[NSMutableArray alloc] init];
    for (NSInteger column = 0; column < self.numGrids.count; column++) {
        NSMutableArray *arr = self.numGrids[column];
        for (NSInteger row = 0; row < arr.count; row++) {
            if (arr[row] == self.numList[0]) {
                NSArray *tmp = [[NSArray alloc] initWithObjects:@(column), @(row), nil];
                [randomList addObject:tmp];
            }
        }
    }
    
    if (randomList.count > 0) {
        NSInteger random = arc4random()%randomList.count;
        NSArray *tmp = randomList[random];
        NSNumber *column = tmp[0];
        NSNumber *row = tmp[1];
        self.numGrids[column.intValue][row.intValue] = [self creatNewRandomNum];
    }
}

- (id)creatNewRandomNum
{
    NSInteger random = (arc4random()%100);
    if (random > 70) {
        return self.numList[2];
    }
    return self.numList[1];
}

- (void)checkGameOver
{
    for (NSInteger column = 0; column < self.numGrids.count; column++) {
        NSMutableArray *arr = self.numGrids[column];
        for (NSInteger row = 0; row < arr.count; row++) {
            if (arr[row] == self.numList[0]) {
                return;
            }
        }
    }
    
    for (NSInteger column = 0; column < 4; column++) {
        for (NSInteger row = 0; row < 4; row++) {
            if (row < 3 && self.numGrids[column][row] == self.numGrids[column][row + 1]) {
                return;
            }
            else if(column < 3 && self.numGrids[column][row] == self.numGrids[column + 1][row])
            {
                return;
            }
        }
    }
    
    [self gameOver];
}

- (void)gameOver
{
    NSLog(@"Game Over!!!");
    for (NSInteger column = 0; column < self.numGrids.count; column++) {
        NSMutableArray *arr = self.numGrids[column];
        for (NSInteger row = 0; row < arr.count; row++) {
            if ([arr[row] isEqual:self.numList[self.numList.count - 1]]) {
                self.statu = NumGameStatuSuccess;
                return;
            }
        }
    }
    self.statu = NumGameStatuOver;
}

@end
