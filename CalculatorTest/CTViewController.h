//
//  CTViewController.h
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 27/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    CTStringTypeInvalid = 0,
    CTStringTypeOperand = 1 << 0,
    CTStringTypeOpenBracket = 1 << 1,
    CTStringTypeCloseBracket = 1 << 2,
    CTStringTypeNumber = 1 << 3
}
CTStringType;

@interface CTViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *questionLbl;
@property (nonatomic, weak) IBOutlet UILabel *answerLbl;

-(IBAction) tappedOnButton:(UIButton *)sender;
-(IBAction) tappedOnCalculate:(id)sender;
-(IBAction) clear:(id)sender;
@end

@interface NSMutableArray (Calculator)
-(void) push:(NSString *) obj;
-(NSString *) pop;
-(NSString *) peek;
@end

@interface NSString (Calculator)
-(NSString *) firstCharacter;
-(NSString *) lastCharacter;
-(NSString *) stringByRemovingFirstCharacter;
-(CTStringType) getStringType;
-(CGFloat) floatValue;
-(BOOL) isNumber;
-(BOOL) checkRegex:(NSString *) regex;
@end
