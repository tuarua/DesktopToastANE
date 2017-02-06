//
//  Created by User on 30/10/2016.
//  Copyright © 2016 Tua Rua Ltd. All rights reserved.
//
#pragma once
#include "FlashRuntimeExtensions.h"
extern "C" {
    __declspec(dllexport) void TRDTTExtInizer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
    __declspec(dllexport) void TRDTTExtFinizer(void* extData);
}
