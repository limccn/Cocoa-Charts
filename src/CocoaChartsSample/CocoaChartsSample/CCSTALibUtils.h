//
//  TaLibToos.h
//  okasanonlinetrade
//
//  Created by lengyc on 2013/12/09.
//  Copyright (c) 2013年 ohs. All rights reserved.
//

#import <Foundation/Foundation.h>

void NSArrayToCArray(NSArray *array, double outCArray[]);

NSArray *CArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement);

NSArray *CArrayToNSArrayWithParameter(const double inCArray[], int length, int outBegIdx, int outNBElement, double parmeter);

void freeAndSetNULL(void *ptr);


