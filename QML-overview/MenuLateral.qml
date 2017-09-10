import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

Drawer {
    id: menu
    width: 0.66 * rootWindow.width; height: rootWindow.height
    dragMargin: enabled ? Qt.styleHints.startDragDistance : 0

    // on login and logout page, the menu needs to be disabled
    // and make bind with this property
    property bool enabled: true
    property string userName: "Enoque Joseneas"
    property string userEmail: "enoquejoseneas@ifba.edu.br"
    property var pages: [
        {"title": "Wall message"},
        {"title": "Realizar chamada"},
        {"title": "Editar perfil"},
        {"title": "Ver notificações"},
        {"title": "Sair"}
    ]

    Rectangle {
        id: drawerImage
        color: "red"
        width: parent.width; height: 150
        anchors.top: parent.top

        Image {
            id: image
            asynchronous: true; z: 0
            clip: true; cache: true; smooth: true
            width: parent.width; height: 150
            anchors.top: parent.top
            // fillMode: Image.PreserveAspectFit
            source: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVdwXpelkmcIFn7WcnjFMB8rfilikAQH_LM_UYZO8ecUdU9wKh"

            Label {
                z: 1
                color: "#fff"; textFormat: Text.RichText
                text: menu.userName + "<br><b>" + menu.userEmail + "</b>"
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                anchors {
                    bottom: image.bottom
                    bottomMargin: 15
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Flickable {
        anchors { top: drawerImage.bottom; topMargin: 15 }
        contentHeight: Math.max(column.implicitHeight, height)
        boundsBehavior: Flickable.StopAtBounds
        ScrollIndicator.vertical: ScrollIndicator { }

        Column {
            id: column
            spacing: 15

            Repeater {
                model: menu.pages // repeate the pages, delegating to Label each text

                Label {
                    text: modelData.title
                    color: "#444"; textFormat: Text.RichText
                    font.pointSize: 12
                    anchors { left: parent.left; leftMargin: 20 }

                    MouseArea {
                        //                            anchors.fill: parent
                        onClicked: {
                            menu.close()
                            // implementa aqui a troca de página
                            // se a aplicação tiver usando o StackView, faz o da página clicada
                            // passando a url da página
                        }
                    }
                }
            }
        }
    }
}
