//
//  FBDevice.m
//
//  Created by Filip Bec on 4/8/14.
//  Copyright (c) 2013 Infinum Ltd. All rights reserved.
//

#import <Cordova/CDV.h>
#import "FBDevice.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation FBDevice

- (void)getDeviceIdentifier:(CDVInvokedUrlCommand *)command
{
    NSDictionary* deviceProperties = [self deviceIdentifier];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceProperties];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSDictionary *)deviceIdentifier
{
    UIDevice* device = [UIDevice currentDevice];
    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *identifier = nil;

    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        identifier = [[device identifierForVendor] UUIDString];
    } else {
    	identifier = [self applicationIdentifier];
    }
    
    [devProps setObject:identifier forKey:@"identifier"];
    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

- (NSString *)applicationIdentifier
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    static NSString* UUID_KEY = @"CDVUUID";

    NSString* app_uuid = [userDefaults stringForKey:UUID_KEY];

    if (app_uuid == nil) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, uuidRef);

        app_uuid = [NSString stringWithString:(__bridge NSString*)uuidString];
        [userDefaults setObject:app_uuid forKey:UUID_KEY];
        [userDefaults synchronize];

        CFRelease(uuidString);
        CFRelease(uuidRef);
    }

    return app_uuid;
}

@end
