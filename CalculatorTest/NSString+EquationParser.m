//
//  NSString+EquationParser.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "NSString+EquationParser.h"

@implementation NSString (PublicParser)
//Returns whether operand A has a higher precedence than B
//For example if a is "x" and b is "+" it return YES
-(BOOL) precedes:(NSString *)operand;
{
    return ([self scoreForOperand]>=[operand scoreForOperand]);
}

//Perform operation
-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr
{
    CGFloat a = [aStr floatValue];
    CGFloat b = [bStr floatValue];
    CGFloat answer = 0;
    if([self isEqualToString:@"/"])
    {
        answer = a/b;
    }
    else if([self isEqualToString:@"+"])
    {
        answer = a+b;
    }
    else if([self isEqualToString:@"-"])
    {
        answer = a-b;
    }
    else if([self isEqualToString:@"x"])
    {
        answer = a*b;
    }
    return [NSString stringWithFormat:@"%f", answer];
}

-(NSInteger) scoreForOperand
{
    if([self isEqualToString:@"/"] || [self isEqualToString:@"x"])
    {
        return 5;
    }
    else if([self isEqualToString:@"-"]||[self isEqualToString:@"+"])
    {
        return 4;
    }
    else
    {
        return 3;
    }
}

//get self minus the first character
-(NSString *) stringByRemovingFirstElement
{
    NSString *firstElement = [self firstElement];
    if([self length]>=[firstElement length])
    {
        return  [self substringFromIndex:[firstElement length]];
    }
    return @"";
}
//get first character
-(NSString *) firstElement
{
    if([self length]>0)
    {
        if([[self substringToIndex:1] isNumber])
        {
            NSInteger i=0;
            while(i<[self length]&&[[self substringToIndex:i+1] isNumber])
            {
                i++;
            }
            return [self substringToIndex:i];
        }
        return [self substringToIndex:1];
    }
    return @"";
}

//check whether  character is operand, opening bracket, closed bracket  or number
-(CTElementType)getElementType
{
    if([self checkRegex:@"^(?:\\+|-|\\/|x)$"])
    {
        return CTElementTypeOperand;
    }
    else if([self isEqualToString:@"("])
    {
        return CTElementTypeOpenBracket;
    }
    else if([self isEqualToString:@")"])
    {
        return CTElementTypeCloseBracket;
    }
    else if([self isNumber])
    {
        return CTElementTypeNumber;
    }
    return CTElementTypeInvalid;
}

#pragma mark Ignore

//String to float
-(CGFloat) floatValue
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:self];
    return [myNumber floatValue];
}

-(BOOL) isNumber
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:self];
    return (myNumber!=nil);
}
-(BOOL) checkRegex:(NSString *) regex
{
    NSPredicate *regText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regText evaluateWithObject:self];
}

//get last character in a string or return empty string
-(NSString *) lastCharacter
{
    if([self length]>0)
    {
        return [self substringFromIndex:[self length]-1];
    }
    return @"";
}
@end
