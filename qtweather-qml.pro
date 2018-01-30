# Add more folders to ship with the application, here
folder_01.source = qml/qtweather-qml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE191CA6E

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices


# DEFINES += QMLJSDEBUGGER

SOURCES += main.cpp \
    utilities.cpp

HEADERS += \
    utilities.h

RESOURCES += \
    resources.qrc

OTHER_FILES +=

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
