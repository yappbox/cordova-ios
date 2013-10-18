/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVWebViewPreferences.h"
#import <Cordova/CDVAvailability.h>

@implementation CDVWebViewPreferences

- (id)settingForKey:(NSString*)key
{
    return [self.commandDelegate.settings objectForKey:[key lowercaseString]];
}

- (void)pluginInitialize
{
    NSString* enableViewportScale = [self settingForKey:@"EnableViewportScale"];
    NSNumber* allowInlineMediaPlayback = [self settingForKey:@"AllowInlineMediaPlayback"];
    BOOL mediaPlaybackRequiresUserAction = YES;  // default value

    if ([self settingForKey:@"MediaPlaybackRequiresUserAction"]) {
        mediaPlaybackRequiresUserAction = [(NSNumber*)[self settingForKey:@"MediaPlaybackRequiresUserAction"] boolValue];
    }

    self.webView.scalesPageToFit = [enableViewportScale boolValue];

    /*
     * This is for iOS 4.x, where you can allow inline <video> and <audio>, and also autoplay them
     */
    if ([allowInlineMediaPlayback boolValue] && [self.webView respondsToSelector:@selector(allowsInlineMediaPlayback)]) {
        self.webView.allowsInlineMediaPlayback = YES;
    }
    if ((mediaPlaybackRequiresUserAction == NO) && [self.webView respondsToSelector:@selector(mediaPlaybackRequiresUserAction)]) {
        self.webView.mediaPlaybackRequiresUserAction = NO;
    }

    // By default, overscroll bouncing is allowed.
    // UIWebViewBounce has been renamed to DisallowOverscroll, but both are checked.
    BOOL bounceAllowed = YES;
    NSNumber* disallowOverscroll = [self settingForKey:@"DisallowOverscroll"];
    if (disallowOverscroll == nil) {
        NSNumber* bouncePreference = [self settingForKey:@"UIWebViewBounce"];
        bounceAllowed = (bouncePreference == nil || [bouncePreference boolValue]);
    } else {
        bounceAllowed = ![disallowOverscroll boolValue];
    }

    // prevent webView from bouncing
    // based on the DisallowOverscroll/UIWebViewBounce key in config.xml
    if (!bounceAllowed) {
        if ([self.webView respondsToSelector:@selector(scrollView)]) {
            ((UIScrollView*)[self.webView scrollView]).bounces = NO;
        } else {
            for (id subview in self.webView.subviews) {
                if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
                    ((UIScrollView*)subview).bounces = NO;
                }
            }
        }
    }

    /*
     * iOS 6.0 UIWebView properties
     */
    if (IsAtLeastiOSVersion(@"6.0")) {
        BOOL keyboardDisplayRequiresUserAction = YES; // KeyboardDisplayRequiresUserAction - defaults to YES
        if ([self settingForKey:@"KeyboardDisplayRequiresUserAction"] != nil) {
            if ([self settingForKey:@"KeyboardDisplayRequiresUserAction"]) {
                keyboardDisplayRequiresUserAction = [(NSNumber*)[self settingForKey:@"KeyboardDisplayRequiresUserAction"] boolValue];
            }
        }

        // property check for compiling under iOS < 6
        if ([self.webView respondsToSelector:@selector(setKeyboardDisplayRequiresUserAction:)]) {
            [self.webView setValue:[NSNumber numberWithBool:keyboardDisplayRequiresUserAction] forKey:@"keyboardDisplayRequiresUserAction"];
        }

        BOOL suppressesIncrementalRendering = NO; // SuppressesIncrementalRendering - defaults to NO
        if ([self settingForKey:@"SuppressesIncrementalRendering"] != nil) {
            if ([self settingForKey:@"SuppressesIncrementalRendering"]) {
                suppressesIncrementalRendering = [(NSNumber*)[self settingForKey:@"SuppressesIncrementalRendering"] boolValue];
            }
        }

        // property check for compiling under iOS < 6
        if ([self.webView respondsToSelector:@selector(setSuppressesIncrementalRendering:)]) {
            [self.webView setValue:[NSNumber numberWithBool:suppressesIncrementalRendering] forKey:@"suppressesIncrementalRendering"];
        }
    }

    /*
     * iOS 7.0 UIWebView properties
     */
    if (IsAtLeastiOSVersion(@"7.0")) {
        SEL ios7sel = nil;
        id prefObj = nil;

        CGFloat gapBetweenPages = 0.0; // default
        prefObj = [self settingForKey:@"GapBetweenPages"];
        if (prefObj != nil) {
            gapBetweenPages = [prefObj floatValue];
        }

        // property check for compiling under iOS < 7
        ios7sel = NSSelectorFromString(@"setGapBetweenPages:");
        if ([self.webView respondsToSelector:ios7sel]) {
            [self.webView setValue:[NSNumber numberWithFloat:gapBetweenPages] forKey:@"gapBetweenPages"];
        }

        CGFloat pageLength = 0.0; // default
        prefObj = [self settingForKey:@"PageLength"];
        if (prefObj != nil) {
            pageLength = [[self settingForKey:@"PageLength"] floatValue];
        }

        // property check for compiling under iOS < 7
        ios7sel = NSSelectorFromString(@"setPageLength:");
        if ([self.webView respondsToSelector:ios7sel]) {
            [self.webView setValue:[NSNumber numberWithFloat:pageLength] forKey:@"pageLength"];
        }

        NSInteger paginationBreakingMode = 0; // default - UIWebPaginationBreakingModePage
        prefObj = [self settingForKey:@"PaginationBreakingMode"];
        if (prefObj != nil) {
            NSArray* validValues = @[@"page", @"column"];
            NSString* prefValue = [validValues objectAtIndex:0];

            if ([prefObj isKindOfClass:[NSString class]]) {
                prefValue = prefObj;
            }

            paginationBreakingMode = [validValues indexOfObject:[prefValue lowercaseString]];
            if (paginationBreakingMode == NSNotFound) {
                paginationBreakingMode = 0;
            }
        }

        // property check for compiling under iOS < 7
        ios7sel = NSSelectorFromString(@"setPaginationBreakingMode:");
        if ([self.webView respondsToSelector:ios7sel]) {
            [self.webView setValue:[NSNumber numberWithInteger:paginationBreakingMode] forKey:@"paginationBreakingMode"];
        }

        NSInteger paginationMode = 0; // default - UIWebPaginationModeUnpaginated
        prefObj = [self settingForKey:@"PaginationMode"];
        if (prefObj != nil) {
            NSArray* validValues = @[@"unpaginated", @"lefttoright", @"toptobottom", @"bottomtotop", @"righttoleft"];
            NSString* prefValue = [validValues objectAtIndex:0];

            if ([prefObj isKindOfClass:[NSString class]]) {
                prefValue = prefObj;
            }

            paginationMode = [validValues indexOfObject:[prefValue lowercaseString]];
            if (paginationMode == NSNotFound) {
                paginationMode = 0;
            }
        }

        // property check for compiling under iOS < 7
        ios7sel = NSSelectorFromString(@"setPaginationMode:");
        if ([self.webView respondsToSelector:ios7sel]) {
            [self.webView setValue:[NSNumber numberWithInteger:paginationMode] forKey:@"paginationMode"];
        }
    }
}

// //////////////////////////////////////////////////

- (void)enableViewportScale:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    self.webView.scalesPageToFit = [value boolValue];
}

- (void)mediaPlaybackRequiresUserAction:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    self.webView.mediaPlaybackRequiresUserAction = [value boolValue];
}

- (void)mediaPlaybackAllowsAirPlay:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:YES];
    }

    self.webView.mediaPlaybackAllowsAirPlay = [value boolValue];
}

- (void)allowInlineMediaPlayback:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    self.webView.allowsInlineMediaPlayback = [value boolValue];
}

- (void)keyboardDisplayRequiresUserAction:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:YES];
    }

    // TODO: iOS 6 check
    self.webView.keyboardDisplayRequiresUserAction = [value boolValue];
}

- (void)suppressesIncrementalRendering:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    // TODO: iOS 6 check
    self.webView.suppressesIncrementalRendering = [value boolValue];
}

- (void)disallowOverscroll:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:NO];
    }

    if ([self.webView respondsToSelector:@selector(scrollView)]) {
        ((UIScrollView*)[self.webView scrollView]).bounces = [value boolValue];
    } else {
        for (id subview in self.webView.subviews) {
            if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
                ((UIScrollView*)subview).bounces = [value boolValue];
            }
        }
    }
}

- (void)gapBetweenPages:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithFloat:0.0];
    }

    // TODO: implementation, and iOS 7 check
}

- (void)pageLength:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithFloat:0.0];
    }

    // TODO: implementation, and iOS 7 check
}

- (void)paginationBreakingMode:(CDVInvokedUrlCommand*)command
{
    id value = [command.arguments objectAtIndex:0];

    if (!([value isKindOfClass:[NSString class]])) {
        value = @"page";
    }

    // TODO: implementation, and iOS 7 check
}

- (void)paginationMode:(CDVInvokedUrlCommand*)command;
{
    id value = [command.arguments objectAtIndex:0];
    if (!([value isKindOfClass:[NSString class]])) {
        value = @"unpaginated";
    }

    // TODO: implementation, and iOS 7 check
}

@end
