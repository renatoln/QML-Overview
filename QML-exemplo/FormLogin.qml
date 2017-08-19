import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page {

    //ler sobre signals slots
    Connections{
        target: persistence
        onUserprofileChanged: console.log("msn: ", persistence.userprofile)
    }

    ColumnLayout{
        anchors.centerIn: parent
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        Label{
            text: "Email: "
        }
        TextField{
            id: tfEmail
            placeholderText: "email"
            width: pageWidth
            text: persistence.userprofile.email || ""
        }
        Label{
            text: "Senha: "

        }
        TextField{
            id: tfSenha
            placeholderText: "senha"
            echoMode: TextInput.Password
        }
        Row{
            spacing: 5
            Button{
                id: btnSubmeter
                text: "enviar"
                onClicked: {
                    if(tfEmail.text && tfSenha.text){
                        var jsonUser = {
                            "email":tfEmail.text,
                            "senha":tfSenha.text
                        }
                        persistence.userprofile = jsonUser
                        persistence.isLogged = true
                    }else{
                        msnDialog.title = "Erro"
                        msnDialog.text = "Email e senha requeridos"
                        msnDialog.open()
                    }
                }
            }

            Button{
                id: btnReset
                text: "Resetar"
                onClicked: {
                    var jsonUser = {
                        "email":"",
                        "senha":""
                    }
                    persistence.userprofile = jsonUser

                }
            }
        }

    }

}
