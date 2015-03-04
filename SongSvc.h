//
//  SongSvc.h
//  IT-CoreData
//
//  Created by Phuong Nguyen on 2/21/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Song.h"
#import "sqlite3.h"



@protocol SongSvc <NSObject>


- (Song *) createSong: (Song *) song;

- (NSMutableArray *) retrieveAllSongs;

- (Song *) updateSong: (Song *) song;

- (Song *) deleteSong: (Song *) song;


@end
