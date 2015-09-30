//
//  NumResultViewController.m
//  Num
//
//  Created by songrixi on 15-2-14.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "NumResultViewController.h"

@interface NumResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) BOOL result;
@property (nonatomic) NSInteger score;

@end

@implementation NumResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.result) {
        self.resultLabel.text = @"You are win!";
    }
    else
    {
        self.resultLabel.text = @"You are lose!";
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showResult:(BOOL)result score:(NSInteger)score
{
    self.result = result;
    self.score = score;
    [self saveHighestScore:score];
}

- (void)saveHighestScore:(NSInteger)score
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger highestScore = [userDefaults integerForKey:@"highestScore"];
    NSLog(@"highestScore: %ld", (long)highestScore);
    if (score > highestScore) {
        [userDefaults setInteger:score forKey:@"highestScore"];
    }
    [userDefaults synchronize];
}

- (IBAction)handleConfirm:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)handleGameRestart:(id)sender {
    if (self.callback != nil) {
        self.callback();
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
