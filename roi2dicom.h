//

//
//  Copyright (c) 2015 CharleChang. All rights reserved.
//

#ifndef roi2dicom_h
#define roi2dicom_h

#import <Foundation/Foundation.h>
#import <OsiriXAPI/PluginFilter.h>
#import <OsiriXAPI/browserController.h>
#import <OsiriXAPI/DCMPix.h>
#import <OsiriXAPI/DicomStudy.h>
#import <OsiriXAPI/DicomSeries.h>
#import <OsiriXAPI/DicomImage.h>

#import <OsiriXAPI/AppController.h>
#import <OsiriXAPI/BrowserController.h>
#import <OsiriXAPI/PluginFilter.h>

#import <OsiriXAPI/DCMObject.h>
#import <OsiriXAPI/DCMAttribute.h>
#import <OsiriXAPI/DCMAttributeTag.h>

int newviewid;

@interface roi2dicom : PluginFilter{
    
}

- (void) fillROI:(ROI*) roi :(float) newVal :(float) minValue :(float) maxValue :(BOOL) outside;

@end

#endif

