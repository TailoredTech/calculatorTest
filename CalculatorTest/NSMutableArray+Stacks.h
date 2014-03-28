//
//  NSMutableArray+Stacks.h
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Calculator)
/*
 Push object onto a stack
*/
-(void) push:(id) obj;
/*
 Pop object from stack & return
*/
-(id) pop;
/*
 Get object at the top of the stack
*/
-(id) peek;
@end
