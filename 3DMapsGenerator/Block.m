//
//  Block.m
//  3DMapsGenerator
//
//  Created by Antonio MG on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Block.h"
#import "Constants.h"

@implementation Block

@synthesize blockVertices = _blockVertices;


-(void)dealloc{
    
    [_blockVertices release];
    [super dealloc];
}

- (id)initWithCoordinatesx1:(float)x1 x2:(float)x2 y1:(float)y1 y2:(float)y2 z:(float)z {
    if (self = [super init]) {
        
        //Create a new block
        Vertex Vertices[] = {
            // Front
            {{x1, y2, 0.01}, BLOCK_COLOR},
            {{x1, y1, 0.01}, BLOCK_COLOR},
            {{x2, y1, 0.01}, BLOCK_COLOR},
            {{x2, y2, 0.01}, BLOCK_COLOR},
            // Back
            {{x1, y1, z}, BLOCK_COLOR},
            {{x2, y2, z}, BLOCK_COLOR},
            {{x1, y2, z}, BLOCK_COLOR},
            {{x2, y1, z}, BLOCK_COLOR},
            // Left
            {{x2, y2, 0.01}, BLOCK_COLOR}, 
            {{x2, y1, 0.01}, BLOCK_COLOR},
            {{x2, y1, z}, BLOCK_COLOR},
            {{x2, y2, z}, BLOCK_COLOR},
            // Right
            {{x1, y2, z}, BLOCK_COLOR},
            {{x1, y1, z}, BLOCK_COLOR},
            {{x1, y1, 0.01}, BLOCK_COLOR},
            {{x1, y2, 0.01}, BLOCK_COLOR},
            // Top
            {{x1, y1, 0.01}, BLOCK_COLOR},
            {{x1, y1, z}, BLOCK_COLOR},
            {{x2, y1, z}, BLOCK_COLOR},
            {{x2, y1, 0.01}, BLOCK_COLOR},
            // Bottom
            {{x1, y2, z}, BLOCK_COLOR},
            {{x1, y2, 0.01}, BLOCK_COLOR},
            {{x2, y2, 0.01}, BLOCK_COLOR}, 
            {{x2, y2, z}, BLOCK_COLOR}
        };
        
        //Save the data in the NSValue object
        self.blockVertices = [NSValue value:&Vertices withObjCType:@encode(Vertex[VERTICES_NUMBER])];
//        


    }
    return self;
}

@end
