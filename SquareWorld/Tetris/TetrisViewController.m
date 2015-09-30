//
//  ViewController.m
//  Tetris
//
//  Created by songrixi on 15-3-13.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "TetrisViewController.h"
#import "TetrisGameEngine.h"
#import "TetrisGrid.h"
#import "TetrisGridGroup.h"
#import "TetrisBrickView.h"
#import "TetrisBrickGroupView.h"

@interface TetrisViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *gridContent;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIView *prevViewContent;
@property (weak, nonatomic) IBOutlet UIButton *moveLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *moveRightButton;

@property (nonatomic, strong) TetrisGameEngine *game;
@property (nonatomic, strong) NSMutableArray *brickViews;
@property (nonatomic, strong) TetrisBrickGroupView *brickGroupView;
@property (nonatomic, strong) TetrisBrickGroupView *prevGroupView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) BOOL longPressLeftButton;
@property (nonatomic) BOOL longPressRightButton;

@end

@implementation TetrisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [TetrisGameEngine game];
    self.game.delegate = self;
    self.brickViews = [[NSMutableArray alloc] init];
    
    NSInteger rowCount = TetrisRowCount - TetrisGridGroupRowCount;
    CGFloat brickWidth = self.gridContent.frame.size.width / TetrisColumnCount;
    CGFloat brickHeight = self.gridContent.frame.size.height / rowCount;
    
    for (TetrisGrid *grid in self.game.gridList) {
        if (grid.row > rowCount) {
            continue;
        }
        TetrisBrickView *brick = [[TetrisBrickView alloc] initBrickWidth:brickWidth brickHeight:brickHeight];
        brick.grid = grid;
        [brick updateView:YES];
        
        [self.gridContent addSubview:brick];
        [self.brickViews addObject:brick];
    }
    
    self.brickGroupView = [[TetrisBrickGroupView alloc] initBrickWidth:brickWidth brickHeight:brickHeight];
    self.brickGroupView.frame = CGRectMake(0, 0, self.gridContent.frame.size.width, self.gridContent.frame.size.height);
    self.brickGroupView.gridGroup = self.game.currentGridGroup;
    [self.gridContent addSubview:self.brickGroupView];
    
    UILongPressGestureRecognizer *leftGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressLeftButton:)];
    leftGesture.minimumPressDuration = 0.3f;
    [self.moveLeftButton addGestureRecognizer:leftGesture];
    
    UILongPressGestureRecognizer *rightGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressRightButton:)];
    rightGesture.minimumPressDuration = 0.3f;
    [self.moveRightButton addGestureRecognizer:rightGesture];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    [self.game start];
}

- (void)updateTetrisStatus
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.game.score];
    self.levelLabel.text = [NSString stringWithFormat:@"%ld", (long)self.game.level];
    self.lineLabel.text = [NSString stringWithFormat:@"%ld", (long)self.game.rowScore];
    [self.brickGroupView updateView:YES];
    for (TetrisBrickView *brick in self.brickViews) {
        [brick updateView:NO];
    }
}

- (void)cleanTetris:(NSMutableArray *)cleanRows
{
    
}

- (void)handleLongPressLeftButton:(UILongPressGestureRecognizer *)paramSender
{
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        self.longPressLeftButton = YES;
    }
    else if (paramSender.state == UIGestureRecognizerStateEnded)
    {
        self.longPressLeftButton = NO;
    }
    
}

- (void)handleLongPressRightButton:(UILongPressGestureRecognizer *)paramSender
{
    if (paramSender.state == UIGestureRecognizerStateBegan)
    {
        self.longPressRightButton = YES;
    }
    else if (paramSender.state == UIGestureRecognizerStateEnded)
    {
        self.longPressRightButton = NO;
    }
    
}

-(void)timerFireMethod:(NSTimer *)timer
{
    if (self.longPressLeftButton)
    {
        [self.game moveLeft];
    }
    else if (self.longPressRightButton)
    {
        [self.game moveRight];
    }
}

- (IBAction)moveLeftHandle:(id)sender {
    [self.game moveLeft];
}

- (IBAction)moveRightHandle:(id)sender {
    [self.game moveRight];
}

- (IBAction)moveDownHandle:(id)sender {
    [self.game moveBottom];
}

- (IBAction)stopHandle:(id)sender {
    if (self.game.statu == TetrisGameStatuPlaying)
    {
       [self.game pasue];
    }
    else if (self.game.statu == TetrisGameStatuPasue)
    {
        [self.game resume];
    }
    
}

- (IBAction)turnHandle:(id)sender {
    [self.game turn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
