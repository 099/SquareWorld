//
//  NumItemView.m
//  Num
//
//  Created by songrixi on 15-2-10.
//  Copyright (c) 2015年 songrixi. All rights reserved.
//

#import "NumItemView.h"

static NSMutableDictionary *labelColorDict;
static NSMutableDictionary *viewColorDict;

@implementation NumItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.numLabel.font = [UIFont systemFontOfSize:40];
        self.numLabel.text = @"";
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.numLabel];
        
        if (labelColorDict == nil) {
            labelColorDict = [[NSMutableDictionary alloc] init];
            [labelColorDict setObject:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1] forKey:@"2"];
            [labelColorDict setObject:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1] forKey:@"4"];
            [labelColorDict setObject:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1] forKey:@"8"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:200.0f/255.0f alpha:1] forKey:@"16"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:200.0f/255.0f alpha:1] forKey:@"32"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:200.0f/255.0f alpha:1] forKey:@"64"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forKey:@"128"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forKey:@"256"];
            [labelColorDict setObject:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forKey:@"512"];
            [labelColorDict setObject:[UIColor colorWithRed:0.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forKey:@"1024"];
            [labelColorDict setObject:[UIColor colorWithRed:0.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1] forKey:@"2048"];
        }
        
        if (viewColorDict == nil) {
            viewColorDict = [[NSMutableDictionary alloc] init];
            [viewColorDict setObject:[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1] forKey:@"2"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:220.0f/255.0f blue:190.0f/255.0f alpha:1] forKey:@"4"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:166.0f/255.0f blue:152.0f/255.0f alpha:1] forKey:@"8"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:134.0f/255.0f blue:112.0f/255.0f alpha:1] forKey:@"16"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:111.0f/255.0f blue:75.0f/255.0f alpha:1] forKey:@"32"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:74.0f/255.0f blue:50.0f/255.0f alpha:1] forKey:@"64"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:0.0f/255.0f blue:30.0f/255.0f alpha:1] forKey:@"128"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:0.0f/255.0f blue:90.0f/255.0f alpha:1] forKey:@"256"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:0.0f/255.0f blue:150.0f/255.0f alpha:1] forKey:@"512"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:130.0f/255.0f blue:0.0f/255.0f alpha:1] forKey:@"1024"];
            [viewColorDict setObject:[UIColor colorWithRed:230.0f/255.0f green:180.0f/255.0f blue:0.0f/255.0f alpha:1] forKey:@"2048"];
        }
    }
    return self;
}

- (void)setNum:(NSInteger)num
{
    _num = num;
    if (self.num > 0)
    {
        self.numLabel.text = [NSString stringWithFormat:@"%ld", (long)self.num];
        self.numLabel.textColor = [labelColorDict valueForKey:self.numLabel.text];
        self.backgroundColor = [viewColorDict valueForKey:self.numLabel.text];
        
        float labelWidth = self.numLabel.frame.size.width;
        self.numLabel.font = [UIFont systemFontOfSize:(labelWidth * (0.7f - self.numLabel.text.length*0.1f))];
    }
    else
    {
        self.numLabel.text = @"";
        self.backgroundColor = [UIColor grayColor];
    }
}

@end
