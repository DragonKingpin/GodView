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
                        <span>系统共用单词总库</span>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("appendNewWord")%>" class="btn btn-primary btn-lg crisp-btn-info">
                    <div style="float: left"><i class="fa fa-plus fa-2x"></i></div><div class="inlineSpan" >
                    <span>添加基本词缀</span>
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

        <div id="mutualWordsList" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12"      >
                    <h4 class="header-line" style="font-size: 110%"><i class="fa fa-database"></i><span> 系统共用单词总库</span></h4>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-1">
                    <a href="javascript:void(0)" class="btn btn-danger" id="wordMassDelete" style="border-radius: 0">批量删除</a>
                </div>
                <div class="col-sm-5">
                    <div class="form-group com-group-control-search">
                        <label for="filterAuthority">筛选: </label>
                        <select id="filterAuthority" class="form-control" name="authority">
                            <option value="-1">全部</option>
                            <option value="0">名词</option>
                            <option value="1">形容词</option>
                            <option value="2">介词</option>
                            <option value="3">动词</option>
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
                        <th>英文(主词)</th>
                        <th>基本中文释意</th>
                        <th>词性</th>
                        <th>音标</th>
                        <th>同源词</th>
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

        <div id="appendNewWord" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-plus"></i><span> 添加基本词缀</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="wordAppendForm" id="wordAppendForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("appendNewWord")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">Fundamental Word Append</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">English Word</td>
                            <td colspan="2"><input name="en_word" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/></td>
                            <td style="width:15%;">Fundamental Chinese Mean</td>
                            <td colspan="2">
                                <input name="cn_simple_mean" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Word Character</td>
                            <td colspan="2"><input name="w_character" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/></td>
                            <td style="width:15%;">USA Phonetic Symbol</td>
                            <td colspan="2">
                                <input name="us_phonetic_symbol" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Word Roots</td>
                            <td colspan="5"><input name="w_word" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="250"/></td>
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

        <div id="wordEditor" style="display:none;">
            <div class="row pad-botm">
                <div class="col-md-12">
                    <h4 class="header-line" style="font-size: 110%">
                        <i class="fa fa-edit"></i><span> 修改基本词缀</span>
                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" style="float: right;"><i class="fa fa-reply"></i>返回</a>
                    </h4>
                </div>
            </div>

            <form name="wordEditForm" id="wordEditForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("modifyOneWord")%>">
                <div class="table-responsive" style="color: black">
                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                        <input name="id" id="idModify" type="hidden" class="crisp-tiny-input-underline" />
                        <tbody style="text-align: center">
                        <tr>
                            <td colspan="6" style="font-size: 120%">Fundamental Word Modify</td>
                        </tr>
                        <tr>
                            <td style="width:15%;">English Word</td>
                            <td colspan="2">
                                <input name="en_word" id="en_wordModify" type="hidden" class="crisp-tiny-input-underline" />
                                <input name="en_word_new" id="en_word_newModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">Fundamental Chinese Mean</td>
                            <td colspan="2">
                                <input name="cn_simple_mean" id="cn_simple_meanModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Word Character</td>
                            <td colspan="2">
                                <input name="w_character" id="w_characterModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                            <td style="width:15%;">USA Phonetic Symbol</td>
                            <td colspan="2">
                                <input name="us_phonetic_symbol" id="us_phonetic_symbolModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="100"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%;">Word Roots</td>
                            <td colspan="5">
                                <input name="w_word" id="w_wordModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="250"/>
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
            "mutualWordsList": function ( parent ) {
                var hWordsList = pageData["WordsList"];
                var szTableZone = '';
                var szDeleteURL = Predator.spawnControlQuerySpell( "deleteOneWord" );

                for( var i=0; i < hWordsList.length; i++ ){
                    var row = hWordsList[i];
                    szTableZone += '<tr>\n' +
                        '<td><input type="checkbox" name="massDelete" value="'+row['id']+'"  style="width: 30%"><span>选择</span></td>' +
                        Predator.renderTable( row,['id','en_word','cn_simple_mean','w_character','us_phonetic_symbol',] )  + "<td>"+ ( row["w_word"] ) +"</td>" + '<td>' +

                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell( "wordEditor" ) + "&id=" + row['id'] + '" style="">\n' +
                        '       <i class="fa fa-edit fa-lg" style="margin-left: 2px;"></i>\n' +
                        '   </a>\n' +
                        '   <a class="" data-toggle="modal" href="' + Predator.spawnActionQuerySpell() + '#modalDeleteOne'+row['id']+'" style="">\n' +
                        '       <i class="fa fa-trash-o fa-lg" style="margin-left: 2px;margin-right: 2px;"></i>\n' +
                        '   </a>\n' +
                        Predator.warnCommonDialog(
                            'modalDeleteOne' + row['id'], "Warning",
                            '<h4>Are you sure to delete the word "'+ row['en_word'] + '"?</h4>',
                            szDeleteURL + '&id=' + row['id'],"Confirm"
                        ) +
                        '</td></tr>';
                }
                Predator.appendTableWhileThereAreData( parent.spawnSubSelector("tbody"),szTableZone );

                Predator.showStaticPageIndex( parent.spawnSubSelector(".crisp-paginate ul"),pPine.isThenSet($_GET["pageid"],1), pageData['nPageDataSum'],pageData['nPageLimit']);
                Predator.smartMassDeleteListener( "wordMassDelete" );
            },

            "appendNewWord": function () {

            },

            "wordEditor": function () {
                $_PMVC.formDynamicRenderer(pageData['CurrentWordInfo'], "Modify", null);
                $_PINE("#en_word_newModify").val( pageData['CurrentWordInfo']["en_word"] );
            }
        }).summon(Predator.getAction());
    });

</script>
${StaticPageEnd}