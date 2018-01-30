#include "utilities.h"

Utilities::Utilities(QObject *parent) :
    QObject(parent)
{
	settings = new QSettings("qtweather", "qtweather", this);

}

/**
Get the zipcode of a corresponding home
@param homeNum home identifier (ie "home1")
@return The zipcode of homeNum, else "" if none exists
*/
QString Utilities::home(QString homeNum){
	return settings->value(homeNum, "").toString();
}

/**
  Set the zipcode of a home
  @param homeNum home identifier (ie "home1")
  @param zipcode The zipcode to be set
  */
void Utilities::setHome(QString homeNum, QString zipcode){
	settings->setValue(homeNum, zipcode);
}

QString Utilities::home1(){
	return settings->value("home1", "").toString();
}

QString Utilities::home2(){
	return settings->value("home2", "").toString();

}

int Utilities::defaultHome(){
	return settings->value("default").toInt();
}

void Utilities::set(QString home1, QString home2, QString def){
	settings->setValue("home1", home1);
	settings->setValue("home2", home2);
	settings->setValue("defaultHome", def);
}


void Utilities::setHome1(QString home1){
	settings->setValue("home1", home1);
}

void Utilities::setHome2(QString home2){
	settings->setValue("home2", home2);
}

void Utilities::setDefaultHome(int homeNum){
	settings->setValue("default", homeNum);
}

int Utilities::strSize(QString string){
	return string.length();
}

void Utilities::minimize(){
#ifdef Q_WS_MAEMO_5
	system("dbus-send --type=signal --session /com/nokia/hildon_desktop com.nokia.hildon_desktop.exit_app_view");
#endif
}

bool Utilities::substr(QString basestr, QString search){
	if (basestr.contains(search))
		return true;
	return false;
}
