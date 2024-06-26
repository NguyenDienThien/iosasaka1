//
//  LEANRootViewController.h
//  GoNativeIOS
//
//  Created by Weiyin He on 2/7/14.
//  Copyright (c) 2014 GoNative.io LLC. All rights reserved.
//

#import "REFrostedViewController.h"
#import "LEANWebViewController.h"

@interface LEANRootViewController : REFrostedViewController

@property LEANWebViewController *webViewController;

// these are run on the top-most webview
- (void)handleJsNavigationUrl:(NSString *)url;
- (void)loadUrl:(NSURL*)url;
- (void)loadUrlUsingJavascript:(NSURL *)url;
- (void)runJavascript:(NSString*)js;
- (void) runJavascriptWithCallback:(id)callback data:(NSDictionary*)data;

- (BOOL)webviewOnTop;
- (void)setInitialUrl:(NSURL *)url; // for initial launch from push notification
- (void)presentAlert:(UIAlertController*)alert;
@end
