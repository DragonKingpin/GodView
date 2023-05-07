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
                        <span>用户个人单词本管理</span>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("appendNewGlossary")%>" class="btn btn-primary btn-lg crisp-btn-info">
                    <div style="float: left"><i class="fa fa-plus fa-2x"></i></div><div class="inlineSpan" >
                    <span>添加单词本</span>
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

        <div id="mutualGlossaryList" style="display:none;" >
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%"><i class="fa fa-database"></i><span> 用户个人单词本管理</span></h4>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-1">
                    <a href="javascript:void(0)" class="btn btn-danger" id="glossaryMassDelete" style="border-radius: 0">批量删除</a>
                </div>
                <div class="col-sm-5">
                    <div class="form-group com-group-control-search">
                        <label for="filterAuthority">筛选: </label>
                        <select id="filterAuthority" class="form-control" name="authority">
                            <option value="-1">全部</option>
                            <option value="0">用户名</option>
                            <option value="1">单词本名</option>
                            <option value="2">权限：公开</option>
                            <option value="3">权限：私有</option>
                        </select>
                        <a href="javascript:" class="btn btn-default">筛选</a>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group com-group-control-search">
                        <label for="searchText">搜索: </label>
                        <input class="form-control" id="searchText" name="searchText" type="text"
                               placeholder="输入任何内容" maxlength="25" required/>
                        <a href="#" class="btn btn-default">查找</a>
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover crisp-picture-table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" onclick="Saurye.checkAll(this)" style="width: 20%">全选
                        </th>
                        <th>ID</th>
                        <th>classID</th>
                        <th>用户名</th>
                        <th>单词本名</th>
                        <th>权限</th>
                        <th>创建时间</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody><tr><td colspan="8">Empty Data!</td></tr></tbody>
                </table>
            </div>

            <div class="col-sm-12 crisp-margin-ui-fault-tolerant-2">
                <div class="crisp-paginate">
                    <ul class="pagination"></ul>
                </div>
            </div>
        </div>

        <div id="appendNewGlossary" style="display:none;" >
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-plus"></i><span> 添加单词本</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="glossaryAppendForm" id="glossaryAppendForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("appendNewGlossary")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">单词本添加</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">用户名</td>
                            <td colspan="2">
                                <input name="username" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">单词本名</td>
                            <td colspan="2">
                                <input name="g_name" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">备注</td>
                            <td colspan="2">
                                <input name="g_note" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">权限</td>
                            <td colspan="5">
                                <select class="form-control" name="g_authority">
                                    <option value="0">私有</option>
                                    <option value="1">公开</option>
                                </select>
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

        <div id="glossaryEditor" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-edit"></i><span> 修改用户单词本</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="glossaryEditForm" id="glossaryEditForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("modifyOneGlossary")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">单词本修改</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">ClassId</td>
                            <td colspan="2">
                                <input name="class_id" id="class_idModify" type="text" class="crisp-tiny-input-underline" disabled="true"/>
                                <input name="class_idShow" id="class_idShowModify" class="crisp-tiny-input-underline" type="hidden">
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">用户名</td>
                            <td colspan="2">
                                <input name="usernameShow" id="usernameShow" class="crisp-tiny-input-underline" disabled="true"/>
                                <input name="username" id="usernameModify" class="crisp-tiny-input-underline" type="hidden">
                            </td>
                            <td style="width:15%;">单词本名</td>
                            <td colspan="2">
                                <input name="g_name" id="g_nameModify" type="text" class="crisp-tiny-input-underline" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">单词本备注</td>
                            <td colspan="2">
                                <input name="g_note" id="g_noteModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">个人权限</td>
                            <td colspan="5">
                                <input name="g_authority" id="g_authorityModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="250"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer" style="text-align: right;border-radius: 0">
                    <button type="submit" class="btn btn-info" style="width:100px;" ><i class="fa fa-save"></i> Save</button>
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
            "mutualGlossaryList": function ( parent ) {
                var hWordsList = pageData["GlossaryList"];
                var szTableZone = '';
                var szDeleteURL = Predator.spawnControlQuerySpell( "deleteOneGlossary" );

                for( var i=0; i < hWordsList.length; i++ ){
                    var row = hWordsList[i];
                    szTableZone += '<tr>\n' +
                        '<td><input type="checkbox" name="massDelete" value="'+row['id']+'"  style="width: 30%"><span>选择</span></td>' +
                        Predator.renderTable( row,['id','class_id','username','g_name','g_authority','create_data','g_note'] ) +"</td>" + '<td>' +

                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell( "glossaryEditor" ) + "&class_id=" + row['class_id'] + '" style="">\n' +
                        '       <i class="fa fa-edit fa-lg" style="margin-left: 2px;"></i>\n' +
                        '   </a>\n' +
                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell() + '#modalDeleteOne'+row['id']+'" style="">\n' +
                        '       <i class="fa fa-trash-o fa-lg" style="margin-left: 2px;margin-right: 2px;"></i>\n' +
                        '   </a>\n' +
                        Predator.warnCommonDialog(
                            'modalDeleteOne' + row['id'], "Warning",
                            '<h4>Are you sure to delete the glossary "'+ row['g_name'] + '"?</h4>',
                            szDeleteURL + '&id=' + row['id'],"Confirm"
                        ) +
                        '</td></tr>';
                }
                Predator.appendTableWhileThereAreData( parent.spawnSubSelector("tbody"),szTableZone );

                Predator.showStaticPageIndex( parent.spawnSubSelector(".crisp-paginate ul"),pPine.isThenSet($_GET["pageid"],1), pageData['nPageDataSum'],pageData['nPageLimit']);
                Predator.smartMassDeleteListener( "glossaryMassDelete" );
            },

            "appendNewGlossary": function () {

            },

            "glossaryEditor": function () {
                $_PMVC.formDynamicRenderer(pageData['CurrentGlossaryInfo'], "Modify", null);
                $_PINE("#usernameShow").val( pageData['CurrentGlossaryInfo']["username"] );
                $_PINE("#class_idModify").val( pageData['CurrentGlossaryInfo']["class_id"] );
            }
        }).summon(Predator.getAction());
    });

</script>
${StaticPageEnd}