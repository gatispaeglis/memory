function availableMemory() {
    var memorySize = 0
    for ( var i = 0; i < chunks.count; i++ ) {
        memorySize += chunks.get(i).size
    }
    return memorySize
}

function firstFitAllocation() {
    var found = 0 // false
    for ( var i = 0; i < requests.count; i++ ) {
        found = 0
        for ( var j = 0; j < firstFit.chunkObjects.count; j++ ) {
            if ( firstFit.chunkObjects.itemAt(j).free > requests.get(i).size ) {
                firstFit.chunkObjects.itemAt(j).free -= requests.get(i).size
                found = 1
                break
            }
        }
        if (found == 0) logMessages.append( {"msg": "[FirstFit] No space for request with size: " + requests.get(i).size } )
    }
}

function bestFitAllocation() {
    var delta = -1; var newDelta = 0
    var indexOfBestChunk = -1
    for ( var i = 0; i < requests.count; i++ ) {
        for ( var j = 0; j < bestFit.chunkObjects.count; j++ ) {
            if ( bestFit.chunkObjects.itemAt(j).free > requests.get(i).size) {
                newDelta = bestFit.chunkObjects.itemAt(j).free - requests.get(i).size
                if ( (newDelta < delta) || (delta == -1) ) {
                    delta = newDelta
                    indexOfBestChunk = j
                }
            }
        }
        if (delta != -1) {
            bestFit.chunkObjects.itemAt(indexOfBestChunk).free -= requests.get(i).size
        } else {
            logMessages.append( {"msg": "[BestFit] No space for request with size: " + requests.get(i).size } )
        }
        delta = -1
    }
}

function worstFitAllocation() {
    var delta = -1; var newDelta = 0
    var indexOfWorstChunk = -1
    for ( var i = 0; i < requests.count; i++ ) {
        for ( var j = 0; j < worstFit.chunkObjects.count; j++ ) {
            if ( worstFit.chunkObjects.itemAt(j).free > requests.get(i).size) {
                newDelta = worstFit.chunkObjects.itemAt(j).free - requests.get(i).size
                if ( (newDelta > delta) || (delta == -1) ) {
                    delta = newDelta
                    indexOfWorstChunk = j
                }
            }
        }
        if (delta != -1) {
            worstFit.chunkObjects.itemAt(indexOfWorstChunk).free -= requests.get(i).size
        } else {
            logMessages.append( {"msg": "[WorstFit] No space for request with size: " + requests.get(i).size } )
        }
        delta = -1
    }
}

function nextFitAllocation() {
    var found = 0 // false
    var indexOfLastFit = 0 // index from where to continue next search
    var chunkCount = nextFit.chunkObjects.count;
    var index = -1;
    for ( var i = 0; i < requests.count; i++ ) {
        found = 0
        for ( var j = 0; j < chunkCount; j++ ) {
            index = (j + indexOfLastFit) % chunkCount;
            if ( nextFit.chunkObjects.itemAt(index).free > requests.get(i).size ) {
                nextFit.chunkObjects.itemAt(index).free -= requests.get(i).size
                indexOfLastFit = index + 1
                found = 1 // true
                break
            }
        }
        if (found == 0) {
            logMessages.append( {"msg": "[NextFit] No space for request with size: " + requests.get(i).size } )
        }
    }
}

// updateChunk ORRRRR reject request
function updateChunk( targetChunk ) {
    //console.log("size of request: " + draggableRequest.size)
    //console.log("index in Repeater: " + targetChunk.free )
    if (targetChunk.free > draggableRequest.size) {
        targetChunk.free -= draggableRequest.size
        return 1 // update successful
    } else {
        logMessages.append( { "msg": "Size matters [ Try again or throw it in the garbage ]" } )
        return 0 // chunk to small for request
    }
}
