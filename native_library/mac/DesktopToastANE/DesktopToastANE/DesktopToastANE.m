//
// Created by User on 04/12/2016.
// Copyright (c) 2016 Tua Rua Ltd. All rights reserved.
//
#import <Foundation/Foundation.h>


#include "DesktopToastANE_oc.h"
#import "DesktopToastANE-Swift.h"
#include <Adobe AIR/Adobe AIR.h>

DesktopToastANE *swft;

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

FRE_FUNCTION (init) {
    [swft initNotificationWithArgv:getFREargs(argc, argv)];
    return NULL;
}

FRE_FUNCTION (show) {
    [swft showWithArgv:getFREargs(argc, argv)];
    return NULL;
}

FRE_FUNCTION (getNamespace) {
    return [swft getNamespaceWithArgv:getFREargs(argc, argv)];
}

void contextInitializer(void *extData, const uint8_t *ctxType, FREContext ctx, uint32_t *numFunctionsToSet, const FRENamedFunction **functionsToSet) {
    static FRENamedFunction extensionFunctions[] = {
        {(const uint8_t *) "init", NULL, &init},
        {(const uint8_t *) "show", NULL, &show},
        {(const uint8_t *) "getNamespace", NULL, &getNamespace}
    };

    *numFunctionsToSet = sizeof(extensionFunctions) / sizeof(FRENamedFunction);
    *functionsToSet = extensionFunctions;

    swft = [[DesktopToastANE alloc] init];
    [swft setFREContextWithCtx:ctx];

}


void contextFinalizer(FREContext ctx) {
    return;
}

void TRDTTExtInizer(void **extData, FREContextInitializer *ctxInitializer, FREContextFinalizer *ctxFinalizer) {
    *ctxInitializer = &contextInitializer;
    *ctxFinalizer = &contextFinalizer;
}

void TRDTTExtFinizer(void *extData) {
    FREContext nullCTX;
    nullCTX = 0;
    contextFinalizer(nullCTX);
    return;
}
