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
	property string graphUrl
	onGraphUrlChanged: veil.opacity = 1

	width: 600
	height: 250

	Flickable{
		anchors.fill: parent
		contentHeight: graph.height
		contentWidth: graph.width
		clip: true
		boundsBehavior: Flickable.StopAtBounds

		Image {
			id: graph
			width: 1600
			height: root.height
			onStatusChanged: {
				if(status === Image.Ready)
					veil.opacity = 0
			}
		}
	}

	Rectangle{
		id: veil
		z: 100
		radius: 5
		color: "white"
		anchors.fill: parent
		opacity: 0
		onOpacityChanged:{
			if(opacity === 1)
				graph.source = Utilities.decode(graphUrl)
		}
		Behavior on opacity {NumberAnimation{ duration: 250}}
		BusyIndicator{
			anchors.centerIn: parent
			running: opacity ? true : false
		}
	}

}
