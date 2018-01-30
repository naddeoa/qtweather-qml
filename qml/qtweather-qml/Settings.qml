/***********************************************************************
** Copyright (C) 2011 Anthony Naddeo <anthony.naddeo@gmail.com>
**
** This file is part of qtweather-qml
**
** qtweather-qml is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** qtweather-qml is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this package; If not, see <http://www.gnu.org/licenses/>.
**
***********************************************************************/

import QtQuick 1.0
import "components"


Button {
	id: root
	height: parent.height * .7
	width: parent.width * .8
	anchors.centerIn: parent
	z: 200
	checked: true

	signal zipcode(string zip)
	property bool shown: false

	onShownChanged: shown ? show.running = true : hide.running = true
	opacity: shown ? 1 : 0
	function toggle(){shown = !shown}
	Behavior on opacity {NumberAnimation{duration:250}}
	PropertyAnimation {id: show; target: root; property: "scale"; from: .95; to: 1; duration: 250}
	PropertyAnimation {id: hide; target: root; property: "scale"; from: 1; to: .95; duration: 250}




	function toggleOpacity(){
		if(!opacity)
			opacity = 1
		else
			opacity = 0
	}

	Button{
		text: "Quit"
		onClicked: Qt.quit()
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.top
		anchors.margins: 5
	}

	Column{
		anchors.fill: parent
		anchors.margins: 20
		spacing: 10

		Repeater{
			id: repeater
			signal check(int ind)

			model: 4
			Item {
				property alias checked : checkbox.checked
				height: button.height
				anchors.left: parent.left
				anchors.right: parent.right
				Button{
					id: button
					text: "Home " + (index+1)
					anchors.left: parent.left
					onClicked: {
						if(textField.text && !wasHeld){
							root.zipcode(textField.text)
							toggle()
						}
					}
					onPressAndHold: {
						if(textField.text)
							Qt.openUrlExternally("http://forecast.weather.gov/zipcity.php?inputstring=" + textField.text )
					}
				}
				TextField{
					id: textField
					text: Utilities.home("home"+(index+1))
					placeholderText: "zipcode"
					anchors.left: button.right
					anchors.right: checkbox.left
					anchors.margins: 10
					validator: RegExpValidator{regExp: /[0-9][0-9][0-9][0-9][0-9]/}
					onTextChanged: Utilities.setHome("home"+(index+1),text)
					onAccepted: button.clicked(false)
				}

				RadioButton{
					id: checkbox
					anchors.right: parent.right
					anchors.verticalCenter: parent.verticalCenter
					checked: (index+1) === Utilities.defaultHome() ? true : false
					onClicked: {
						if(checked)
							Utilities.setDefaultHome(index+1)
						else
							Utilities.setDefaultHome(0)
						repeater.check(index)

					}
					Connections{
						target: repeater
						onCheck:{
							if(ind !== index)
								checked = false
						}
					}
				}
			}
		}

		Rectangle{
			id: spacer
			width: parent.width*.8
			height: 2
			color: palette.text
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Item {
			height: searchButton.height
			anchors.left: parent.left
			anchors.right: parent.right
			Button{
				id: searchButton
				text: "Search"
				anchors.left: parent.left
				onClicked: {
					if(searchField.text && !wasHeld){
						root.zipcode(searchField.text)
						toggle()
					}
				}
				onPressAndHold: {
					if(searchField.text)
						Qt.openUrlExternally("http://forecast.weather.gov/zipcity.php?inputstring=" + searchField.text)
				}
			}
			TextField{
				id: searchField
				placeholderText: "zipcode"
				anchors.left: searchButton.right
				anchors.right: parent.right
				anchors.margins: 10
				validator: RegExpValidator{regExp: /[0-9][0-9][0-9][0-9][0-9]/}
				onAccepted: searchButton.clicked(false)
			}

		}


	}


}
