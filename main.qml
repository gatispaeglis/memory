import QtQuick 2.0
//import QtGraphicalEffects 0.1
import "functions.js" as Memory

Rectangle {
    id: mainWindow
    width: 1200; height: 1000
    border.width: 2; border.color: "black"
    color: "gray"
    property int memorySize: Memory.availableMemory()
    clip: true

    ChunkModel { id: chunks }
    RequestModel { id: requests }

    Rectangle {
        id: leftSide
        width: 180;
        height: mainWindow.height
        color: "lightskyblue"

        Image {
            source: "bg.jpg"

        }

        Column {
            id: btnColumn
            anchors.horizontalCenter: leftSide.horizontalCenter
            anchors.topMargin: 30
            anchors.top: parent.top
            spacing: 20

            Button { text: "Run FirstFit"; onButtonClicked: Memory.firstFitAllocation() }
            Button { text: "Run BestFit"; onButtonClicked: Memory.bestFitAllocation() }
            Button { text: "Run WorstFit"; onButtonClicked: Memory.worstFitAllocation() }
            Button { text: "Run NextFit"; onButtonClicked: Memory.nextFitAllocation() }

            // generate z stacked DraggableRequest(s)
            Button {
                text: "Run Human"
                //onButtonClicked: generateDraggableRequests()
            }

            Item {
                id: stack
                width: 100; height: 100

                Repeater {
                    id: genDraggableRequests
                    model: requests
                    DraggableRequest {
                        size: requests.get(index).size
                        z: requests.count - index // put first request on top
                    }
                }
            }
        } // end column
    } // end of left side

    Rectangle {
        id: rightSide
        width: mainWindow.width - leftSide.width;
        height: mainWindow.height
        anchors.left: leftSide.right
        color: "black"

        Rectangle { // implements this part as Flickable
            id: visualisationArea
            width: parent.width
            height: parent.height - underVisualisationArea.height
            border {color: "black"; width: 2}
            color: "lightgray"

            Column {
                spacing: 10
                anchors.verticalCenter: visualisationArea.verticalCenter
                anchors.horizontalCenter: visualisationArea.horizontalCenter

                RandomAccessMemory { id: firstFit; width: memorySize; freeChunkModel: chunks }
                RandomAccessMemory { id: bestFit; width: memorySize; freeChunkModel: chunks }
                RandomAccessMemory { id: worstFit; width: memorySize; freeChunkModel: chunks }
                //RandomAccessMemory { id: nextFit; width: memorySize; freeChunkModel: chunks }
                HumanRAM { id: human; width: memorySize; freeChunkModel: chunks }
            }
        }

        Rectangle {
            id: underVisualisationArea
            width: parent.width; height: 200
            anchors.top: visualisationArea.bottom
            color: "lightskyblue"
            border { color: "black"; width: 2 }

            // logging window goes here
            Rectangle {
                id: logWindow
                width: parent.width / 2; height: parent.height - 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                border { color: "grey"; width: 2 }
                radius: 12; clip: true; color: "black"

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#45373B" }
                    GradientStop { position: 1.0; color: "black" }

                }

                ListView {
                    id: logView
                    anchors.fill: logWindow
                    width: logWindow.width - 30; height: logWindow.height - 30
                    anchors { leftMargin: 20; rightMargin: 20; topMargin: 14; bottomMargin: 14 }
                    model: LogMessageModel { id: logMessages }
                    delegate: LogRecord { id: logRecords /*line: "55"*/ }

                    onCountChanged: {
                        currentIndex = count - 1
                    }

                }
            }
        }
    } // end right side
}




