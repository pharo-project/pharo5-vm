//
//  sqShowKeyboard.c
//  DrGeo
//
//  Created by Esteban Lorenzano on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include <stdio.h>

#import "SqueakNoOGLIPhoneAppDelegate.h"
SqueakNoOGLIPhoneAppDelegate *gDelegateApp;

void sqShowKeyboard(int show) {
#warning TODO I need to check that I'm actually in a window that can take the focus (if I have a webview on top, I can't take focus)
    if (show) {
        [gDelegateApp.mainView becomeFirstResponder];
    } else {
        [gDelegateApp.mainView resignFirstResponder];
    }
}