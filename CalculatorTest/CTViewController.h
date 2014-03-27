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
    CTButtonTypeInvalid = 0,
    CTButtonTypeOperand = 1 << 0,
    CTButtonTypeOpenBracket = 1 << 1,
    CTButtonTypeCloseBracket = 1 << 2,
    CTButtonTypeNumber = 1 << 3
}
CTButtonType;

@interface CTViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *questionLbl;
@property (nonatomic, weak) IBOutlet UILabel *answerLbl;

-(IBAction) tappedOnButton:(UIButton *)sender;
-(IBAction) tappedOnCalculate:(id)sender;
-(IBAction) clear:(id)sender;
-(CTButtonType)getTypeForString:(NSString *) str;
@end

@interface NSMutableArray (Stack)
-(void) push:(NSString *) obj;
-(NSString *) pop;
-(NSString *) peek;
@end
