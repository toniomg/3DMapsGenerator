//
//  Block.h
//  3DMapsGenerator
//
//  Created by Antonio MG on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject {
    
}


@property (nonatomic, retain) NSValue *blockVertices;

- (id)initWithCoordinatesx1:(float)x1 x2:(float)x2 y1:(float)y1 y2:(float)y2 z:(float)z;

@end
