import QtQuick 1.0

Rectangle {
    id: mainWindow
    width: 800
    height: 360

    property variant chunks: 0;
    property variant requests: [3, 6, 50, 2]

    function freeRamSize() {
        var freeChunks = new Array(20, 60, 80, 20, 100, 160, 20, 70)
        mainWindow.chunks = freeChunks

        var size = 0;
        for (var i = 0; i < freeChunks.length; i++) {
            size += freeChunks[i];
        }
        console.log("size: " + size)
        return size;
    }

    // how to populate a model ?
    Rectangle {
        id: firstFit
        // scale: 2 // zoomIn & zoomOut configuration
        scale: 1.5
        height: 100
        width: freeRamSize()
        anchors.centerIn: mainWindow
        border.color: "black"
        border.width: 1

        Row {
            Repeater {
                id: ffRepeater
                model: chunks
                Chunk {
                    width: chunks[index]
                    size: chunks[index]
                    addr: index // generate "real looking" address, for now this us useless
                }
            }
        }

    } // firstFit

    MouseArea {
        anchors.fill: parent
        onClicked: {

            for (var i = 0; i < ffRepeater.count; i++) {
                console.log("size: " + ffRepeater.itemAt(i).size)
            }

        }
    }
}

//    Rectangle {
//        x: firstFit.x
//        y: firstFit.y
//        height: firstFit.height
//        width: firstFit.width
//        color: "red"
//        opacity: 0.5

//    }

