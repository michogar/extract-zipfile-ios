//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface CDVExtractZipFilePlugin : CDVPlugin


- (BOOL)unzip:(CDVInvokedUrlCommand*)command;

@end
