#import "ObjectiveResourceSetup.h"
#import "ObjectiveResource.h"
#import "ObjectiveResourceDateFormatter.h"

@implementation ObjectiveResourceSetup


+ (void *)setup {
	//Configure ObjectiveResource
	[ObjectiveResourceConfig setSite:@"http://localhost:3000/"];
	
	// use json
	//[ObjectiveResourceConfig setResponseType:JSONResponse];
	
	// use xml (default)
	//[ObjectiveResourceConfig setResponseType:XmlResponse];
	
	// datetime format (default values)
	//[ObjectiveResourceDateFormatter setDateTimeFormatString:@"yyyy-MM-dd'T'HH:mm:ss'Z'" ];
	//[ObjectiveResourceDateFormatter setDateFormatString:@"yyyy-MM-dd" ];
	//[ObjectiveResourceDateFormatter setDateTimeZoneFormatString:@"yyyy-MM-dd'T'HH:mm:ssz"];
	
	// date serialization (default)
	// options are either Date or DateTime
	//[ObjectiveResourceDateFormatter setSerializeFormat:DateTime];

	//user cred
	//[ObjectiveResourceConfig setUser:@"user"];
  //[ObjectiveResourceConfig setPassword:@"password"];
	
}

@end
