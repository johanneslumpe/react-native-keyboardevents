//
//  RNKeyboardEventsManager.m
//  RNKeyboardEventsManager
//
//  Created by Johannes Lumpe on 12/04/15.
//  Copyright (c) 2015 Johannes Lumpe. All rights reserved.
//

#import "RNKeyboardEventsManager.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

static NSString* RNKeyboardEventsDidShow = @"keyboardDidShow";
static NSString* RNKeyboardEventsDidHide = @"keyboardDidHide";
static NSString* RNKeyboardEventsWillShow = @"keyboardWillShow";
static NSString* RNKeyboardEventsWillHide = @"keyboardWillHide";


@implementation RNKeyboardEventsManager

@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

- (instancetype)init {
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

  }
  
  return self;
}

- (void)keyboardWillHide:(NSNotification*)notification {
  [_bridge.eventDispatcher sendDeviceEventWithName:RNKeyboardEventsWillHide body:nil];
}

- (void)keyboardDidHide:(NSNotification*)notification {
  [_bridge.eventDispatcher sendDeviceEventWithName:RNKeyboardEventsDidHide body:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification {
  [_bridge.eventDispatcher sendDeviceEventWithName:RNKeyboardEventsWillShow body:nil];
}

- (void)keyboardDidShow:(NSNotification*)notification {
  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  //Given size may not account for screen rotation
  int h = MIN(keyboardSize.height,keyboardSize.width);
  int w = MAX(keyboardSize.height,keyboardSize.width);
  
  NSDictionary *body = @{
    @"width": [NSNumber numberWithInt:w],
    @"height": [NSNumber numberWithInt:h],
  };

  [_bridge.eventDispatcher sendDeviceEventWithName:RNKeyboardEventsDidShow body:body];
}

- (NSDictionary *)constantsToExport
{
  return @{
    @"KeyboardDidShow": RNKeyboardEventsDidShow,
    @"KeyboardDidHide": RNKeyboardEventsDidHide,
    @"KeyboardWillShow": RNKeyboardEventsWillShow,
    @"KeyboardWillHide": RNKeyboardEventsWillHide,
  };
}

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
