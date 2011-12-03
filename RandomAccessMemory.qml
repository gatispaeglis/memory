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
            Chunk {
                height: ram.height
                size: freeChunkModel.get(index).size
                addr: index
            }
        }
    }

    // implement method that prints current state of chunks
}
