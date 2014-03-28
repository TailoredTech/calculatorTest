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
-(NSString *) firstElement;
-(NSString *) stringByRemovingFirstElement;
-(CTElementType) getElementType;
-(BOOL) precedes:(NSString *)operand;
-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr;
@end
