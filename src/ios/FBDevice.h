//
//  FBDevice.h
//
//  Created by Filip Bec on 4/8/14.
//  Copyright (c) 2013 Infinum Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>

@interface FBDevice : CDVPlugin

/*
 Function returns identifierForVendor
 
 @see https://developer.apple.com/library/ios/documentation/uikit/reference/UIDevice_Class/Reference/UIDevice.html
 */
- (void)getDeviceIdentifier:(CDVInvokedUrlCommand *)command;

@end
