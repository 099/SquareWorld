//
//  SquareWorldGameIconView.m
//  SquareWorld
//
//  Created by songrixi on 15-4-2.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "SquareWorldGameIconView.h"

@interface SquareWorldGameIconView ()

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *iconLabel;

@end

@implementation SquareWorldGameIconView


-(void)setGameData:(SquareWorldGameIconData *)gameData
{
    _gameData = gameData;
    
    if (self.iconButton == nil) {
        self.iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, gameData.iconWidth, gameData.iconWidth)];
         [self addSubview:self.iconButton];
        [self.iconButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.iconButton setImage:[UIImage imageNamed:gameData.iconName] forState:UIControlStateNormal];
    
    if (self.iconLabel == nil) {
        self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(-50, gameData.iconWidth + 10, gameData.iconWidth + 100, 20)];
        self.iconLabel.textAlignment = NSTextAlignmentCenter;
        self.iconLabel.textColor = [UIColor blackColor];
        self.iconLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [self addSubview:self.iconLabel];
    }
    self.iconLabel.text = gameData.gameName;
}

-(void)onClick:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:self.gameData.gameControllerName];
    [self.viewController presentViewController:viewController animated:NO completion:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
