//
//  CTViewController.m
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 27/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import "CTViewController.h"
#import "CTCalculate.h"
@interface CTViewController ()
{
    CTCalculate *_calculator;
}
@end

@implementation CTViewController

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
    NSString * answer = [_calculator solveQuestion:question];
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
    _calculator = [[CTCalculate alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end