//
//  CTViewController.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 27/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "CTViewController.h"

@interface CTViewController ()

@end

@implementation CTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *) solveQuestion:(NSString *) question
{
    NSMutableArray *numbersStack = [[NSMutableArray alloc] init];
    NSMutableArray *operandStack = [[NSMutableArray alloc] init];

    while([question length]>0)
    {
        NSString *nextChar = [self getFirstCharacter:question];
        question = [self stringByRemovingFirstCharacter:question];
        CTButtonType charType = [self getTypeForString:nextChar];
        if(charType==CTButtonTypeNumber)
        {
            [numbersStack push:nextChar];
        }
        else if(charType==CTButtonTypeOpenBracket)
        {
            [operandStack push:nextChar];
        }
        else if(charType==CTButtonTypeCloseBracket)
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
        else
        {
            NSString *topOperand = [operandStack peek];
            if(topOperand == nil)
            {
                [operandStack push:nextChar];
            }
            else if([self operandA:topOperand precedesOperandB:nextChar])
            {
                if(![self solveSingleOperationNumberStack:numbersStack operandStack:operandStack])
                {
                    return @"Invalid String";
                }
                [operandStack push:nextChar];
            }
            else
            {
                [operandStack push:nextChar];
            }
        }
    }
    if(![self solveTillNextBracketOrNilForNumberStack:numbersStack operandStack:operandStack])
    {
        return @"Invalid String";
    }
    return [numbersStack pop];
}
-(BOOL) solveTillNextBracketOrNilForNumberStack:(NSMutableArray *) numbersStack operandStack:(NSMutableArray *) operandStack
{
    while([operandStack peek]!=nil && [self getTypeForString:[operandStack peek]] != CTButtonTypeOpenBracket)
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
    CTButtonType topType = [self getTypeForString:topOperand];
    if(topType == CTButtonTypeOpenBracket)
    {
        return NO;
    }
    [numbersStack push:[self calculateForParamA:a paramB:b usingOperand:topOperand]];
    return YES;
}
#pragma mark Utility Function
//Returns whether operand A has a higher precedence than B
//For example if a is "x" and b is "+" it return YES
-(BOOL) operandA:(NSString *) a precedesOperandB:(NSString *)b
{
    return ([self scoreForOperand:a]>[self scoreForOperand:b]);
}
-(NSInteger) scoreForOperand:(NSString *) str
{
    if([str isEqualToString:@"/"] || [str isEqualToString:@"x"])
    {
        return 5;
    }
    else if([str isEqualToString:@"-"]||[str isEqualToString:@"+"])
    {
        return 4;
    }
    else
    {
        return 3;
    }
}
-(NSString *) stringByRemovingFirstCharacter:(NSString *) str
{
    if([str length]>0)
    {
        return [str substringFromIndex:1];
    }
    return @"";

}
//check whether  character is operand, opening bracket, closed bracket  or number
-(CTButtonType)getTypeForString:(NSString *) str
{
    if([self checkRegex:@"^(?:\\+|-|\\/|x)$" forString:str])
    {
        return CTButtonTypeOperand;
    }
    else if([str isEqualToString:@"("])
    {
        return CTButtonTypeOpenBracket;
    }
    else if([str isEqualToString:@")"])
    {
        return CTButtonTypeCloseBracket;
    }
    else if([self isNumber:str])
    {
        return CTButtonTypeNumber;
    }
    return CTButtonTypeInvalid;
}
//get last character in a string or return empty string
-(NSString *) getLastCharacter:(NSString *) str
{
    if([str length]>0)
    {
        return [str substringFromIndex:[str length]-1];
    }
    return @"";
}
//get first character
-(NSString *) getFirstCharacter:(NSString *) str
{
    if([str length]>0)
    {
        return [str substringToIndex:1];
    }
    return @"";
}

//Perform operation
-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr usingOperand:(NSString *) operand
{
    CGFloat a = [self floatValue:aStr];
    CGFloat b = [self floatValue:bStr];
    CGFloat answer = 0;
    if([operand isEqualToString:@"/"])
    {
        answer = a/b;
    }
    else if([operand isEqualToString:@"+"])
    {
        answer = a+b;
    }
    else if([operand isEqualToString:@"-"])
    {
        answer = a-b;
    }
    else if([operand isEqualToString:@"x"])
    {
        answer = a*b;
    }
    return [NSString stringWithFormat:@"%f", answer];
}
//String to float
-(CGFloat) floatValue:(NSString *) str
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:str];
    return [myNumber floatValue];
}

-(BOOL) isNumber:(NSString *) str
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:str];
    return (myNumber!=nil);
}
-(BOOL) checkRegex:(NSString *) regex forString:(NSString *) str
{
    NSPredicate *regText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [regText evaluateWithObject:str];
}

#pragma mark IBActions
/*
    Grab Input
 */
-(IBAction) tappedOnButton:(UIButton *)sender
{
    NSString *text = self.questionLbl.text;
    NSString *lastCharacter = [self getLastCharacter:text];
    NSString *newCharacter = sender.titleLabel.text;
    CTButtonType newCharacterType = [self getTypeForString:newCharacter];
    CTButtonType lastCharacterType = [self getTypeForString:lastCharacter];
    if(newCharacterType!=CTButtonTypeNumber || lastCharacterType!=CTButtonTypeNumber)
    {
        text = [text stringByAppendingString:sender.titleLabel.text];
        [self.questionLbl setText:text];
    }
}

-(IBAction) tappedOnCalculate:(id)sender
{
    NSString *question = self.questionLbl.text;
    NSString * answer = [self solveQuestion:question];
    [self.answerLbl setText:answer];
}

-(IBAction) clear:(id)sender
{
    [self.answerLbl setText:@""];
    [self.questionLbl setText:@""];
}
@end

@implementation NSMutableArray (Stack)
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
