import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    property var database: LocalStorage.openDatabaseSync("Teste", "1.0", "descricao do banco",10000000)

    signal itemAdded(var item)
    //onItemAdded: JSON.stringify(item)

    function createTable(){
        database.transaction(function(tx){
            tx.executeSql("CREATE TABLE if not exists Itens(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, title TEXT)")
        })
    }

    function insert(item){
        var result = {}
        database.transaction(function(tx){
            result = tx.executeSql("INSERT OR REPLACE INTO Itens VALUES (?, ?)", [null, item])
            console.log("result : ", JSON.stringify(result))
        })
        itemAdded({"itemId":parseInt(result.insertId),"title":item})

    }

    function list(){
        var jsonItens = []
        database.transaction(function(tx){
            var result = tx.executeSql("SELECT * FROM Itens")
            console.log("rows: ", result.rows.length)
            for (var i = 0; i < result.rows.length; i++)
                itemAdded({"itemId": result.rows.item(i).id,
                    "title": result.rows.item(i).title
                    })
                /*jsonItens.push({"itemId": result.rows.item(i).id,
                               "title": result.rows.item(i).title
                               })*/

        })

        //return jsonItens

    }

}
