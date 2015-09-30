//
//  TetrisGridGroup.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisGridGroup.h"
#import "TetrisGrid.h"
#import "TetrisGameEngine.h"

@interface TetrisGridGroup()

@end

@implementation TetrisGridGroup

- (id) init
{
    if(self = [super init])
    {
        self.gridList = [[NSMutableArray alloc] init];
        NSInteger len = TetrisGridGroupRowCount * TetrisGridGroupColumnCount;
        for (NSInteger i = 0; i < len; i++) {
            TetrisGrid *grid = [[TetrisGrid alloc] init];
            grid.num = 0;
            grid.columnY = 0;
            grid.row = TetrisRowCount - i/TetrisGridGroupRowCount;
            grid.column = (TetrisColumnCount - TetrisGridGroupColumnCount)/2 + 1 + i%TetrisGridGroupColumnCount;
            [self.gridList addObject:grid];
        }
    }
    return self;
}

- (void)setNumList:(NSArray *)list
{
    for (NSInteger i = 0; i < self.gridList.count; i++) {
        TetrisGrid *grid = self.gridList[i];
        NSNumber *num = list[i];
        grid.num = num.intValue;
    }
}

- (void)drop:(NSInteger)speed
{
    for (TetrisGrid *grid in self.gridList) {
        grid.columnY += speed;
        while (grid.columnY >= TetrisGridHeight)
        {
            grid.columnY -= TetrisGridHeight;
            grid.row --;
        }
    }
    
}

-(void)setRow:(NSInteger)row column:(NSInteger)column
{
    for (NSInteger i = 0; i < self.gridList.count; i++) {
        TetrisGrid *grid = self.gridList[i];
        grid.columnY = 0;
        grid.row = row - i/TetrisGridGroupRowCount;
        grid.column = column + i%TetrisGridGroupColumnCount;
    }
}

-(void)reset
{
    for (NSInteger i = 0; i < self.gridList.count; i++) {
        TetrisGrid *grid = self.gridList[i];
        grid.num = 0;
        grid.columnY = 0;
        grid.row = TetrisRowCount - i/TetrisGridGroupRowCount;
        grid.column = (TetrisColumnCount - TetrisGridGroupColumnCount)/2 + 1 + i%TetrisGridGroupColumnCount;
    }
}

- (void)moveLeft
{
    [self moveLeftGridList:self.gridList];
}

-(void)moveRight
{
    [self moveRightGridList:self.gridList];
}

-(void)turn
{
    switch (self.turnType) {
        case TetrisTurnTypeAll:
            [self turnRightGridList:self.gridList];
            break;
            
        case TetrisTurnTypeLeft:
            [self turnLeftGridList:self.gridList];
            self.turnType = TetrisTurnTypeRight;
            break;
            
        case TetrisTurnTypeRight:
            [self turnRightGridList:self.gridList];
            self.turnType = TetrisTurnTypeLeft;
            break;
            
        default:
            break;
    }
    
}

-(void)turnLeftGridList:(NSMutableArray*)gridList
{
    NSMutableArray *tmp = [self copyGridList];
    NSMutableArray *cycleOut = [self changeCycleOut:tmp];
    NSMutableArray *cycleIn = [self changeCycleIn:tmp];
    
    for (NSInteger i = 0; i < cycleOut.count; i++) {
        NSInteger rightIndex = i + 3;
        if (rightIndex >= cycleOut.count) {
            rightIndex -= cycleOut.count;
        }
        TetrisGrid *rightGrid = cycleOut[rightIndex];
        TetrisGrid *tmpGrid = cycleOut[i];
        TetrisGrid *targetGrid = [self getGridAtRow:tmpGrid.row column:tmpGrid.column gridList:gridList];
        targetGrid.num = rightGrid.num;
    }
    
    for (NSInteger i = 0; i < cycleIn.count; i++) {
        NSInteger rightIndex = i + 1;
        if (rightIndex >= cycleIn.count) {
            rightIndex -= cycleIn.count;
        }
        TetrisGrid *rightGrid = cycleIn[rightIndex];
        TetrisGrid *tmpGrid = cycleIn[i];
        TetrisGrid *targetGrid = [self getGridAtRow:tmpGrid.row column:tmpGrid.column gridList:gridList];
        targetGrid.num = rightGrid.num;
    }
}

-(void)turnRightGridList:(NSMutableArray*)gridList
{
    NSMutableArray *tmp = [self copyGridList];
    NSMutableArray *cycleOut = [self changeCycleOut:tmp];
    NSMutableArray *cycleIn = [self changeCycleIn:tmp];
    
    for (NSInteger i = 0; i < cycleOut.count; i++) {
        NSInteger leftIndex = i - 3;
        if (leftIndex < 0) {
            leftIndex += cycleOut.count;
        }
        TetrisGrid *leftGrid = cycleOut[leftIndex];
        TetrisGrid *tmpGrid = cycleOut[i];
        TetrisGrid *targetGrid = [self getGridAtRow:tmpGrid.row column:tmpGrid.column gridList:gridList];
        targetGrid.num = leftGrid.num;
    }
    
    for (NSInteger i = 0; i < cycleIn.count; i++) {
        NSInteger leftIndex = i - 1;
        if (leftIndex < 0) {
            leftIndex += cycleIn.count;
        }
        TetrisGrid *leftGrid = cycleIn[leftIndex];
        TetrisGrid *tmpGrid = cycleIn[i];
        TetrisGrid *targetGrid = [self getGridAtRow:tmpGrid.row column:tmpGrid.column gridList:gridList];
        targetGrid.num = leftGrid.num;
       
    }
}

-(NSMutableArray *)changeCycleOut:(NSMutableArray*)gridList
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:gridList[0]];
    [result addObject:gridList[1]];
    [result addObject:gridList[2]];
    [result addObject:gridList[3]];
    
    [result addObject:gridList[7]];
    [result addObject:gridList[11]];
    [result addObject:gridList[15]];
    [result addObject:gridList[14]];
    
    [result addObject:gridList[13]];
    [result addObject:gridList[12]];
    [result addObject:gridList[8]];
    [result addObject:gridList[4]];
    return result;
}

-(NSMutableArray *)changeCycleIn:(NSMutableArray*)gridList
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:gridList[5]];
    [result addObject:gridList[6]];
    [result addObject:gridList[10]];
    [result addObject:gridList[9]];
    return result;
}

- (TetrisGrid *)getGridAtRow:(NSInteger)row column:(NSInteger)column gridList:(NSMutableArray*)gridList
{
    TetrisGrid *result = nil;
    for (TetrisGrid *grid in gridList) {
        if (grid.row == row && grid.column == column) {
            result = grid;
            break;
        }
    }
    return result;
}

-(BOOL)moveLeftGridList:(NSMutableArray*)gridList
{
    for (TetrisGrid *grid in gridList) {
        if (grid.column == 1 && grid.num > 0) {
            return false;
        }
    }
    for (TetrisGrid *grid in gridList) {
        grid.column -- ;
    }
    return true;
}

-(BOOL)moveRightGridList:(NSMutableArray*)gridList
{
    for (TetrisGrid *grid in gridList) {
        if (grid.column == TetrisColumnCount && grid.num > 0) {
             return false;
        }
    }
    
    for (TetrisGrid *grid in gridList) {
            grid.column ++;
    }
    
    return true;
}

-(NSMutableArray *)moveLeftStatus
{
    NSMutableArray *result = [self copyGridList];
    if ([self moveLeftGridList:result]) {
         return result;
    };
     return nil;
}

-(NSMutableArray *)moveRightStatus
{
    NSMutableArray *result = [self copyGridList];
    if ([self moveRightGridList:result]) {
        return result;
    }
    return nil;
}

-(NSMutableArray *)turnStatus
{
    NSMutableArray *result = [self copyGridList];
    switch (self.turnType) {
        case TetrisTurnTypeAll:
            [self turnRightGridList:result];
            break;
            
        case TetrisTurnTypeLeft:
            [self turnLeftGridList:result];
            break;
            
        case TetrisTurnTypeRight:
            [self turnRightGridList:result];
            break;
            
        default:
            break;
    }
    
    for (TetrisGrid *grid in result) {
        if (grid.num > 0 && (grid.column < 1 || grid.column > TetrisColumnCount || grid.row < 1)) {
            return nil;
        }
    }
    
    return result;
}

-(NSMutableArray *)copyGridList
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (TetrisGrid *grid in self.gridList) {
        [result addObject:[grid copy]];
    }
    return result;
}

@end
