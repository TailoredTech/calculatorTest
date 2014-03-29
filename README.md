calulatortest
=============
Basic logical reasoning test for an iOS developer interview candidate. 

Requires the candidate to complete a calculator app to solve BODMAS equations. 

The candidate only needs to edit the CTCalculate class & fill in:

-(NSString *) solveQuestion:(NSString *) question

He/She has the following helper functions
=============

NSMutableArray+Stacks.h
=============
A category on NSMutableArray's that adds the following stack functions:

-(void) push:(id) obj

-(id) pop

-(id) peek

NSString+EquationParser.h
=============
A category on NSStrins's that has the following functions to help pass an equation string :

-(NSString *) firstElement - returns the first element of the equations string (eg. "123+45/3" returns "123". "((3+5)/9)" returns "(")

-(NSString *) stringByRemovingFirstElement - returns a string with the first element of the equations string removed.(eg. "123+45/3" returns "+45/3". "((3+5)/9)" returns "(3+5)/9)")

-(CTElementType) getElementType - returns the elementType for this string can be one of the following:
    1. CTElementTypeInvalid
    2. CTElementTypeOperand
    3. CTElementTypeOpenBracket
    4. CTElementTypeCloseBracket
    5/ CTElementTypeNumber

-(BOOL) precedes:(NSString *)operand -  check if self it precedes the passed operand. Does not check to make sure self and operand are operators.

-(NSString *) calculateForParamA:(NSString *) aStr paramB:(NSString *) bStr - Calculated [aStr] [self] [bStr]

Notes
=============
The UI only supports the 4" iPhones/iPods

Things to add in the future:
1. Validate equation before passing it to solveQuestion.
2. Rebuild storyboard using autolayout.
3. Add default test cases.

This is still a work in progress. Please feel free to contribute & fix bugs.
