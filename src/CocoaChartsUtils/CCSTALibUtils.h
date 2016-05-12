//
//  CCSTALibUtils.h
//  CocoaChartsUtils
//
//  Created by lengyc on 12/27/13.
//
//  Copyright (C) 2013 ShangHai Okasan-Huada computer system CO.,LTD. All Rights Reserved.
//  See LICENSE.txt for this file’s licensing information
//

#import <Foundation/Foundation.h>

void NSArrayToCArray(NSArray *array, double outCArray[]);

NSArray *CArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement);

NSArray *CArrayToNSArrayWithParameter(const double inCArray[], int length, int outBegIdx, int outNBElement, double parmeter);

void freeAndSetNULL(void *ptr);


