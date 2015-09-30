//
//  ViewController.m
//  SquareWorld
//
//  Created by songrixi on 15-4-2.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "SquareWorldViewController.h"
#import "SquareWorldGameIconView.h"
#import "SquareWorldGameIconData.h"

@interface SquareWorldViewController ()

@property (nonatomic, strong) NSMutableArray *gameDatas;
@property (nonatomic, strong) NSMutableArray *gameIcons;

@end

@implementation SquareWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float width = self.view.frame.size.width;
    float iconWidth = width/9;
    
    self.gameDatas = [[NSMutableArray alloc] init];
    [self.gameDatas addObject:[[SquareWorldGameIconData alloc] initWithGameName:@"2048" iconName:@"Num2048.png" iconWidth:iconWidth controllerName:@"NumViewController"]];
    [self.gameDatas addObject:[[SquareWorldGameIconData alloc] initWithGameName:@"经典俄罗斯" iconName:@"Tetris.png" iconWidth:iconWidth controllerName:@"TetrisViewController"]];
    
    self.gameIcons = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.gameDatas.count; i++) {
        SquareWorldGameIconData *gameData = self.gameDatas[i];
        float x = (i%4)*iconWidth*2 + iconWidth;
        float y = (i/4)*(iconWidth + 50) + 50;
        SquareWorldGameIconView *iconItem = [[SquareWorldGameIconView alloc] initWithFrame:CGRectMake(x, y, iconWidth, iconWidth)];
        iconItem.gameData = gameData;
        iconItem.viewController = self;
        [self.view addSubview:iconItem];
        [self.gameIcons addObject:iconItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
