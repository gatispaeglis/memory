import QtQuick 2.0
//import QtGraphicalEffects 0.1

Rectangle {
    width: 100; height: 60
    property alias text: btnLabel.text

    //color: "darkcyan"

    signal buttonClicked()

//    LinearGradient {
//        anchors.fill: parent
//        //start: Qt.point(0, 0)
//        //end: Qt.point(width, height)
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "mediumturquoise" }
//            GradientStop { position: 1.0; color: "darkcyan" }
//        }

//    }

    radius: 15

    Text {
        id: btnLabel
        anchors.centerIn: parent
        smooth: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            buttonClicked()
        }

    }
}
