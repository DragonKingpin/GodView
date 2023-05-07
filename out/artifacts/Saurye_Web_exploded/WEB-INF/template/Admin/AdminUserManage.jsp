<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
${StaticHead}

<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line"><a href="/"><i class="fa fa-home"></i> 首页</a> >> 管理员专区 >> <label id="currentTitle"></label></h4>
            </div>
        </div>

        <div class="row" style="margin-bottom: 1.5%">
            <div class="col-md-4">
                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" class="btn btn-success btn-lg crisp-btn-info">
                    <div style="float: left"><i class="fa fa-database fa-2x"></i></div>
                    <div class="inlineSpan">
                        <span>账号信息管理</span>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("appendNewUser")%>" class="btn btn-primary btn-lg crisp-btn-info">
                    <div style="float: left"><i class="fa fa-plus fa-2x"></i></div><div class="inlineSpan" >
                    <span>添加用户</span>
                </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="#" class="btn btn-info btn-lg crisp-btn-info">
                    <div style="float: left"><i class="fa fa-unlink fa-2x"></i></div><div class="inlineSpan" >
                    <span>批量添加</span>
                </div>
                </a>
            </div>
        </div>

        <div id="mutualUsersList" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%"><i class="fa fa-database"></i><span> 账号信息管理</span></h4>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-1">
                    <a href="#" class="btn btn-danger" id="userMassDelete" style="border-radius: 0">批量删除</a>
                </div>
                <div class="col-sm-5">
                    <div class="form-group com-group-control-relate">
                        <label for="filterAuthority">筛选: </label>
                        <select id="filterAuthority" class="form-control" name="authority" onchange="javascript:pageData.fnAfterAuthorityFilterSelected( this );">
                            <option value="">全部</option>
                            <option value="0">普通用户</option>
                            <option value="3">管理员</option>
                            <option value="4">超级管理员</option>
                        </select>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group com-group-control-search">
                        <label for="nameID">搜索: </label>
                        <input class="form-control" id="nameID" name="nameID" type="text"
                               placeholder="输入姓名或昵称" maxlength="25" onkeydown="javascript:pageData.fnAfterNameIdFilterGiven();" />
                        <a href="#" onclick="javascript:pageData.fnAfterNameIdFilterGiven();" class="btn btn-default">查找</a>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover crisp-picture-table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" class="allcheck" style="width: 15%">全选
                        </th>
                        <th>ID</th>
                        <th>账号</th>
                        <th>昵称</th>
                        <th>权限</th>
                        <th>注册时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody><tr><td colspan="7">Empty Data！</td></tr></tbody>
                </table>
            </div>

            <div class="col-sm-12 crisp-margin-ui-fault-tolerant-2">
                <div class="crisp-paginate">
                    <ul class="pagination"></ul>
                </div>
            </div>
        </div>

        <div id="appendNewUser" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-plus"></i><span> 添加用户</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="userAppendForm" id="userAppendForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("appendNewUser")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">Fundamental User Information</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Username</td>
                            <td colspan="2"><input name="username" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/></td>
                            <td style="width:15%;">Avatar</td>
                            <td colspan="2">
                                <input name="avatar" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Nickname</td>
                            <td colspan="2">
                                <input name="nickname" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">Password</td>
                            <td colspan="2">
                                <input name="password" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Authority</td>
                            <td colspan="2">
                                <select class="form-control" name="authority">
                                    <option value="normal">普通用户</option>
                                    <option value="vip">VIP</option>
                                    <option value="admin">管理员</option>
                                    <option value="super">超级管理员</option>
                                </select>
                            </td>
                            <td style="width:15%;">Registration Date</td>
                            <td colspan="2">
                                <input name="registration_date" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer" style="text-align: right;border-radius: 0">
                    <button type="submit" class="btn btn-info" style="width:100px;"><i class="fa fa-plus"></i> Append</button>
                    <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>"><button type="button" class="btn btn-default" style="width:100px;"><i class="fa fa-reply"></i> Return</button></a>
                </div>

            </form>
        </div>

        <div id="userEditor" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-edit"></i><span> 修改用户</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="userEditForm" id="userEditForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("modifyOneUser")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <input name="id" id="idModify" type="hidden" class="crisp-tiny-input-underline" />
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">Fundamental User Information</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Username</td>
                            <td colspan="2">
                                <input name="username" id="usernameModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">Avatar</td>
                            <td colspan="2">
                                <input name="avatar" id="avatarModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Nickname</td>
                            <td colspan="2">
                                <input name="nickname" id="nicknameModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100" readonly/>
                            </td>
                            <td style="width:15%;">Password</td>
                            <td colspan="2">
                                <input name="password" id="passwordModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Authority</td>
                            <td colspan="2">
                                <select class="form-control" name="authority" id="authorityModify">
                                    <option value="normal">普通用户</option>
                                    <option value="vip">VIP</option>
                                    <option value="admin">管理员</option>
                                    <option value="super">超级管理员</option>
                                </select>
                            </td>
                            <td style="width:15%;">Registration Date</td>
                            <td colspan="2">
                                <input name="registration_date" id="registration_dateModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer" style="text-align: right;border-radius: 0">
                    <button type="submit" class="btn btn-info" style="width:100px;"><i class="fa fa-edit"></i> Modify</button>
                    <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>"><button type="button" class="btn btn-default" style="width:100px;"><i class="fa fa-reply"></i> Return</button></a>
                </div>

            </form>
        </div>

    </div>
</div>
${StaticFooter}
<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/bootstrap.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script>
    var pageData = ${szPageData};

    $_Predator( pageData, function(){
        $_CPD({
            "mutualUsersList": function ( parent ) {
                var hWordsList = pageData["UsersList"];
                var szTableZone = '';
                var szDeleteURL = Predator.spawnControlQuerySpell( "deleteOneUser" );

                for( var i=0; i < hWordsList.length; i++ ){
                    var row = hWordsList[i];
                    row[ 'authority' ] = Predator.parseSystemAuthority( row[ 'authority' ] );
                    szTableZone += '<tr>\n' +
                        '<td><input type="checkbox" name="massDelete" value="'+row['id']+'"  style="width: 30%"><span>选择</span></td>' +
                        Predator.renderTable( row,['id','username','nickname','authority','registration_date'] ) + '<td>' +
                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell( "userEditor" ) + "&id=" + row['id'] + '" style="">\n' +
                        '       <i class="fa fa-edit fa-lg" style="margin-left: 2px;"></i>\n' +
                        '   </a>\n' +
                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell() + '#modalDeleteOne'+row['id']+'" style="">\n' +
                        '       <i class="fa fa-trash-o fa-lg" style="margin-left: 2px;margin-right: 2px;"></i>\n' +
                        '   </a>\n' +
                        Predator.warnCommonDialog(
                            'modalDeleteOne' + row['id'], "Warning",
                            '<h4>Are you sure to delete the user "'+ row['username'] + '"?</h4>',
                            szDeleteURL + '&id=' + row['id'],"Confirm"
                        ) +
                        '</td></tr>';
                }


                Predator.appendTableWhileThereAreData( parent.spawnSubSelector("tbody"),szTableZone );

                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                Predator.smartMassDeleteListener( "userMassDelete" );

                pageData.fnAfterAuthorityFilterSelected = function ( h ) {
                    Predator.searcher.querySearch( { "authority": h }, true );
                };
                pageData.fnAfterNameIdFilterGiven = function () {
                    Predator.searcher.bindSingleSearch( "nameID", '#nameID', true );
                };
                Predator.page.surveyQueryStrAndBind( { "authority" : "#filterAuthority", "nameID": "#nameID" } );
            },

            "appendNewUser": function () {
                $_PINE("input[name='registration_date']").val( pPine.DateTime.format("yyyy-MM-dd") );
            },

            "userEditor": function () {
                $_PMVC.formDynamicRenderer(pageData['CurrentUserInfo'], "Modify", null);
            }
        }).summon(Predator.getAction());
    });

</script>
${StaticPageEnd}
