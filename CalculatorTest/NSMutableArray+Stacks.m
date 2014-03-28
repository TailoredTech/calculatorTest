//
//  NSMutableArray+Stacks.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "NSMutableArray+Stacks.h"

@implementation NSMutableArray (Calculator)
-(void) push:(NSString *) obj
{
    [self addObject:obj];
}
-(NSString *) pop
{
    if([self count]>0)
    {
        NSString *topObject = [self lastObject];
        [self removeLastObject];
        return topObject;
    }
    return nil;
}

-(NSString *) peek
{
    if([self count]>0)
    {
        NSString *topObject = [self lastObject];
        return topObject;
    }
    return nil;
}

@end
