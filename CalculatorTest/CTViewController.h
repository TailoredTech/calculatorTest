//
//  CTViewController.h
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 27/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *questionLbl;
@property (nonatomic, weak) IBOutlet UILabel *answerLbl;

-(IBAction) tappedOnButton:(UIButton *)sender;
-(IBAction) tappedOnCalculate:(id)sender;
-(IBAction) clear:(id)sender;
@end

