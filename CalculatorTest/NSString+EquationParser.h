//
//  NSString+EquationParser.h
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    CTElementTypeInvalid = 0,
    CTElementTypeOperand = 1 << 0,
    CTElementTypeOpenBracket = 1 << 1,
    CTElementTypeCloseBracket = 1 << 2,
    CTElementTypeNumber = 1 << 3
}
CTElementType;


@interface NSString (PublicParser)
/*
    get the first element in the equation can be either a operand, number or bracket
*/
-(NSString *) firstElement;
/*
 get returns a string with the first element removed.
*/
-(NSString *) stringByRemovingFirstElement;
/*
 gets the type of element this string is
*/
-(CTElementType) getElementType;
/*
 Assuming self is an operand check if it precedes the passed operand
*/
-(BOOL) precedes:(NSString *)operand;
/*
 Assuming self is an operand calculates [aStr][operand][bStr]
 */

-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr;
@end
