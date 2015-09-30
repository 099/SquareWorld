//
//  TetrisBrickGroup.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisBrickGroupView.h"
#import "TetrisBrickView.h"
#import "TetrisGrid.h"
#import "TetrisGameEngine.h"

@interface TetrisBrickGroupView ()

@property (nonatomic, strong) NSMutableArray *brickViews;
@property (nonatomic) CGFloat brickWidth;
@property (nonatomic) CGFloat brickHeight;

@end

@implementation TetrisBrickGroupView

- (id)initBrickWidth:(CGFloat)width brickHeight:(CGFloat)height
{
    if (self = [super init]) {
        self.brickWidth = width;
        self.brickHeight = height;
    }
    return self;
}

- (void)setGridGroup:(TetrisGridGroup *)gridGroup
{
    _gridGroup = gridGroup;
    
    self.brickViews = [[NSMutableArray alloc] init];
    for (TetrisGrid *grid in self.gridGroup.gridList) {
        TetrisBrickView *brick = [[TetrisBrickView alloc] initBrickWidth:self.brickWidth brickHeight:self.brickHeight];
        brick.grid = grid;
        [self addSubview:brick];
        [self.brickViews addObject:brick];
    }
}

- (void)updateView:(BOOL)widthFrame
{
    for (TetrisBrickView *brick in self.brickViews) {
        [brick updateView:widthFrame];
    }
}

@end
