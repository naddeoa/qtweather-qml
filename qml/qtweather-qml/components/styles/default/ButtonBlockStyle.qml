import Qt 4.7

QtObject {
    property int minimumWidth: 90
    property int minimumHeight: 32

    property int leftMargin : 8
    property int topMargin: 8
    property int rightMargin: 8
    property int bottomMargin: 8

    property Component background:
    Component {
        id: defaultBackground
        Item {
            opacity: enabled ? 1 : 0.7
            Rectangle { // Background center fill
                anchors.fill: parent
                anchors.leftMargin: adjoining&Qt.Horizontal ? 0 : 2
                anchors.rightMargin: anchors.leftMargin
                anchors.topMargin: adjoining&Qt.Vertical ? 0 : 2
                anchors.bottomMargin: anchors.topMargin

                radius: adjoining ? 0 : 5
                color: !styledItem.checked ? backgroundColor : Qt.darker(backgroundColor)
            }
            BorderImage {
                anchors.fill: parent
                smooth: true
                source: {
                    if(!adjoining)
                        return styledItem.pressed || styledItem.checked ? "images/button_pressed.png" : "images/button_normal.png";
                    else if(adjoining&Qt.Horizontal)
                        return styledItem.pressed || styledItem.checked ? "images/buttongroup_h_pressed.png" : "images/buttongroup_h_normal.png";
                    else // adjoining&Qt.Vertical
                        return styledItem.pressed || styledItem.checked ? "images/buttongroup_v_pressed.png" : "images/buttongroup_v_normal.png";
                }
                border.left: 6; border.top: 6
                border.right: 6; border.bottom: 6
            }
        }
    }

    property Component label:
    Component {
        id: defaultLabel
        Item {
            width: row.width
            height: row.height
            anchors.centerIn: parent    //mm see QTBUG-15619
            opacity: styledItem.enabled ? 1 : 0.5
            transform: Translate {
                x: styledItem.pressed || styledItem.checked ? 1 : 0
                y: styledItem.pressed || styledItem.checked ? 1 : 0
            }

            Row {
                id: row
                anchors.centerIn: parent
                spacing: 4
                Image {
                    source: styledItem.iconSource
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.Stretch //mm Image should shrink if button is too small, depends on QTBUG-14957
                }

                Text {
                    color: styledItem.textColor
                    anchors.verticalCenter: parent.verticalCenter
                    text: styledItem.text
                    horizontalAlignment: Text.Center
                    elide: Text.ElideRight //mm can't make layout work as desired without implicit size support, see QTBUG-14957
                }
            }
        }
    }
}
