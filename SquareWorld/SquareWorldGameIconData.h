//
//  SquareWorldGameIconData.h
//  SquareWorld
//
//  Created by songrixi on 15-4-2.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareWorldGameIconData : NSObject

@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic) float iconWidth;
@property (nonatomic, strong) NSString *gameControllerName;

-(id) initWithGameName:(NSString *)gameName iconName:(NSString *)iconName iconWidth:(float)iconWidth controllerName:(NSString *)controllerName;

@end
