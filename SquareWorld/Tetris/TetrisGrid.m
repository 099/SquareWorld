//
//  TetrisGrid.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisGrid.h"

@implementation TetrisGrid

-(id) copy
{
    TetrisGrid *grid = [[TetrisGrid alloc] init];
    grid.row = self.row;
    grid.column = self.column;
    grid.columnY = self.columnY;
    grid.num = self.num;
    return grid;
}

@end
