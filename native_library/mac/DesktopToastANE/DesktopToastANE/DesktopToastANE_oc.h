//
// Created by User on 04/12/2016.
// Copyright (c) 2016 Tua Rua Ltd. All rights reserved.
//

#ifndef DESKTOPTOASTANE_DESKTOPTOASTANE_H
#define DESKTOPTOASTANE_DESKTOPTOASTANE_H


#import <Cocoa/Cocoa.h>
#include <Adobe AIR/Adobe AIR.h>
#define EXPORT __attribute__((visibility("default")))
EXPORT
void TRDTTExtInizer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);

EXPORT
void TRDTTExtFinizer(void* extData);


#endif //DESKTOPTOASTANE_DESKTOPTOASTANE_H
