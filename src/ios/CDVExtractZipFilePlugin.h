//
//  SSZipArchive.h
//  SSZipArchive
//
//  Created by Sam Soffes on 7/21/10.
//  Copyright (c) Sam Soffes 2010-2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
//#import "libZip.h"

@interface CDVExtractZipFilePlugin : CDVPlugin
{
    int j ;
}
- (BOOL)execute:(CDVInvokedUrlCommand*)command;

@end
