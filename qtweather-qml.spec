# no post install
#%define __os_install_post %{nil}
# no strip
#%define __strip /bin/true
# no debug package
#%define debug_package %{nil}
# disable automatic dependency processing
#AutoReqProv: no

Name:           qtweather-qml
Version:	0.0.4
Release:        3
License:        GPL
Summary:        Weather application for the Natinal Weather Service in the US
Url:            http://qtweather-qml.googlecode.com
Group:          Applications/Utilities
Source:         qtweather-qml-0.0.4.tar.gz
Packager:       Anthony Naddeo <anthony.naddeo@gmail.com>
#BuildRequires:  pkgconfig(QtCore)
BuildRequires:  libqt4-dev

%description
*Not an official National Weather Service application* 
This is the QML version of QtWeather:
The National Weather Service is an American Government site 
that offers a free XML feed for the United States. This application 
uses their free XML services to report weather information and 
display hourly temperature and conditions graphs in a 
convenient, logical layout.

%prep
%setup -q

%build
# Add here commands to configure the package.
#%qmake
#qmake -makefile -nocache QMAKE_STRIP=: PREFIX=%{_prefix}

# Add here commands to compile the package.
#make %{?jobs:-j%jobs}
#make %{?_smp_mflags}
qmake
make

%install
# Add here commands to install the package.
#%qmake_install
make install INSTALL_ROOT=%{buildroot}

%files
%defattr(-,root,root,-)
/*