//
//  TetrisBrickView.h
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TetrisGrid.h"

@interface TetrisBrickView : UIImageView

@property (nonatomic, strong) TetrisGrid *grid;

- (id)initBrickWidth:(CGFloat)width brickHeight:(CGFloat)height;
- (void)updateView:(BOOL)widthFrame;

+ (NSString *)imageName:(NSInteger)num;

@end
