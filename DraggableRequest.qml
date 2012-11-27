import QtQuick 2.0
import "functions.js" as Memory

MouseArea {
    id: draggableRequest
    drag.target: request
    width: 100; height: 100
    anchors.centerIn: parent
    property alias size: sizeLebel.text

    Rectangle {
        id: request
        color: "yellow"
        width: 100; height: 100
        border { color: "black"; width: 3 }
        anchors {
            horizontalCenter: parent.horizontalCenter;
            verticalCenter: parent.verticalCenter
        }

        Drag.keys: "human"
        Drag.active: draggableRequest.drag.active
        Drag.source: draggableRequest
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10

        Text {
            id: sizeLebel
            anchors.centerIn: parent
        }

        states: [
            State {
                name: "inAir"
                when: request.Drag.active
                ParentChange {
                    target: request
                    parent: mainWindow
                }
                PropertyChanges {
                    target: request
                    opacity: 0.7
                    width: size
                    height: 200
                }
                AnchorChanges {
                    target: request
                    anchors.horizontalCenter: undefined
                    anchors.verticalCenter: undefined
                }
            },
            State { // not in the use
                name: "inPlace"
                PropertyChanges {
                    target: request
                    color: "darkred"
                    opacity: 0.5
                    width: size
                    height: 200
                }
            }
        ]
    }

    onReleased: {
        if ( request.Drag.target !== null ) {
            parent = request.Drag.target // targeted chunk becomes parent of request
            if ( Memory.updateChunk(parent) == 1 ) {
                /* Note. Can't destroy() objects created by Repeater.
                   Can't delete from model, because it is shared in my case*/
                draggableRequest.visible = false
            } else { parent = stack } // request.Drag.drop()
        } else {
            // in case of dropping in a wrong place - go back to the top of stack
            parent = stack
        }
    }
}
