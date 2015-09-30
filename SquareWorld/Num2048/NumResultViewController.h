//
//  NumResultViewController.h
//  Num
//
//  Created by songrixi on 15-2-14.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumResultViewController : UIViewController

@property(nonatomic, copy)void(^callback)();

- (void)showResult:(BOOL)result score:(NSInteger)score;


@end
