import QtQuick 2.0

Rectangle {

    id: ram
    height: 200;
    border.color: "black";
    border.width: 2
    color: "lightgreen"

    property alias freeChunkModel: ramRepeater.model
    property alias chunkObjects: ramRepeater

    Row {
        Repeater {
            id: ramRepeater
            DropArea {

                id: chunksDropArea; keys: "human"
                height: ram.height; width: freeChunkModel.get(index).size
                property alias addr: targetChunk.addr
                property alias free: targetChunk.free

                Chunk {
                    id: targetChunk
                    height: ram.height
                    size: chunksDropArea.width
                    addr: index
                }

                states: [
                    State {
                        when: chunksDropArea.containsDrag
                        PropertyChanges {
                            target: targetChunk
                            color: "grey"
                        }
                    }
                ]

                onDropped: {

                }
            }
        }
    }
}
