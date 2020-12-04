//easyui-tree自动勾选指定的节点checkbox(回绑数据)
//jQuery: 




    //初始化tree,获取tree所有节点所有叶子，此时不勾选任何checkbox

    function LoadTree() {

        $("#btn_FW_Edit").show();

        $("#btn_FW_Save").hide();

        $.ajax({

            type: "GET",

            url: "/Rights/ExecutePermission/GetTreeJson",

            success: function (result) {

                var myJson = eval('(' + result + ')');//格式化json，用以绑定tree控件

                $("#myTree").tree({

                    data: myJson,

                    onlyLeafCheck: false,//仅叶子节点可以被选中

                    checkbox: false,//开启多选框

                });

            }

        });

    }

    $(function () {

        LoadTree();

    });

    $(function () {

        $("#btn_FW_Reload").click(function () {

            LoadTree();

        });

    });

    //根据权限id来自动勾选tree节点

    function CheckTree() {

        $("#btn_FW_Edit").hide();

        $("#btn_FW_Save").show();

 

        $("#myTree").tree({

            onlyLeafCheck: true,//仅叶子节点可以被选中

            checkbox: true,//开启多选框

        });

        //先将回显数据全部清除（重点方法）

        var root = $("#myTree").tree("getRoot");

        $("#myTree").tree("uncheck", root.target);

        //自动勾选tree节点

        var rows = $("#DataGrid").datagrid("getSelections");

        var id = rows[0].PermissionID;

        $.ajax({

            url: "/Rights/ExecutePermission/BindTree",

            data: {

                PermissionID: id,

            },

            success: function (data) {
                //data返回的应该是一个对象
                //接收一个数组，内容为该app 的所有支持设备的id



                for (x in data) {

                    var node = $("#myTree").tree("find", data[x].ControlID);//重点方法

                    $("#myTree").tree("check", node.target);

                }

            }

        });

    }

    //tree编辑的按钮

    $(function () {

        $("#btn_FW_Edit").click(function () {

            var rows = $("#DataGrid").datagrid("getSelections");

            if (rows.length != 1) {

                alert("请左边列表中选择一个[权限]！");

                return;

            } else {

                CheckTree();

            }

        });

    });

    //单击datagrid行事件

    $(function () {

        $("#DataGrid").datagrid({

            onClickRow: function (index, row) {

                var PermissionID = row.PermissionID;

                if ($("#divTabs").tabs("exists", "设置")) {

                    $("#divTabs").tabs("select", "设置");

                    CheckTree();

                }

            }

        });

    });

    //保存勾选的tree

    $(function () {

        $("#btn_FW_Save").click(

            function () {

                var rows = $("#DataGrid").datagrid("getSelections");

                if (rows.length != 1) {

                    alert("请左边列表中选择一个[权限]！");

                    return;

                } else {

                    var id = rows[0].PermissionID;

                    var nodes = $("#myTree").tree("getChecked");//重点方法

                    var res_id = '';//获取选中的tree叶子的id值

                    for (var i = 0; i < nodes.length; i++) {

                        if (res_id != '') res_id += ',';

                        res_id += nodes[i].id;

                    }

                    $.ajax({

                        url: "/Rights/ExecutePermission/SaveTree",

                        data: {

                            PermissionID: id,

                            ControlID: res_id,

                        },

                        success: function (data) {

                            if (data == "OK") {

                                alert("修改成功!");

                                LoadTree();

                                document.getElementById('frameExecute').contentWindow.location.reload(true);

                            }

                            else {

                                alert(data);

                            }

                        }

                    });

                }

            });

    });



//easyui-tree自动勾选指定的节点checkbox(回绑数据)