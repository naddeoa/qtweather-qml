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

Item{
	id: root
	signal clicked()
	property string wordedForecast: forecast

	property string family: "URW Gothic L"
	property int textZ: 1
	property bool moving : path.moving


	Text{
		id: dayText
		z: textZ
		text: day
		font.pixelSize: 40
		color: "white"
		anchors.left: parent.left
		anchors.top:  parent.top
		anchors.margins: 10
		font.family: family
	}

	Text{
		id: conditionText
		z: textZ
		text: condition
		font.pixelSize: 24
		color: "white"
		anchors.left: parent.left
		anchors.top:  dayText.bottom
		anchors.leftMargin: 10
		font.family: family
	}

	Text{
		id: tempText
		z: textZ
		text: temp
		font.pixelSize: 24
		color: "white"
		anchors.left: parent.left
		anchors.top:  conditionText.bottom
		anchors.leftMargin: 10
		font.family: family
	}

	Text{
		id: precipText
		z: textZ
		text: "Precip: "+precip
		font.pixelSize: 24
		color: "white"
		anchors.left: parent.left
		anchors.top:  tempText.bottom
		anchors.leftMargin: 10
		font.family: family
	}

	Text{
		text: forecast
		z: textZ
		font.pixelSize: 24
		wrapMode: Text.Wrap
		color: "white"
		anchors.left: parent.left
		anchors.bottom:  parent.bottom
		anchors.right: parent.right
		anchors.leftMargin: 10
		font.family: family
	}

	states: [
		State {
			name: "portrait"
			when: root.width > root.height
			PropertyChanges {target: conditionText; anchors.top: root.top; anchors.left: dayText.right; anchors.topMargin: 20; anchors.leftMargin: 30}
			PropertyChanges {target: tempText; anchors.top: root.top; anchors.left: conditionText.right; anchors.topMargin: 20; anchors.leftMargin: 30}
			PropertyChanges {target: precipText; anchors.top: root.top; anchors.left: tempText.right; anchors.topMargin: 20; anchors.leftMargin: 30}
		}
	]

	GraphFrame{
		id: graph
		z:1
		anchors.left: parent.left
		width: root.width*.7
		anchors.verticalCenter: parent.verticalCenter
	}

	ListModel{
		id: model
		//had to append in javascript instead of ListElement{}s to use the graph variables...
		Component.onCompleted: {
			append({ "iconUrl": "qrc:///qml/qtweather-qml/images/temp.png", "graphUrl": tempGraph });
			append({ "iconUrl": "qrc:///qml/qtweather-qml/images/precip.png", "graphUrl": precipGraph });
			append({ "iconUrl": "qrc:///qml/qtweather-qml/images/wind.png", "graphUrl": windGraph });
			append({ "iconUrl": "qrc:///qml/qtweather-qml/images/rain.png", "graphUrl": rainGraph });
			append({ "iconUrl": "qrc:///qml/qtweather-qml/images/snow.png", "graphUrl": snowGraph });
			graph.graphUrl = get(0).graphUrl
			path.model = model
		}
	}


	PathView{
		id: path

		anchors.fill: parent
		anchors.right: parent.right
		preferredHighlightBegin: .5
		preferredHighlightEnd: .5
		clip: true
		dragMargin: 100
		flickDeceleration: 10000

		delegate:Button{
			id: button
			iconSource: iconUrl
			scale: PathView.scale
			Connections{
				target: path
				onMovementEnded:{
					if(path.currentIndex == index)
						graph.graphUrl = graphUrl
				}
			}
		}
		path: Path{
			startX: root.width+100; startY: 0
			PathAttribute{name: "scale"; value: .3}
			PathLine{
				x: root.width*.85; y: root.height*.5
			}
			PathAttribute{name: "scale"; value: 1}
			PathLine{
				x: root.width+100; y: root.height
			}
			PathPercent{value: 1}
		}
	}

}

