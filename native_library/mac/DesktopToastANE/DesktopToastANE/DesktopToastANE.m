/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/

#import <Foundation/Foundation.h>
#import "FreMacros.h"
#import "DesktopToastANE_oc.h"
#import <DesktopToastANE/DesktopToastANE-Swift.h>

SWIFT_DECL(TRDTT) // use unique prefix throughout to prevent clashes with other ANEs

CONTEXT_INIT(TRDTT) {
    SWIFT_INITS(TRDTT)
    
    /**************************************************************************/
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRDTT, init)
        ,MAP_FUNCTION(TRDTT, show)
        ,MAP_FUNCTION(TRDTT, getNamespace)
    };
    /**************************************************************************/
    /**************************************************************************/
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRDTT) {
    //any clean up code here
}
EXTENSION_INIT(TRDTT)
EXTENSION_FIN(TRDTT)
