//
//  TaLibToos.m
//  CocoaChartsSample
//
//  Created by limc on 2013/12/09.
//  Copyright 2013 limc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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

    NSMutableArray *outNSArray = [[[NSMutableArray alloc] initWithCapacity:length] autorelease];

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

    NSMutableArray *outNSArray = [[[NSMutableArray alloc] initWithCapacity:length] autorelease];

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
