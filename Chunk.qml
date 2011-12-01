import QtQuick 1.0

Rectangle {
    height: 100
    border.width: 1
    border.color: "black"
    color: "yellow"
    property int size: 0
    property int free: 0
    property alias addr: addrLabel.text

    onSizeChanged: {
        free = size
    }

    Text {
        id: addrLabel
        anchors.horizontalCenter: parent.horizontalCenter
        //x: parent.x + 5
        //y: parent.y + 5
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
            size = size - 10;
            console.log("size: " + size)
            console.log("free: " + free)
        }
    }

}

