#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "utilities.h"
#include <QDeclarativeContext>

int main(int argc, char *argv[])
{
	QApplication::setGraphicsSystem("opengl");
    QApplication app(argc, argv);


	Utilities utils;
    QmlApplicationViewer viewer;
	viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
//	viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
	viewer.setWindowTitle("QtWeather");
	viewer.rootContext()->setContextProperty("Utilities", &utils);
	viewer.setMainQmlFile(QLatin1String("qml/qtweather-qml/main.qml"));



#ifdef Q_WS_MAEMO_5
	viewer.showFullScreen();
#else
	viewer.showExpanded();
#endif

	return app.exec();
}
