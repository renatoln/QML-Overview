#include "httprequest.h"
#include <QUrl>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

HttpRequest::HttpRequest(QObject *parent) : QObject(parent)
{
    /*criou concecao de mNetworkManager (sender/o emisor do sinal) com este objeto (this)
     * quando SIGNAL finished for emitido ele chama o SLOT getResult
     */
    connect(&mNetworkManager, SIGNAL(finished(QNetworkReply *)), this, SLOT(getResult(QNetworkReply *)));
}

void HttpRequest::get(const QString &url)
{
    QUrl qUrl(url); //instanciando objeto qUrl do tipo QUrl
    QNetworkRequest request(qUrl); //poderia usar o request para fazer autenticação
    request.setHeader(QNetworkRequest::ContentTypeHeader, "Application/Json");
    request.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);//se tiver redirecionamento no servidor ele trata
    mNetworkManager.get(request);
}

void HttpRequest::post(const QString &url, const QVariant &param)
{

}

void HttpRequest::getResult(QNetworkReply *reply)
{
    //QNetworkRequest::HttpStatusCodeAttribute = atributo estático que informa o status da resposta
    int statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    //qDebug()<<"result1: "<<reply->readAll();
    if (reply->isFinished()) {
        //qDebug()<<"result2: "<<reply->readAll();
        m_result = reply->readAll();
        //setState(m_stateFinished);
        if (!m_result.isEmpty()) {
             //qDebug()<<"result3: "<<reply->readAll();
            m_json = QJsonDocument::fromJson(m_result, &m_jsonParseError);
            if (m_json.isObject())
                emit finished(statusCode, m_json.object().toVariantMap());
            else if (m_json.isArray())
                emit finished(statusCode, m_json.array().toVariantList());
        } else {
            if (statusCode <= 0)
                requestError(reply->error());
            else
                emit finished(statusCode, m_result);
        }
    } else if (!reply->isRunning()) {
        requestError(reply->error());
    }
    reply->deleteLater(); //delete o ponteiro (free no c)

}
