import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Page {
    title: "Uso de Serviços Rest"
    property alias textField1: textField1
    property alias button1: button1

    property bool isActive: swipeView.currentItem.title == title
    onIsActiveChanged: {
        if (isActive && listModel.count==0) {
            busy.visible = true
            httpRequest.get("https://emile-server.herokuapp.com/students")
        }
    }


    /*Component.onCompleted: {
        busy.visible = true
        httpRequest.get("https://emile-server.herokuapp.com/students")
    }*/

    Connections{ //cria conexão com sinal em componente externo
        target: httpRequest
        onFinished: { //sinal defindo na classe httpRequest
            console.log("result: ",result)
            var lista = result.users  //propriedade users no json que é uma lista de alunos/usuarios
            busy.visible = false
            for (var i = 0; i < lista.length; i++) {
                listModel.append(lista[i]) //esse lista[i] corresponde ao um aluno
            }
        }
    }

    BusyIndicator{
        id: busy
        anchors.centerIn: parent
    }

    RowLayout {
        id: row
        visible: !busy.visible
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.top

        TextField {
            id: textField1
            placeholderText: qsTr("Text Field")
        }

        Button {
            id: button1
            text: qsTr("Press Me")
            onClicked: {
                console.log("Button Pressed. Entered text: " + textField1.text);
                db.insert(textField1.text)
            }
        }
    }

    ListModel{
        id: listModel
    }

    ListView{
        height: 300
        anchors.top: row.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        model: listModel
        delegate: Text{

            text: parseInt(id) + " - " + email
        }
    }

}

