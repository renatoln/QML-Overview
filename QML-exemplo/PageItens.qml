import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Item {
    property alias textField1: textField1
    property alias button1: button1
    Component.onCompleted: { //esse componente é chamado ao final da criacao de todos os outros componetens
        db.list()
        /*var itens = db.list()
        for (var i = 0; i < itens.length; i++){
            listModel.append(itens[i])
            //console.log("items: ", JSON.stringify(itens[i]))
        }*/
    }

    Connections{ //cria conexão com sinal em componente externo
        target: db
        onItemAdded: listModel.append(item) //esse item do parametro é o parametro do sinal
    }

    RowLayout {
        id: row
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
            text: parseInt(itemId) + " - " + title
        }
    }

}

