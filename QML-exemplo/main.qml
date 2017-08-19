import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
//import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0
import HttpRequest 1.0

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 640
    height: 480
    title: currentPage.title

    property Item currentPage: persistence.isLogged ? swipeView.currentItem : frmLogin
    property int pageWidth: rootWindow.width

    Component.onCompleted: { //esse evento é chamado tão logo todos os componentes desse arquivo estejam carregados
        //if (!persistence.isLogged)
        //    swipeView.currentIndex = swipeView.count - 1
        //console.log("profile: ", JSON.stringify(persistence.userprofile))
    }

    HttpRequest{
        id: httpRequest
    }

    Database {
        id: db
        Component.onCompleted: db.createTable()
    }

    MenuLateral{
        id: drawer
        //Component.onCompleted: drawer.open()
    }

    Settings{ //gravação usando o componente settings
        id: persistence
        property var userprofile
        property bool isLogged: false
        //onUserprofileChanged:
    }

    /*
        message dialog criado para interagir com o usuário.
        Foi criado aqui para ser reutilizado em toda a aplicação, caso necessário
    */
    MessageDialog{
        id: msnDialog
        onVisibleChanged: {
            if (!visible){
                title = ""
                text = ""
            }
        }
        buttons: MessageDialog.Ok | MessageDialog.Cancel
    }


    FormLogin{
        id: frmLogin
        title: "Login"
        anchors.fill: parent
        visible: !persistence.isLogged
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        visible: !frmLogin.visible

        PageItens { //PageItens é um componete criado na aplicação
            property string title: "Uso de banco de dados"
        }

        PageListRemoteUsers {

        }

        Page {
            title: "Logout"
            Column{
                anchors.centerIn: parent
                Label {
                    text: qsTr("Deseja Sair?")

                }
                Button{
                    text: "Sim"
                    onClicked: persistence.isLogged = false
                }

            }
        }


    }

    footer: TabBar { //header = muda para o topo
        id: tabBar
        currentIndex: swipeView.currentIndex
        visible: swipeView.visible
        TabButton {
            text: qsTr("Banco de Dados")
        }
        TabButton {
            text: qsTr("Serv. Rest")
        }
        TabButton {
            text: qsTr("Logout")
        }

    }
}
