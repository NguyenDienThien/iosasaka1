//
//  GNLogManager.m
//  GonativeIO
//
//  Created by bld on 11/29/22.
//  Copyright © 2022 GoNative.io LLC. All rights reserved.
//

#import "GNLogManager.h"

@interface GNLogManager()
@property WKWebView *webview;
@end

@implementation GNLogManager

- (instancetype)initWithWebview:(WKWebView *)webview enabled:(BOOL)enabled {
    self = [super init];
    if (self) {
        self.webview = webview;
        
        if (enabled) {
            [self enableLogging];
        }
    }
    return self;
}

- (void)enableLogging {
    NSString *js = @" "
    " function handle_median_console_log(input, type) { "
    "    var data = input.toString(); "
    "    if (typeof input === 'object') { "
    "       data = JSON.stringify(input, undefined, 4); "
    "    } "
    "    var message = { data: { data, type }, medianCommand: 'median://webconsolelogs/print' }; "
    "    window.webkit?.messageHandlers?.JSBridge?.postMessage(message); "
    " } "
    " var console = { "
    "    log: function(data) { "
    "       handle_median_console_log(data, 'console.log') "
    "    }, "
    "    error: function(data) { "
    "       handle_median_console_log(data, 'console.error') "
    "    }, "
    "    warn: function(data) { "
    "       handle_median_console_log(data, 'console.warn') "
    "    }, "
    "    debug: function(data) { "
    "       handle_median_console_log(data, 'console.debug') "
    "    }, "
    " }; "
    " ";
    
    [self.webview evaluateJavaScript:js completionHandler:nil];
    NSLog(@"Web console logs enabled");
}

- (void)handleUrl:(NSURL *)url query:(NSDictionary *)query {
    if (![url.host isEqualToString:@"webconsolelogs"] || ![url.path isEqualToString:@"/print"]) {
        return;
    }
    
    @try {
        NSLog(@"[%@] %@", query[@"type"], query[@"data"]);
    } @catch(id exception) {
        // Do nothing
    }
}

@end
