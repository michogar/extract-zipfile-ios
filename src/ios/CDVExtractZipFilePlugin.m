//
//  SSZipArchive.h
//  SSZipArchive
//
//  Created by Sam Soffes on 7/21/10.
//  Copyright (c) Sam Soffes 2010-2011. All rights reserved.
//

#import "CDVExtractZipFilePlugin.h"

#define IMG @"img"
#define SO @"so"
#define AUTOR @"autor"

@implementation CDVExtractZipFilePlugin

- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
   if ([command.className isEqualToString:@"unzip"])
    {

        NSString *fileName = [command.arguments objectAtIndex:0];
        
        NSLog(@"filename: %@",fileName);
    }
    else if ([command.methodName isEqualToString:@"unzip"])
    {
         NSString *fileName = [command.arguments objectAtIndex:0];
        
        NSLog(@"filename: %@",fileName);
    }
    

    return FALSE;
}

@end
