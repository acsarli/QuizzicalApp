//
//  NSString+Sorting.m
//  Quizzical
//
//  Created by Adrian Sarli on 5/7/10.
//  Copyright 2010 Adrian Sarli. All rights reserved.
//

#import "NSString+Sorting.h"


@implementation NSString(Sorting)

-(NSComparisonResult) compareAlphaNumerically:(NSString *)string
{
	return [self compare:string options:NSNumericSearch];
}
@end
