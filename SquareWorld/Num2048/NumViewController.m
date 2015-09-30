//
//  ViewController.m
//  Num
//
//  Created by songrixi on 15-2-9.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "NumViewController.h"
#import "NumItemView.h"
#import "NumGameEngine.h"
#import "NumResultViewController.h"

@interface NumViewController ()

@property (strong, nonatomic) UIView *numContainer;
@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UILabel *highScoreLabel;

@property (nonatomic, strong) NSMutableArray *numItems;
@property (nonatomic, strong) NumGameEngine *game;


@end

@implementation NumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViews];
    [self creatNumItems];
    self.game = [NumGameEngine game];
    [self gameStart];
    
    for (NSInteger i = 0; i < 4; i++) {
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
        gesture.numberOfTouchesRequired = 1;
        gesture.direction = 1 << i;
        [self.view addGestureRecognizer:gesture];
    }
}

- (void)creatViews
{
    float screenWidth = self.view.frame.size.width;
    float screenHeight = self.view.frame.size.height;
    
    float numContainerWidth = screenWidth - 40;
    self.numContainer = [[UIView alloc] initWithFrame:CGRectMake(20, screenHeight-numContainerWidth -20, numContainerWidth, numContainerWidth)];
    self.numContainer.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.numContainer];
    
    float titleWidth = (screenHeight-numContainerWidth)/2;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, titleWidth, titleWidth)];
    titleView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:218.0f/255.0f blue:123.0f/255.0f alpha:1];
    [self.view addSubview:titleView];
    UILabel *titleLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleWidth)];
    titleLabel.font = [UIFont systemFontOfSize:titleWidth*0.4f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"2048";
    [titleView addSubview:titleLabel];
    
    UILabel *tipLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, self.numContainer.frame.origin.y - 50, screenWidth-40, 40)];
    tipLabel.font = [UIFont systemFontOfSize:24];
    tipLabel.text = @"合并这些数字以得到2048方块！";
    [self.view addSubview:tipLabel];
    
    UIView *highScoreView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - titleWidth - 20, 20, titleWidth, titleWidth)];
    highScoreView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:highScoreView];
    UILabel *highScoreLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleWidth*0.5f)];
    highScoreLabel.font = [UIFont systemFontOfSize:24];
    highScoreLabel.textAlignment = NSTextAlignmentCenter;
    highScoreLabel.textColor = [UIColor lightGrayColor];
    highScoreLabel.text = @"历史最高";
    [highScoreView addSubview:highScoreLabel];
    self.highScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleWidth*0.4f, titleWidth, titleWidth*0.5f)];
    self.highScoreLabel.font = [UIFont systemFontOfSize:36];
    self.highScoreLabel.textAlignment = NSTextAlignmentCenter;
    self.highScoreLabel.textColor = [UIColor whiteColor];
    self.highScoreLabel.text = @"0";
    [highScoreView addSubview:self.highScoreLabel];
    
    UIView *scoreView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth - titleWidth *2 - 40, 20, titleWidth, titleWidth)];
    scoreView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scoreView];
    UILabel *scoreLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleWidth, titleWidth*0.5f)];
    scoreLabel.font = [UIFont systemFontOfSize:24];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.textColor = [UIColor lightGrayColor];
    scoreLabel.text = @"分数";
    [scoreView addSubview:scoreLabel];
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleWidth*0.4f, titleWidth, titleWidth*0.5f)];
    self.scoreLabel.font = [UIFont systemFontOfSize:36];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.text = @"0";
    [scoreView addSubview:self.scoreLabel];
    
    UIButton *reStartButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - titleWidth*0.8f - 20, self.numContainer.frame.origin.y - 70, titleWidth*0.8f, 60)];
    [reStartButton setBackgroundColor:[UIColor colorWithRed:226.0f/255.0f green:112.0f/255.0f blue:75.0f/255.0f alpha:1]];
    [reStartButton setTitle:@"重新开始" forState:UIControlStateNormal];
    [reStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reStartButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5f] forState:UIControlStateHighlighted];
    [reStartButton addTarget:self action:@selector(reStartHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reStartButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatNumItems
{
    CGRect itemFrame;
    NSInteger spacing = 10;
    CGFloat itemWidth = (self.numContainer.frame.size.width - spacing)/4;
   
    self.numItems = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 0; j < 4; j++) {
            itemFrame = CGRectMake(j*itemWidth + spacing, i*itemWidth + spacing, itemWidth - spacing, itemWidth - spacing);
            NumItemView *numItem = [[NumItemView alloc] initWithFrame:itemFrame];
            numItem.row = i;
            numItem.column = j;
            
            [self.numItems addObject:numItem];
            [self.numContainer addSubview:numItem];
        }
    }
}

-(void)gameStart
{
    [self.game start];
    [self updateNumItems];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highestScore = [userDefaults integerForKey:@"highestScore"];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%ld", (long)highestScore];
}

- (void)updateNumItems
{
    for (NumItemView *item in self.numItems) {
        item.num = [self.game numAtIndex:item.row column:item.column];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.game.score];
    
    if (self.game.statu == NumGameStatuOver || self.game.statu == NumGameStatuSuccess)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        NumResultViewController *resultViewController = [storyboard instantiateViewControllerWithIdentifier:@"NumResultViewController"];
        [resultViewController showResult:(self.game.statu == NumGameStatuSuccess) score:self.game.score];
        [resultViewController setCallback:^{
            [self gameStart];
        }];
        [self presentViewController:resultViewController animated:NO completion:nil];
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)paramSender
{
    if (paramSender.direction & UISwipeGestureRecognizerDirectionLeft) {
        [self.game move:NumMoveDirectionLeft];
    }
    else if (paramSender.direction & UISwipeGestureRecognizerDirectionRight)
    {
        [self.game move:NumMoveDirectionRight];
    }
    else if (paramSender.direction & UISwipeGestureRecognizerDirectionUp)
    {
        [self.game move:NumMoveDirectionUp];
    }
    else if(paramSender.direction & UISwipeGestureRecognizerDirectionDown)
    {
        [self.game move:NumMoveDirectionDown];
    }
    [self updateNumItems];
}


- (void)reStartHandle:(UIButton *)sender {
    [self.game start];
    [self updateNumItems];
}

@end
