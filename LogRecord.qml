import QtQuick 2.0

Component {

    Item {
        id: wrapper
        width: logView.width; height: 24
        property alias color: msgLabel.color
        property int line: 0
        Column {
            Text  { id: msgLabel; text: line + ": " + msg; color: "darkgreen"; font.pixelSize: 15; font.bold: true  }
        }

        states: State {
            name: "current"
            when: wrapper.ListView.isCurrentItem /* attached property */
            PropertyChanges {
                target: wrapper
                color: "red"
            }
        }
    }
}
