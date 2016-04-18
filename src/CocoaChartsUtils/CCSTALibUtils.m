//
//  CCSTALibUtils.m
//  CocoaChartsUtils
//
//  Created by lengyc on 12/27/13.
//
//  Copyright (C) 2013 ShangHai Okasan-Huada computer system CO.,LTD. All Rights Reserved.
//  See LICENSE.txt for this file’s licensing information
//

#import "CCSTALibUtils.h"

void NSArrayToCArray(NSArray *array, double outCArray[]) {
    if (NULL == outCArray) {
        return;
    }

    NSInteger index = 0;
    for (NSString *str in array) {
        outCArray[index] = [str doubleValue];
        index++;
    }
}

NSArray *CArrayToNSArray(const double inCArray[], int length, int outBegIdx, int outNBElement) {
    if (NULL == inCArray) {
        return nil;
    }

    NSMutableArray *outNSArray = [[NSMutableArray alloc] initWithCapacity:length];

    for (NSInteger index = 0; index < length; index++) {

        if (index >= outBegIdx && index < outBegIdx + outNBElement) {
            [outNSArray addObject:[NSString stringWithFormat:@"%f", inCArray[index - outBegIdx]]];
        } else {
            [outNSArray addObject:[NSString stringWithFormat:@"%f", 0.0f]];
        }

    }

    return outNSArray;
}

NSArray *CArrayToNSArrayWithParameter(const double inCArray[], int length, int outBegIdx, int outNBElement, double parmeter) {
    if (NULL == inCArray) {
        return nil;
    }

    NSMutableArray *outNSArray = [[NSMutableArray alloc] initWithCapacity:length];

    for (NSInteger index = 0; index < length; index++) {

        if (index >= outBegIdx && index < outBegIdx + outNBElement) {
            [outNSArray addObject:[NSString stringWithFormat:@"%f", inCArray[index - outBegIdx]]];
        } else {
            [outNSArray addObject:[NSString stringWithFormat:@"%f", parmeter]];
        }

    }

    return outNSArray;
}

void freeAndSetNULL(void *ptr) {
    free(ptr);
    ptr = NULL;
}
