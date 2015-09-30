//
//  SquareWorldGameIconData.m
//  SquareWorld
//
//  Created by songrixi on 15-4-2.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "SquareWorldGameIconData.h"

@implementation SquareWorldGameIconData

-(id)initWithGameName:(NSString *)gameName iconName:(NSString *)iconName iconWidth:(float)iconWidth controllerName:(NSString *)controllerName
{
    if(self =[super init])
    {
        _gameName = gameName;
        _iconName = iconName;
        _iconWidth = iconWidth;
        _gameControllerName = controllerName;
    }
    return self;
}

@end
