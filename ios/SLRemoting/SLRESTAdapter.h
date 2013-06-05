//
//  SLRESTAdapter.h
//  SLRemoting
//
//  Created by Michael Schoonmaker on 6/3/13.
//  Copyright (c) 2013 StrongLoop. All rights reserved.
//

#import "SLRemotingUtils.h"
#import "SLAdapter.h"

extern NSString *SLRESTAdapterDefaultVerb;

@interface SLRESTAdapter : SLAdapter
SINGLETON_INTERFACE(SLRESTAdapter, defaultAdapter);

@end

