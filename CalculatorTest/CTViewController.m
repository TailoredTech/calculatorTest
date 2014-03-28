//
//  CTViewController.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 27/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "CTViewController.h"

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
//get self minus the first character
-(NSString *) stringByRemovingFirstCharacter
{
    if([self length]>0)
    {
        return  [self substringFromIndex:1];
    }
    return @"";
}
//get first character
-(NSString *) firstCharacter
{
    if([self length]>0)
    {
        return [self substringToIndex:1];
    }
    return @"";
}

//check whether  character is operand, opening bracket, closed bracket  or number
-(CTStringType)getStringType
{
    if([self checkRegex:@"^(?:\\+|-|\\/|x)$"])
    {
        return CTStringTypeOperand;
    }
    else if([self isEqualToString:@"("])
    {
        return CTStringTypeOpenBracket;
    }
    else if([self isEqualToString:@")"])
    {
        return CTStringTypeCloseBracket;
    }
    else if([self isNumber])
    {
        return CTStringTypeNumber;
    }
    return CTStringTypeInvalid;
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

@interface CTViewController ()

@end

@implementation CTViewController

-(NSString *) solveQuestion:(NSString *) question
{
    return @"Invalid Question";
}

#pragma mark Utility Function
//Returns whether operand A has a higher precedence than B
//For example if a is "x" and b is "+" it return YES
-(BOOL) operandA:(NSString *) a precedesOperandB:(NSString *)b
{
    return ([self scoreForOperand:a]>=[self scoreForOperand:b]);
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
#pragma mark Ignore

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
/*
    Grab Input
 */
-(IBAction) tappedOnButton:(UIButton *)sender
{
    NSString *text = self.questionLbl.text;
    text = [text stringByAppendingString:sender.titleLabel.text];
    [self.questionLbl setText:text];
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

@end