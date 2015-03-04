//
//  Song.h
//  IT-CoreData
//
//  Created by Phuong Nguyen on 2/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (strong, nonatomic) IBOutlet NSString *stitle;
@property (strong, nonatomic) IBOutlet NSString *skey;
@property (strong, nonatomic) IBOutlet NSString *slyric;


@property (nonatomic) int sid;




@end
