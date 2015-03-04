//
//  SongSvcSqlite.m
//  IT-CoreData
//
//  Created by Phuong Nguyen on 3/1/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SongSvcSqlite.h"

#import "sqlite3.h"

@implementation SongSvcSQLite

NSString *databasePath = nil;
sqlite3 *database = nil;

-(id)init {
    if ((self = [super init])) {
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:@"Song.sqlite3"];
        
        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
            NSLog(@"database is open");
            NSLog(@"database file path: %@", databasePath);
            
            NSString *createSql = @"create table if not exists song (id integer primary key autoincrement, stitle varchar(60), skey varchar(10), slyric text)";
            
            char *errMsg;
            if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table %s", errMsg);
            }
            
        } else {
            NSLog(@"*** Failed to open database!");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
    }
    return self;
}


- (Song *) createSong: (Song *) song {
    sqlite3_stmt *statement;
    NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO Song (stitle, skey, slyric) VALUES (\"%@\",\"%@\",\"%@\")", song.stitle, song.skey, song.slyric];
    if (sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            song.sid = (int)sqlite3_last_insert_rowid(database);
            NSLog(@"*** Song added");
        } else {
            NSLog(@"*** Song NOT added");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
        
    }
    return song;
}

- (NSMutableArray *) retrieveAllSongs {
    NSMutableArray *songs = [NSMutableArray array];
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM Song ORDER BY stitle"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        NSLog(@"*** Songs retrieved");
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            char *titleChars = (char *)sqlite3_column_text(statement, 1);
            char *keyChars = (char *)sqlite3_column_text(statement, 2);
            char *lyricChars = (char *)sqlite3_column_text(statement, 3);
            
            Song *song = [[Song alloc] init];
            song.sid = id;
            song.stitle = [[NSString alloc] initWithUTF8String:titleChars];
            song.skey = [[NSString alloc] initWithUTF8String:keyChars];
            song.slyric = [[NSString alloc] initWithUTF8String:lyricChars];
            [songs addObject:song];
        }
        sqlite3_finalize(statement);
    } else {
        NSLog(@"*** Songs NOT retrieved");
        NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    return songs;
}

- (Song *) updateSong: (Song *) song {
    NSString *updateSQL = [NSString stringWithFormat: @"UPDATE Song SET stitle=\"%@\", skey=\"%@\", slyric=\"%@\" WHERE sid = %i", song.stitle, song.skey, song.slyric, song.sid];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** Song updated");
        } else {
            NSLog(@"*** Song NOT updated");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }
    return song;
}

- (Song *) deleteSong: (Song *) song {
    NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM Song WHERE sid = %i", song.sid];  /*sid = %i*/
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"*** Song deleted");
        } else {
            NSLog(@"*** Song NOT deleted");
            NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
    }
    return song;
}

-(void)dealloc {
    sqlite3_close(database);
}


@end