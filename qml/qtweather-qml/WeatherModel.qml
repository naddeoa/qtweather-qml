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

XmlListModel{

	query: "/weather/day"
	XmlRole { name: "city"; query: "@city/string()"; isKey: true}

	XmlRole { name: "day"; query: "name/string()"; isKey: true}
	XmlRole { name: "condition"; query: "condition/string()"; isKey: true }
	XmlRole { name: "temp"; query: "temp/string()"; isKey: true }
	XmlRole { name: "iconurl"; query: "icon/string()"; isKey: true }
	XmlRole { name: "forecast"; query: "wordedForecast/string()"; isKey: true}
	XmlRole { name: "precip"; query: "precipitation/string()"; isKey: true}

	XmlRole { name: "rainGraph"; query: "rainGraph/string()"; isKey: true}
	XmlRole { name: "snowGraph"; query: "snowGraph/string()"; isKey: true}
	XmlRole { name: "precipGraph"; query: "precipGraph/string()"; isKey: true}
	XmlRole { name: "windGraph"; query: "windGraph/string()"; isKey: true}
	XmlRole { name: "tempGraph"; query: "tempGraph/string()"; isKey: true}



}
