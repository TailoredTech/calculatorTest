//
//  NSMutableArray+Stacks.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "NSMutableArray+Stacks.h"

@implementation NSMutableArray (Calculator)
-(void) push:(id) obj
{
    [self addObject:obj];
}
-(id) pop
{
    if([self count]>0)
    {
        id topObject = [self lastObject];
        [self removeLastObject];
        return topObject;
    }
    return nil;
}

-(id) peek
{
    if([self count]>0)
    {
        id topObject = [self lastObject];
        return topObject;
    }
    return nil;
}

@end
