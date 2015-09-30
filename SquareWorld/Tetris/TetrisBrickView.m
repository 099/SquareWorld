//
//  TetrisBrickView.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisBrickView.h"
#import "TetrisGameEngine.h"
#import "TetrisGridGroup.h"

@interface TetrisBrickView ()

@property (nonatomic) CGFloat brickWidth;
@property (nonatomic) CGFloat brickHeight;
@property (nonatomic) CGFloat brickY;

@end

@implementation TetrisBrickView

- (id)initBrickWidth:(CGFloat)width brickHeight:(CGFloat)height
{
    if (self = [super init]) {
        self.brickWidth = width;
        self.brickHeight = height;
    }
    return self;
}

- (void)updateView:(BOOL)widthFrame
{
    if (self.grid.num > 0 ) {
        self.image = [UIImage imageNamed:[TetrisBrickView imageName:self.grid.num]];
    }
    else
    {
        self.image = nil;
    }
    
    if (widthFrame) {
        if (self.grid.row > TetrisRowCount - TetrisGridGroupRowCount) {
            self.image = nil;
            return;
        }
        self.brickY = (TetrisRowCount - TetrisGridGroupRowCount - self.grid.row)*self.brickHeight;
        //self.brickY += self.brickHeight*self.grid.columnY/TetrisGridHeight;
        self.frame = CGRectMake((self.grid.column-1)*self.brickWidth, self.brickY, self.brickWidth, self.brickHeight);
    }
}

+ (NSString *)imageName:(NSInteger)num
{
    static NSMutableArray *imageNames = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        imageNames = [[NSMutableArray alloc] init];
        [imageNames addObject:@""];
        [imageNames addObject:@"rick1.png"];
        [imageNames addObject:@"rick2.png"];
        [imageNames addObject:@"rick3.png"];
        [imageNames addObject:@"rick4.png"];
        [imageNames addObject:@"rick5.png"];
        [imageNames addObject:@"rick6.png"];
        [imageNames addObject:@"rick7.png"];
        [imageNames addObject:@"rick8.png"];
        
    });
    if (num < imageNames.count) {
        return imageNames[num];
    }
    return nil;
}

@end
