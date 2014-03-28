//
//  CTCalculate.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "CTCalculate.h"
#import "NSString+EquationParser.h"
#import "NSMutableArray+Stacks.h"

@implementation CTCalculate
-(NSString *) solveQuestion:(NSString *) question
{
    NSMutableArray *numbersStack = [[NSMutableArray alloc] init];
    NSMutableArray *operandStack = [[NSMutableArray alloc] init];
    
    while([question length]>0)
    {
        NSString *nextElement = [question firstElement];// Remove first character from string
        question = [question stringByRemovingFirstElement];
        CTElementType elementType = [nextElement getElementType];
        if(elementType==CTElementTypeNumber)//If number add it to numbers stack
        {
            [numbersStack push:nextElement];
        }
        else if(elementType==CTElementTypeOpenBracket)//If open bracket add it to the operand stack
        {
            [operandStack push:nextElement];
        }
        else if(elementType==CTElementTypeCloseBracket)//If close bracket solve equation till last opened bracket
        {
            if(![self solveTillNextBracketOrNilForNumberStack:numbersStack operandStack:operandStack])
            {
                return @"Invalid String";
            }
            
            if([operandStack peek]==nil)
            {
                return @"Invalid String";
            }
            [operandStack pop];
        }
        else//If operand
        {
            NSString *topOperand = [operandStack peek];
            if(topOperand != nil && [topOperand precedes:nextElement])//if the previous operand has a higher precedence solve a single calculation
            {
                if(![self solveSingleOperationNumberStack:numbersStack operandStack:operandStack])
                {
                    return @"Invalid String";
                }
            }
            [operandStack push:nextElement];//add the new operand into the stack
        }
    }
    if(![self solveTillNextBracketOrNilForNumberStack:numbersStack operandStack:operandStack] && [operandStack peek]==nil && [numbersStack peek] !=nil)//Solve till only one element left in the number stack
    {
        return @"Invalid String";
    }
    return [numbersStack pop];
}
-(BOOL) solveTillNextBracketOrNilForNumberStack:(NSMutableArray *) numbersStack operandStack:(NSMutableArray *) operandStack
{
    while([operandStack peek]!=nil && [[operandStack peek] getElementType] != CTElementTypeOpenBracket)
    {
        if(![self solveSingleOperationNumberStack:numbersStack operandStack:operandStack])
        {
            return NO;
        }
    }
    return YES;
}
-(BOOL) solveSingleOperationNumberStack:(NSMutableArray *) numbersStack operandStack:(NSMutableArray *) operandStack
{
    NSString *topOperand = [operandStack pop];
    NSString *b = [numbersStack pop];
    NSString *a = [numbersStack pop];
    if(a==nil||b==nil)
    {
        return NO;
    }
    CTElementType topType = [topOperand getElementType];
    if(topType == CTElementTypeOpenBracket)
    {
        return NO;
    }
    [numbersStack push:[topOperand calculateForParamA:a paramB:b]];
    return YES;
}

@end
