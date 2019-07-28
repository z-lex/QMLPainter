import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Painter")

    LineCanvas {
        id: canvas
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent

        ColumnLayout {
            id: buttons
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 10

            Button {
                id: plusButton
                text: qsTr("+")
                onClicked: canvas.incrWidth()
            }

            Button {
                id: minusButton
                text: qsTr("-")
                onClicked: canvas.decrWidth()
            }

            Button {
                id: deleteButton
                text: qsTr("X")
                onClicked: canvas.removeColor(canvas.curcolor)
            }
        }

        RowLayout {
            id: switches
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.bottomMargin: 10

            /* Функция, срабатывающая при включении
            какого-либо из переключателей. Переводит
            остальные переключатели в состояние "выкл" */
            function triggerSwitch(switchItem) {
                if (switchItem.checked === false) return;

                canvas.curcolor = switchItem.color;
                for (var iChild = 0; iChild < switches.children.length; iChild++) {
                    if (switches.children[iChild] !== switchItem)
                    switches.children[iChild].checked = false;
                }
            }

            Switch {
                id: greenSwitch
                checked: true
                color: "green"
                backgroundColor: "lightgreen"
                onTriggered: parent.triggerSwitch(this)

                // включаем зеленый при старте
                Component.onCompleted: parent.triggerSwitch(this)
            }

            Switch {
                id: redSwitch
                checked: false
                color: "red"
                backgroundColor: "pink"
                onTriggered: parent.triggerSwitch(this)
            }

            Switch {
                id: blueSwitch
                checked: false
                color: "blue"
                backgroundColor: "lightblue"
                onTriggered: parent.triggerSwitch(this)
            }

            Switch {
                id: yellowSwitch
                checked: false
                color: "yellow"
                backgroundColor: "lightyellow"
                onTriggered: parent.triggerSwitch(this)
            }

            Switch {
                id: blackSwitch
                checked: false
                color: "black"
                backgroundColor: "darkgrey"
                onTriggered: parent.triggerSwitch(this)
            }
        }
    }

}
