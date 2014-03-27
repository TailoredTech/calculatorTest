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
        NSString *nextChar = [question firstCharacter];// Remove first character from string
        question = [question stringByRemovingFirstCharacter];
        CTButtonType charType = [nextChar getButtonType];
        if(charType==CTButtonTypeNumber)//If number add it to numbers stack
        {
            [numbersStack push:nextChar];
        }
        else if(charType==CTButtonTypeOpenBracket)//If open bracket add it to the operand stack
        {
            [operandStack push:nextChar];
        }
        else if(charType==CTButtonTypeCloseBracket)//If close bracket solve equation till last opened bracket
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
            if(topOperand != nil && [self operandA:topOperand precedesOperandB:nextChar])//if the previous operand has a higher precedence solve a single calculation
            {
                if(![self solveSingleOperationNumberStack:numbersStack operandStack:operandStack])
                {
                    return @"Invalid String";
                }
            }
            [operandStack push:nextChar];//add the new operand into the stack
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
    while([operandStack peek]!=nil && [[operandStack peek] getButtonType] != CTButtonTypeOpenBracket)
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
    CTButtonType topType = [topOperand getButtonType];
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


//Perform operation
-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr usingOperand:(NSString *) operand
{
    CGFloat a = [aStr floatValue];
    CGFloat b = [bStr floatValue];
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

#pragma mark IBActions
/*
    Grab Input
 */
-(IBAction) tappedOnButton:(UIButton *)sender
{
    NSString *text = self.questionLbl.text;
    NSString *lastCharacter = [text lastCharacter];
    NSString *newCharacter = sender.titleLabel.text;
    CTButtonType newCharacterType = [newCharacter getButtonType];
    CTButtonType lastCharacterType = [lastCharacter getButtonType];
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

@implementation NSString (Calculator)

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

//check whether  character is operand, opening bracket, closed bracket  or number
-(CTButtonType)getButtonType
{
    if([self checkRegex:@"^(?:\\+|-|\\/|x)$"])
    {
        return CTButtonTypeOperand;
    }
    else if([self isEqualToString:@"("])
    {
        return CTButtonTypeOpenBracket;
    }
    else if([self isEqualToString:@")"])
    {
        return CTButtonTypeCloseBracket;
    }
    else if([self isNumber])
    {
        return CTButtonTypeNumber;
    }
    return CTButtonTypeInvalid;
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
//get first character
-(NSString *) stringByRemovingFirstCharacter
{
    if([self length]>0)
    {
        return  [self substringFromIndex:1];
    }
    return @"";
}
-(NSString *) firstCharacter
{
    if([self length]>0)
    {
        return [self substringToIndex:1];
    }
    return @"";
}
@end
