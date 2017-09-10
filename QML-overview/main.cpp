#include <QApplication>
#include <QQmlApplicationEngine>

#include "httprequest.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);


    /* Primeiro parâmetro: "HttpRequest" -> utilizado no import no QML
     * Ultimo parâmetro: "HttpRequest" -> Nome componente que o Qml usa para instanciar o objeto
     *
     */
    qmlRegisterType<HttpRequest> ("HttpRequest", 1, 0, "HttpRequest");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));


    return app.exec();
}
