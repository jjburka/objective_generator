#import "ObjectiveResourceSetup.h"
#import "ObjectiveResource.h"

@implementation ObjectiveResourceSetup


+ (NSString *)setup {
	//Configure ObjectiveResource
	[ObjectiveResourceConfig setSite:@"http://localhost:3000/"];
	
	// use json
	//[ObjectiveResourceConfig setResponseType:JSONResponse];
	
	// use xml (default)
	//[ObjectiveResourceConfig setResponseType:XmlResponse];
	
	// datetime format (default values)
	//[ ObjectiveResourceDateFormatter setDateTimeFormatString:@"EEE, dd MMM yyyy HH:mm:ss ZZ" ];
	//[ ObjectiveResourceDateFormatter setDateFormatString:@"EEE, dd MMM yyyy" ];
	
	//user cred
	//[ObjectiveResourceConfig setUser:@"user"];
  //[ObjectiveResourceConfig setUser:@"password"];
	
}

@end
