#import "CDVExtractZipFilePlugin.h"

#import "SSZipArchive.h"

/*#define IMG @"img"
#define SO @"so"
#define AUTOR @"autor"*/


@implementation CDVExtractZipFilePlugin

- (void)unzip:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult*  pluginResult;
    
    @try {
        NSString *fileName = [@"/Users/" stringByAppendingString:[command.arguments objectAtIndex:0]];
        NSLog(@"filename: %@",fileName);
        
        NSString *folder;
        //folder = [NSString stringWithFormat:@"%@/%@/%@/%@",[fileName stringByDeletingLastPathComponent],SO,IMG,AUTOR] ;

        folder = [NSString stringWithFormat:@"%@/%@", [fileName stringByDeletingLastPathComponent], [[fileName lastPathComponent] stringByDeletingPathExtension]];
        NSLog(@"folder: %@",folder);
        
        [SSZipArchive unzipFileAtPath:fileName toDestination:folder];
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:folder];
    
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION messageAsString:exception.description];
    }
   
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

@end