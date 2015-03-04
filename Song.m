//
//  Song.m
//  IT-CoreData
//
//  Created by Phuong Nguyen on 2/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Song.h"

@implementation Song

- (NSString *) description {
    
    return [NSString stringWithFormat:@"%@ %@ %@" , _stitle, _skey, _slyric];
}

@end
