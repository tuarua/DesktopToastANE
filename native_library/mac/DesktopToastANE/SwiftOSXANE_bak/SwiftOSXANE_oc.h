//
// Created by User on 04/12/2016.
// Copyright (c) 2016 Tua Rua Ltd. All rights reserved.
//

#ifndef SWIFTOSXANE_SWIFTOSXANE_H
#define SWIFTOSXANE_SWIFTOSXANE_H


#import <Cocoa/Cocoa.h>

#include <Adobe AIR/Adobe AIR.h>

#define EXPORT __attribute__((visibility("default")))
EXPORT
void TRSOAExtInizer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);

EXPORT
void TRSOAExtFinizer(void* extData);


#endif //SWIFTOSXANE_SWIFTOSXANE_H
