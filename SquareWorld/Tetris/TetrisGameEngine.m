//
//  TetrisGameEngine.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisGameEngine.h"
#import "TetrisGrid.h"
#import "TetrisGridGroup.h"

@interface TetrisGameEngine()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger nextGridGroupIndex;
@property (nonatomic, strong) NSMutableArray *gridGroupData;
@property (nonatomic, strong) NSMutableArray *gridGroupTurnType;
@property (nonatomic) NSInteger dropSpeed;
@property (nonatomic) NSInteger cleanIndex;
@property (nonatomic, strong) NSMutableArray *cleanRows;

@end

@implementation TetrisGameEngine

+ (instancetype)game
{
    static TetrisGameEngine *game = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        game = [[TetrisGameEngine alloc] init];
    });
    return game;
}

- (id)init
{
    if (self = [super init]) {
        self.statu = TetrisGameStatuPrepare;
        self.gridList = [[NSMutableArray alloc] init];
        for (NSInteger column = 1; column <= TetrisColumnCount; column++) {
            for (NSInteger row = 1; row <= TetrisRowCount; row++) {
                TetrisGrid *grid = [[TetrisGrid alloc] init];
                grid.column = column;
                grid.row = row;
                [self.gridList addObject:grid];
            }
        }
        
        self.gridGroupData = [[NSMutableArray alloc] init];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @0, @1, @1, @0, @0, @1, @1, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @4, @0, @0, @0, @4, @0, @0, @0, @4, @0, @0, @0, @4, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @2, @2, @2, @2, @0, @0, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @3, @3, @0, @0, @3, @0, @0, @0, @3, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @5, @5, @0, @0, @0, @5, @0, @0, @0, @5, @0, @0, @0, @0, @0, nil]];
        
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @6, @0, @0, @0, @6, @6, @6, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @7, @7, @7, @0, @7, @0, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @2, @0, @0, @0, @2, @2, @0, @0, @2, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @1, @0, @0, @1, @1, @0, @0, @0, @1, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @0, @2, @0, @0, @2, @2, @2, @0, @0, @0, @0, @0, nil]];
        
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @3, @0, @0, @0, @3, @3, @0, @0, @0, @3, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @4, @0, @0, @4, @4, @0, @0, @4, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @5, @5, @0, @0, @0, @5, @5, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @0, @6, @6, @0, @6, @6, @0, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @7, @7, @7, @0, @0, @7, @0, @0, @0, @0, @0, @0, nil]];
        
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @0, @3, @3, @0, @0, @3, @3, @0, @0, @0, @0, @0, nil]];
        [self.gridGroupData addObject:[[NSArray alloc] initWithObjects:@0, @0, @0, @0, @0, @4, @4, @0, @0, @4, @4, @0, @0, @0, @0, @0, nil]];
        
        
        self.gridGroupTurnType = [[NSMutableArray alloc] init];
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@1];
        [self.gridGroupTurnType addObject:@2];
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        
        [self.gridGroupTurnType addObject:@2];
        [self.gridGroupTurnType addObject:@2];
        [self.gridGroupTurnType addObject:@1];
        [self.gridGroupTurnType addObject:@1];
        [self.gridGroupTurnType addObject:@0];
        
        [self.gridGroupTurnType addObject:@0];
        [self.gridGroupTurnType addObject:@0];
        
        self.currentGridGroup = [[TetrisGridGroup alloc] init];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.015f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)start
{
    self.statu = TetrisGameStatuPlaying;
    for (NSInteger i = 0; i < self.gridList.count; i++) {
        TetrisGrid *grid = self.gridList[i];
        grid.num = 0;
        grid.columnY = 0;
    }
    [self updateScore:0];
    self.nextGridGroupIndex = arc4random()%self.gridGroupData.count;
    [self creatTetrisGridGroup];
}

- (void)moveLeft
{
    if(self.statu != TetrisGameStatuPlaying) return;
    NSMutableArray *status = [self.currentGridGroup moveLeftStatus];
    if (![self isOverlap:status]) {
        [self.currentGridGroup moveLeft];
    }
}

-(void)moveRight
{
    if(self.statu != TetrisGameStatuPlaying) return;
    NSMutableArray *status = [self.currentGridGroup moveRightStatus];
    if (![self isOverlap:status]) {
        [self.currentGridGroup moveRight];
    }
}

-(void)moveBottom
{
    if(self.statu != TetrisGameStatuPlaying) return;
    TetrisGrid *startGrid = self.currentGridGroup.gridList[0];
    for (NSInteger row = 1; row <= TetrisRowCount; row++) {
        BOOL needStop = NO;
        for (TetrisGrid *grid in self.currentGridGroup.gridList) {
            if(grid.num > 0)
            {
                TetrisGrid *tmp = [self getGridAtRow:(grid.row-row) column:grid.column];
                if (tmp == nil || tmp.num > 0) {
                    needStop = true;
                    break;
                }
            }
        }
        if (needStop) {
            [self.currentGridGroup setRow:(startGrid.row-row+1) column:startGrid.column];
            break;
        }
    }
    
}

-(void)turn
{
    if(self.statu != TetrisGameStatuPlaying) return;
    NSMutableArray *status = [self.currentGridGroup turnStatus];
    if (![self isOverlap:status]) {
        [self.currentGridGroup turn];
    }
}

-(void)pasue
{
    self.statu = TetrisGameStatuPasue;
}

-(void)resume
{
    self.statu = TetrisGameStatuPlaying;
}

-(void)timerFireMethod:(NSTimer *)timer
{
    if(self.statu == TetrisGameStatuPlaying)
    {
        [self.currentGridGroup drop:self.dropSpeed];
        [self updateTerisGrids];
    }
    else if(self.statu == TetrisGameStatuCleaning)
    {
        self.cleanIndex --;
        if (self.cleanIndex <= 0) {
            self.statu = TetrisGameStatuPlaying;
            [self cleanTetris];
            [self.currentGridGroup reset];
            [self creatTetrisGridGroup];
        }
    }
}

- (void)creatTetrisGridGroup
{
    [self.currentGridGroup setNumList:self.gridGroupData[self.nextGridGroupIndex]];
    NSNumber *type = self.gridGroupTurnType[self.nextGridGroupIndex];
    self.currentGridGroup.turnType = (TetrisTurnType)type.integerValue;
    self.nextGridGroupIndex = arc4random()%self.gridGroupData.count;
}

- (void)updateTerisGrids
{
    BOOL needStop = NO;
    BOOL gameOver = NO;
    for (TetrisGrid *grid in self.currentGridGroup.gridList) {
        if (grid.columnY + self.dropSpeed < TetrisGridHeight) {
            break;
        }
        if(grid.num > 0)
        {
            TetrisGrid *tmp = [self getGridAtRow:(grid.row-1) column:grid.column];
            if (tmp == nil || tmp.num > 0) {
                needStop = YES;
                if (tmp.row == TetrisRowCount - TetrisGridGroupRowCount) {
                    gameOver = YES;
                }
            }
        }
    }
    
    if (gameOver)
    {
        self.statu = TetrisGameStatuOver;
        NSLog(@"game over!");
    }
    else if (needStop)
    {
        for (TetrisGrid *grid in self.currentGridGroup.gridList) {
            if(grid.num > 0)
            {
                TetrisGrid *tmp = [self getGridAtRow:grid.row column:grid.column];
                if (tmp != nil) {
                    tmp.num = grid.num;
                }
            }
        }
        
        if (self.statu == TetrisGameStatuPlaying) {
            TetrisGrid *startGrid = self.currentGridGroup.gridList[0];
            self.cleanRows = [self checkCleanTetris:startGrid.row];
            if (self.cleanRows.count > 0) {
                self.statu = TetrisGameStatuCleaning;
                self.cleanIndex = TetrisCleanTime;
                if (self.delegate != nil) {
                    [self.delegate cleanTetris:self.cleanRows];
                }
                return;
            }
        }
        [self.currentGridGroup reset];
        [self creatTetrisGridGroup];
    }
    
    if (self.delegate != nil) {
        [self.delegate updateTetrisStatus];
    }
}

- (NSMutableArray *)checkCleanTetris:(NSInteger)startRow
{
    NSMutableArray *celanRows = [[NSMutableArray alloc] init];
    for(NSInteger row = startRow; row > startRow-4; row--)
    {
        BOOL isFull = YES;
        for (NSInteger column = 1; column <= TetrisColumnCount; column++)
        {
            TetrisGrid *tmp = [self getGridAtRow:row column:column];
            if(tmp.num == 0)
            {
                isFull = NO;
                break;
            }
        }
        if (isFull) {
            [celanRows addObject:[[NSNumber alloc] initWithInteger:row]];
        }
    }
    return celanRows;
}

- (void)cleanTetris
{
    for (NSNumber *row in self.cleanRows) {
        for (NSInteger column = 1; column <= TetrisColumnCount; column++){
            TetrisGrid *tmp = [self getGridAtRow:row.integerValue column:column];
            tmp.num = 0;
        }
    }
    
    for (NSNumber *row in self.cleanRows) {
        for (NSInteger column = 1; column <= TetrisColumnCount; column++){
            for (NSInteger dropRow = row.integerValue; dropRow <= TetrisRowCount; dropRow ++) {
                TetrisGrid *tmp = [self getGridAtRow:dropRow column:column];
                TetrisGrid *up = [self getGridAtRow:(dropRow+1) column:column];
                if (up != nil) {
                    tmp.num = up.num;
                    up.num = 0;
                }
                else
                {
                    tmp.num = 0;
                }
            }
        }
    }
    
    [self updateScore:self.cleanRows.count];
    
    if (self.delegate != nil) {
        [self.delegate updateTetrisStatus];
    }
}

- (void)updateScore:(NSInteger)cleanRow
{
    switch (cleanRow) {
        case 1:
            self.score += 100;
            break;
        case 2:
            self.score += 300;
            break;
        case 3:
            self.score += 700;
            break;
        case 4:
            self.score += 1500;
            break;
        default:
            self.score += 0;
            break;
    }
    self.rowScore += cleanRow;
    self.level = self.score/10000 + 1;
    self.dropSpeed = self.level;
    //self.dropSpeed = 15;
}

- (TetrisGrid *)getGridAtRow:(NSInteger)row column:(NSInteger)column
{
    TetrisGrid *result = nil;
    for (TetrisGrid *grid in self.gridList) {
        if (grid.row == row && grid.column == column) {
            result = grid;
        }
    }
    return result;
}

- (BOOL)isOverlap:(NSMutableArray *)target
{
    if (target == nil) {
        return true;
    }
    for (TetrisGrid *grid in target) {
        if(grid.num > 0)
        {
            TetrisGrid *tmp = [self getGridAtRow:(grid.row) column:grid.column];
            if (tmp == nil || tmp.num > 0) {
                return true;
            }
        }
    }
    return false;
}

- (void)printGrids
{
    NSString *text = @"\n";
    for (NSInteger row = TetrisRowCount; row > 0; row--)
    {
        for (NSInteger column = 1; column <= TetrisColumnCount; column++)
        {
            TetrisGrid *grid = [self getGridAtRow:row column:column];
            text = [text stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)grid.num]];
            text = [text stringByAppendingString:@", "];
        }
        text = [text stringByAppendingString:@"\n"];
    }
    NSLog(@"%@", text);
}

@end
