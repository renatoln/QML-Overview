#ifndef HTTPREQUEST_H
#define HTTPREQUEST_H

#include <QObject>

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonParseError>
#include <QJsonDocument>

//a classe c++ vira componente sse extender QObject
class HttpRequest : public QObject
{
    Q_OBJECT
public: //metodos publicos
    explicit HttpRequest(QObject *parent = 0);
    Q_INVOKABLE void get(const QString &url); //Q_INVOKABLE permite o QML invocar isso
    Q_INVOKABLE void post(const QString &url, const QVariant &param);

signals:
    void requestError(const QVariant &error);
    void finished(int status, const QVariant &result); //sinal nao tem corpo e pode ter parâmetros

private slots: //métodos a serem conectados a sinais de objetos
    void getResult(QNetworkReply *reply);

private:
    QByteArray m_result;
    QJsonParseError m_jsonParseError;
    QNetworkAccessManager mNetworkManager;
    QJsonDocument m_json;
};

#endif // HTTPREQUEST_H
