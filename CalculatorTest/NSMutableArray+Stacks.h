//
//  NSMutableArray+Stacks.h
//  CalculatorTest
//
//  Created by Aakash Kejriwal on 28/03/14.
//  Copyright (c) 2014 Tailored Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Calculator)
-(void) push:(NSString *) obj;
-(NSString *) pop;
-(NSString *) peek;
@end
