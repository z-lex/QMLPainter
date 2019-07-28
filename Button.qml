import QtQuick 2.0

Item {
    property alias text: buttonText.text
    property alias textFont: buttonText.font
    property alias textColor: buttonText.color
    property string color: "lightgreen"
    property string pressedColor: "green"
    property string dimmedColor: "gray"
    property alias borderRadius: buttonRect.radius
    property int padding: 15
    property alias isPressed: buttonMouseArea.pressed

    // сигналы кнопки
    signal clicked()
    signal pressed()
    signal released()
    signal pressAndHold()

    // привязка сигналов кнопки к MouseArea
    Connections {
        target: buttonMouseArea
        onClicked: clicked()
        onPressed: pressed()
        onReleased: released()
        onPressAndHold: pressAndHold()
    }

    width: buttonRect.width
    height: buttonRect.height

    Rectangle {
        id: buttonRect
        anchors.fill: parent

        color: parent.color
        radius: 5
        height: buttonText.height + 2*padding
        width: buttonText.width + 2*padding

        Text {
            id: buttonText
            text: qsTr("text")
            font.family: "consolas"
            font.pointSize: 30
            anchors.centerIn: parent
            anchors.margins: padding
        }

        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent

        /* Если реализовывать через присваивания,
        а не через State, не происходит залипания в
        нажатом состоянии при многократном нажатии */
        onPressed: { buttonRect.color = parent.pressedColor }
        onReleased: { buttonRect.color = parent.color }
    }
}
