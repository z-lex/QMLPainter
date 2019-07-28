import QtQuick 2.0

Item {
    property alias color: switchInnerRect.color
    property color backgroundColor: "lightgreen"
    property color dimmedColor: "gray"
    property alias borderRaduis: switchOuterRect.radius
    property bool checked: false

    function trigger() {
        checked = !checked;
        triggered();
    }

    signal triggered()

    state: "unchecked"

    states: [
        State {
            name: "unchecked"
            when: !checked
            changes: [
                PropertyChanges {
                    target: switchInnerRect
                    x: switchOuterRect.x + 1
                },
                PropertyChanges {
                    target: switchOuterRect
                    color: dimmedColor
                }
            ]
        },

        State {
            name: "checked"
            when: checked
            changes: [
                PropertyChanges {
                    target: switchInnerRect
                    x: switchOuterRect.x + switchOuterRect.width/2 - 1
                },
                PropertyChanges {
                    target: switchOuterRect
                    color: backgroundColor
                }
            ]
        }
    ]

    height: 50
    width: height*2

    Rectangle {
        id: switchOuterRect
        anchors.fill: parent

        //color: "gray"
        border.width: 1
        radius: 20

        Rectangle {
            id: switchInnerRect

            anchors.verticalCenter: parent.verticalCenter

            height: parent.height - 2
            width: parent.width/2
            radius: parent.radius
            color: "green"


            // сглаживание изменения положения
            Behavior on x {
                NumberAnimation { duration: 200 }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.trigger()
    }

}
