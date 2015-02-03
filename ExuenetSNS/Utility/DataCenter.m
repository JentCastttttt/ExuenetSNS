//
//  DataCenter.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "DataCenter.h"

static DataCenter *m_DataCenter = nil;
@implementation DataCenter
@synthesize userInfo;

+(DataCenter*)shareInstance {
    @synchronized(self)
	{
		if (m_DataCenter == nil)
		{
			m_DataCenter = [[DataCenter alloc] init];
		}
	}
	return m_DataCenter;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if(userInfo == nil)
        {
            userInfo = [[UserModel alloc] init];
        }

//        [Utils copyPlistToDst:@"Config"];
//        NSDictionary *tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils getDstPlistPath:@"Config"]];
//        self.configDictionary = tmpdic;
//        [tmpdic release];
        
//        tmpdic = [[NSDictionary alloc] initWithContentsOfFile:[Utils readFileToDictionaryFromPath:[Utils documentsPath:@"errorCode"]]];
//        self.errorDictionary = tmpdic;
//        [tmpdic release];
        
    }
    return self;
}


- (void)dealloc {
    [userInfo release];
    [m_DataCenter release];
    [super dealloc];
}

@end
