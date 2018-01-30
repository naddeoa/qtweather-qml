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

Item {
	id: root
	width: 480
	height: 800

	signal settings()
	signal getFinished(string response, string status, string statusText)
	property bool busy: false

	Component.onCompleted:{
		var obj = settings.createObject(root)
		if(Utilities.defaultHome()){
			get("http://umcs.maine.edu/~naddeoa/qtweather-qml/?zipcode="+Utilities.home("home" + Utilities.defaultHome()))
		}else
			root.settings()

	}
	function get(url){
		root.busy = true
		var xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(xmlHttp.readyState == 4){
				root.busy = false
				root.getFinished(xmlHttp.responseText, xmlHttp.status, xmlHttp.statusText)
			}
		}
		xmlHttp.open( "GET", url, true );
		xmlHttp.send( null );
	}

	SystemPalette{id: palette}

	Item{
		id: border
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.top: parent.top
		height: minButton.height
		z: 100

		Button{
			id: minButton
			iconSource: "qrc:///qml/qtweather-qml/images/minimize.png"
			onClicked: Utilities.minimize()
		}

		Text{
			id: title
			font.bold: true
			font.pixelSize: 24
			color: "white"
			anchors.left: minButton.right
			anchors.top:  parent.top
			anchors.margins: 10
			font.family: "URW Gothic L"
		}

		Button{
			id: sttingsButton
			iconSource: "qrc:///qml/qtweather-qml/images/settings.png"
			anchors.right: parent.right
		}


		Component{
			id: settings
			Settings{
				onZipcode: get("http://umcs.maine.edu/~naddeoa/qtweather-qml/?zipcode="+zip)
				Connections{
					target: settingsButton
					onClicked: toggle()
				}
				Connections{
					target: root
					onSettings: toggle()
				}
			}
		}

		BusyIndicator{
			id: busy
			anchors.top: settingsButton.bottom
			anchors.right: parent.right
			running: false
			visible: false
		}
	}


	function setXml(zipcode){
		model.source = "http://umcs.maine.edu/~naddeoa/qtweather-qml/?zipcode=" + zipcode
	}
	onGetFinished: {
		if(response.match("<error>"))
			title.text = "Invalid Zipcode"
		else
			model.xml = response
	}

	WeatherModel{
		id: model
		onStatusChanged: {
			if(status === XmlListModel.Ready){
				if(get(0))
					title.text = get(0).city
				else
					title.text = ""
			}
		}
	}



	ListView{
		id: list
		orientation: ListView.Horizontal
		anchors.fill: parent
		anchors.topMargin: border.height
		snapMode: ListView.SnapToItem
		flickDeceleration: 10000
		model: model
		cacheBuffer: 1600

		delegate: DayDelegate{
			height: list.height
			width: list.width
			onMovingChanged: { //this is to make sure the list doesn't interfere with the pathview
				if(moving)
					list.interactive = false
				else
					list.interactive = true
			}
		}
	}

	states: [
		State {
			name: "busy"
			when: root.busy
			PropertyChanges {target: busy; running: true; visible: true}
		}
	]



}
