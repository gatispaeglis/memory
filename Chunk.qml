import QtQuick 2.0

Rectangle {
    id: me
    width: size
    border.width: 1; border.color: "black"
    color: "lightgreen"
    property int size: 0
    property int free: 0
    property int oldFree: 0
    property alias addr: addrLabel.text
    property int busyX: 0

    ListModel { id: busyListParams } // busyListModel is a better name

    onFreeChanged: {
        if (oldFree != 0) {
            busyListParams.append( { "size": oldFree - free, "adjustedX": busyX } ) // find how big was the request
            busyX += oldFree - free
            oldFree = free
        }
    }

    Repeater {
        id: busyPieceRepeater
        model: busyListParams
        BusyPiece {
            x: adjustedX
            width: size
        }
    }

    Text {
        id: addrLabel
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Text {
        id: sizeLabel
        anchors.centerIn: parent
        text: parent.size + " ( " + free + " )"
        rotation: 270

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
//            for ( var i = 0; i < busyListParams.count; i++ ) {
//                console.log("x: " + busyListParams.get(i).x)
//                console.log("size: " + busyListParams.get(i).size)
//            }
        }
    }

    Component.onCompleted: {
            free = size
            oldFree = free
    }

}

