#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AppmetricaSdkPlugin.h"

FOUNDATION_EXPORT double appmetrica_sdkVersionNumber;
FOUNDATION_EXPORT const unsigned char appmetrica_sdkVersionString[];

