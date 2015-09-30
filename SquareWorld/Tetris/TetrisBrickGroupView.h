//
//  TetrisBrickGroup.h
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisGridGroup.h"

@interface TetrisBrickGroupView : UIView

@property (nonatomic, strong) TetrisGridGroup *gridGroup;

- (id)initBrickWidth:(CGFloat)width brickHeight:(CGFloat)height;
- (void)updateView:(BOOL)widthFrame;

@end
