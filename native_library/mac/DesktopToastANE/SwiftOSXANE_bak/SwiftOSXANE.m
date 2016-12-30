//
// Created by User on 04/12/2016.
// Copyright (c) 2016 Tua Rua Ltd. All rights reserved.
//
#import <Foundation/Foundation.h>


#include "SwiftOSXANE_oc.h"
#import "SwiftOSXANE-Swift.h"
#include <Adobe AIR/Adobe AIR.h>

SwiftOSXANE *swft;

#define FRE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

// convert argv into a pointer array which can be passed to Swift
NSPointerArray * getFREargs(uint32_t argc, FREObject argv[]) {
    NSPointerArray * pa = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsOpaqueMemory];
    for (int i = 0; i < argc; ++i) {
        FREObject freObject;
        freObject = argv[i];
        [pa addPointer:freObject];
    }
    return pa;
}


FRE_FUNCTION (getAge) {
    return [swft getAgeWithArgv:getFREargs(argc, argv)];
}

FRE_FUNCTION(getPrice) {
    return [swft getPriceWithArgv:getFREargs(argc, argv)];
}

FRE_FUNCTION (getIsSwiftCool) {
    return [swft getIsSwiftCoolWithArgv:getFREargs(argc, argv)];
}


FRE_FUNCTION (getHelloWorld) {
    return [swft getHelloWorldWithArgv:getFREargs(argc, argv)];
}

void contextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    static FRENamedFunction extensionFunctions[] = {
        {(const uint8_t *) "getHelloWorld", NULL, &getHelloWorld},
        {(const uint8_t *) "getAge", NULL, &getAge},
        {(const uint8_t *) "getPrice", NULL, &getPrice},
        {(const uint8_t *) "getIsSwiftCool", NULL, &getIsSwiftCool}
    };

    *numFunctionsToSet = sizeof(extensionFunctions) / sizeof(FRENamedFunction);
    *functionsToSet = extensionFunctions;

    swft = [[SwiftOSXANE alloc] init];
    [swft setFREContextWithCtx:ctx];

}


void contextFinalizer(FREContext ctx) {
    return;
}

void TRSOAExtInizer(void **extData, FREContextInitializer *ctxInitializer, FREContextFinalizer *ctxFinalizer) {
    *ctxInitializer = &contextInitializer;
    *ctxFinalizer = &contextFinalizer;
}

void TRSOAExtFinizer(void *extData) {
    FREContext nullCTX;
    nullCTX = 0;
    contextFinalizer(nullCTX);
    return;
}
