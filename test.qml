import QtQuick 2.0

Rectangle {
    id: main
    width: 900; height: 900

    Rectangle {
        id: btn
        x: 0; y: 0
        width: 100; height: 80
        color: "green"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("currentIndex: " + listView.currentIndex)
                console.log("currentIndex: " + listView.currentItem.typee)
            }
        }
    }

        Component {
            id: petDelegate
            Item {
                id: wrapper
                property alias nameColor: nameField.color
                property alias typee: typeField.text
                width: 200; height: 55
                Column {
                    Text { id: nameField; text: 'Name: ' + name; color: "blue" }
                    Text { id: typeField; text: 'Type: ' + type }
                    Text { text: 'Age: ' + age }
                }
                // indent the item if it is the current item
                states: State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges { target: wrapper; x: 20; nameColor: "red" }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; duration: 200 }
                }
            }
        }

        // Define a highlight with customised movement between items.
        Component {
            id: highlightBar
            Rectangle {
                width: 200; height: 50
                color: "#FFFF88"
                y: listView.currentItem.y;
                Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }
        }

        Rectangle {
            width: 200; height: 600
            border.color: "black"
            border.width: 2
            anchors.centerIn: parent
            clip: true

            ListView {
                id: listView
                width: 200; height: parent.height


                model: pets
                delegate: petDelegate
                focus: true

                // Set the highlight delegate. Note we must also set highlightFollowsCurrentItem
                // to false so the highlight delegate can control how the highlight is moved.
                highlight: highlightBar
                highlightFollowsCurrentItem: false
            }


        }




































        ListModel {
            id: pets
            ListElement {
                name: "Polly"
                type: "Parrot"
                age: 12
                size: "Small"
            }
            ListElement {
                name: "Penny"
                type: "Turtle"
                age: 4
                size: "Small"
            }
            ListElement {
                name: "Warren"
                type: "Rabbit"
                age: 2
                size: "Small"
            }
            ListElement {
                name: "Spot"
                type: "Dog"
                age: 9
                size: "Medium"
            }
            ListElement {
                name: "Schrödinger"
                type: "Cat"
                age: 2
                size: "Medium"
            }
            ListElement {
                name: "Joey"
                type: "Kangaroo"
                age: 1
                size: "Medium"
            }
            ListElement {
                name: "Kimba"
                type: "Bunny"
                age: 65
                size: "Large"
            }
            ListElement {
                name: "Rover"
                type: "Dog"
                age: 5
                size: "Large"
            }
            ListElement {
                name: "Tiny"
                type: "Elephant"
                age: 15
                size: "Large"
            }
        }
}

