//
//  Copyright (c) 2015 CharleChang. All rights reserved.
// singleSliceMode controls whether map is generated for full or single slice

#import "roi2dicom.h"
#include <math.h>
#import <OsiriXAPI/DicomStudy.h>
#import <OsiriXAPI/DicomSeries.h>
#import <OsiriXAPI/DicomImage.h>
#import <OsiriXAPI/DCMPix.h>
#import <OsiriXAPI/ROI.h>
#import <OsiriXAPI/Notifications.h>
#import <OsiriXAPI/DICOMExport.h>
#import <OsiriXAPI/browserController.h>
#import <OsiriXAPI/DicomDatabase.h>

#import <OsiriXAPI/DCMObject.h>
#import <OsiriXAPI/DCMAttribute.h>
#import <OsiriXAPI/DCMAttributeTag.h>


@implementation roi2dicom

- (void) initPlugin
{
    newviewid = 0;
    NSLog( @"Init roi2dicom");
}

- (long) filterImage:(NSString*) menuName
{

    NSArray     *displayedViewers = [ViewerController getDisplayed2DViewers];
    ViewerController    *viewerController = [displayedViewers objectAtIndex:0];
    
    [[viewerController  imageView] scaleToFit];
    [viewerController    needsDisplayUpdate];
    

    NSMutableArray  *roiSeriesList = [viewerController roiList];
    
    ViewerController *new2DViewer2 = [self duplicateCurrent2DViewerWindow];
    float wl, ww;
    [[new2DViewer2 imageView] getWLWW :&wl :&ww];
    
    ViewerController *new2DViewer = [self duplicateCurrent2DViewerWindow];
    NSArray        *pixList, *pixListNew;
    DCMPix        *curPix, *curPixNew;
    pixList        = [viewerController pixList];
    pixListNew    = [new2DViewer pixList];
    
    int i, x;
    float        *fImage, *fImageNew;
    int sliceStart  = 0;
    int pixWidth    = [[pixList objectAtIndex:0] pwidth];
    int pixHeight   = [[pixList objectAtIndex:0] pheight];
    int sliceCount  = [pixList count];
    

    
    for( i = sliceStart; i < sliceCount; i++)
        
    {
        
        curPix        = [pixList        objectAtIndex:i];
        curPixNew   = [pixListNew   objectAtIndex:i];
        
        fImage        = [curPix        fImage];
        fImageNew    = [curPixNew    fImage];
        x            = [curPixNew pheight] * [curPixNew pwidth];
    
        while ( x-- > 0 )
        {
            *fImageNew = 0.0;
            fImage++;
            fImageNew++;
        }
        
//        NSMutableArray  *roiImageList = [roiSeriesList objectAtIndex: sliceCount - i - 1];
        NSMutableArray  *roiImageList = [roiSeriesList objectAtIndex: i];
        if ([roiImageList count] > 0){

            for (int roinum = 0; roinum < [roiImageList count]; roinum++){
                ROI *curROI = [roiImageList objectAtIndex: roinum];
                [curPixNew fillROI: curROI :1.0 :0 :0 :NO];
            }
        }
    }
    
    
    
    [[new2DViewer imageView] setWLWW:0.5 :1.0 saveChanges:YES];
    [new2DViewer    needsDisplayUpdate];
    [[new2DViewer2 imageView] setWLWW:wl :ww saveChanges:YES];
    [new2DViewer2    needsDisplayUpdate];
    [viewerController close];
    
    
    
    
    return 0;
}



@end





