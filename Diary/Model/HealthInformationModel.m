//
//  HealthInformationModel.m
//  Diary
//
//  Created by 김승갑 on 2016. 7. 6..
//  Copyright © 2016년 mju12345. All rights reserved.
//

#import "HealthInformationModel.h"
#import "DBConnector.h"

@implementation HealthInformationModel
@synthesize healthInfo;

-(id) init {
    self = [super init];
    if(self) {
        db = [[DBConnector getInstance] getDB];
        healthInfo = [[HealthInformation alloc] init];
    }
    return self;
}

-(void) create {
    char *err;
    
    if(_createQuery == nil) {
        _createQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'Health_Information' (hi_id INTEGER PRIMARY KEY AUTOINCREMENT, hi_comment TEXT)"];
    }
    if(sqlite3_exec(db, [_createQuery UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Tabled Failed to Creath.");
    }
}

-(NSMutableArray *) select :(NSString *)where {
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT * FROM Health_Information";
    if(where != nil) {
        query = [query stringByAppendingString:@" WHERE "];
        query = [query stringByAppendingString:where];
    }
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, nil) == SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            HealthInformation *hi = [[HealthInformation alloc] init];
            
            hi.hi_id = [NSNumber numberWithUnsignedInteger:(const unsigned int)sqlite3_column_int(stmt, 0)];
            hi.hi_comment = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];

            [list addObject:hi];
        }
        sqlite3_finalize(stmt);
    }
    return list;
}

-(void) insertData :(HealthInformation *)hi {
    char *err;
    
    //[self deleteHealthInformation];
    
    NSString *query = [NSString stringWithFormat:@"INSERT INTO Health_Information (hi_comment) VALUES ('%@')", hi.hi_comment];
    if(sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"INSERT HealthInfo Failed!");
    }
    else {
        NSLog(@"INSERT HealthInfo Success!");
    }
}

-(void) delete :(NSString *)where {
    char *err;
    
    NSString *query = @"DELETE FROM Health_Information";
    if(where != nil) {
        query = [query stringByAppendingString:@" WHERE "];
        query = [query stringByAppendingString:where];
    }
    if(sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"DELETE HealthInfo Failed!");
    }
    else {
        NSLog(@"DELETE Health Success!");
    }
}

-(void) drop {
    char *err;
    
    NSString *query = @"DROP TABLE IF EXISTS 'Health_Information'";
    if(sqlite3_exec(db, [query UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"DROP HealthInfo Failed!");
    }
    else {
        NSLog(@"DROP Health Success!");
    }
}

-(HealthInformation *) getSampleData {
    HealthInformation *hi = [[HealthInformation alloc] init];
    hi.hi_comment = @"그냥 좋음";
    return hi;
}

@end
