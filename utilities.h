#ifndef DECODER_H
#define DECODER_H

#include <QObject>
#include <QUrl>
#include <QSettings>
#include <stdlib.h>

class Utilities : public QObject
{
    Q_OBJECT
public:
	explicit Utilities(QObject *parent = 0);
	Q_INVOKABLE QString decode(QString string){
		return QUrl::fromPercentEncoding(string.toStdString().c_str());
	}

	Q_INVOKABLE QString home(QString homeNum);
	Q_INVOKABLE void setHome(QString homeNum, QString zipcode);

	Q_INVOKABLE QString home1();
	Q_INVOKABLE QString home2();
	Q_INVOKABLE int defaultHome();

	Q_INVOKABLE void set(QString home1, QString home2, QString def);
	Q_INVOKABLE void setHome1(QString home1);
	Q_INVOKABLE void setHome2(QString home2);
	Q_INVOKABLE void setDefaultHome(int homeNum);

	Q_INVOKABLE int strSize(QString string);
	Q_INVOKABLE bool substr(QString basestr, QString search);

	Q_INVOKABLE void minimize();

private:
	QSettings* settings;

signals:

public slots:

};

#endif // DECODER_H
