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
        NSString *folder = [[self applicationDocumentsDirectory] stringByAppendingString:@"/co.geomati.mapaliterari"];
        NSString *fileName = [folder stringByAppendingString:[NSString stringWithFormat:@"/%@",[[command.arguments objectAtIndex:0] lastPathComponent] ]];
        //NSString *fileName = [@"/Users/" stringByAppendingString:[command.arguments objectAtIndex:0]];
        NSLog(@"filename: %@",fileName);
        
        
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
- (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end