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
@interface CTCalculate()
{
    NSMutableArray *_numbersStack;
    NSMutableArray *_operandStack;
}
@end

@implementation CTCalculate
-(NSString *) solveQuestion:(NSString *) question
{
    _numbersStack = [[NSMutableArray alloc] init];
    _operandStack = [[NSMutableArray alloc] init];
    
    while([question length]>0)
    {
        NSString *nextElement = [question firstElement];// Remove first character from string
        question = [question stringByRemovingFirstElement];
        CTElementType elementType = [nextElement getElementType];
        if(elementType==CTElementTypeNumber)//If number add it to numbers stack
        {
            [_numbersStack push:nextElement];
        }
        else if(elementType==CTElementTypeOpenBracket)//If open bracket add it to the operand stack
        {
            [_operandStack push:nextElement];
        }
        else if(elementType==CTElementTypeCloseBracket)//If close bracket solve equation till last opened bracket
        {
            if(![self solveTillNextBracketOrNil])
            {
                return @"Invalid String";
            }
            
            if([_operandStack peek]==nil)
            {
                return @"Invalid String";
            }
            [_operandStack pop];
        }
        else//If operand
        {
            NSString *topOperand = [_operandStack peek];
            if(topOperand != nil && [topOperand precedes:nextElement])//if the previous operand has a higher precedence solve a single calculation
            {
                if(![self solveSingleOperation])
                {
                    return @"Invalid String";
                }
            }
            [_operandStack push:nextElement];//add the new operand into the stack
        }
    }
    if(![self solveTillNextBracketOrNil] && [_operandStack peek]==nil && [_numbersStack peek] !=nil)//Solve till only one element left in the number stack
    {
        return @"Invalid String";
    }
    return [_numbersStack pop];
}
-(BOOL) solveTillNextBracketOrNil
{
    while([_operandStack peek]!=nil && [[_operandStack peek] getElementType] != CTElementTypeOpenBracket)
    {
        if(![self solveSingleOperation])
        {
            return NO;
        }
    }
    return YES;
}
-(BOOL) solveSingleOperation
{
    NSString *topOperand = [_operandStack pop];
    NSString *b = [_numbersStack pop];
    NSString *a = [_numbersStack pop];
    if(a==nil||b==nil)
    {
        return NO;
    }
    CTElementType topType = [topOperand getElementType];
    if(topType == CTElementTypeOpenBracket)
    {
        return NO;
    }
    [_numbersStack push:[topOperand calculateForParamA:a paramB:b]];
    return YES;
}

@end
