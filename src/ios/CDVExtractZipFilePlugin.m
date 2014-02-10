//
//

#import "CDVExtractZipFilePlugin.h"

#import "SSZipArchive.h"

/*#define IMG @"img"
#define SO @"so"
#define AUTOR @"autor"*/


@implementation CDVExtractZipFilePlugin

- (BOOL)unzip:(CDVInvokedUrlCommand*)command
{
    bool result = true;
    
    @try {
        NSString *fileName = [@"/Users/" stringByAppendingString:[command.arguments objectAtIndex:0]];
        NSLog(@"filename: %@",fileName);
        
        NSString *folder;
        //folder = [NSString stringWithFormat:@"%@/%@/%@/%@",[fileName stringByDeletingLastPathComponent],SO,IMG,AUTOR] ;
        folder =[fileName stringByDeletingLastPathComponent];
        NSLog(@"folder: %@",folder);
        
        [SSZipArchive unzipFileAtPath:fileName toDestination:folder];
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        result = FALSE;
    }
    
    
    

    return result;
}

@end