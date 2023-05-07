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
                    <span>添加基本单词</span>
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
            <div class="crisp-my-box" id="statistics">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-database"></i><span> 系统共用单词总库</span>
                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                筛选器 <i class="fa fa-angle-down"></i>
                            </a>
                        </h4>
                    </div>
                </div>
                <div id="UnionFilter" class="panel panel-default box-content" style="border-radius: 0;">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group com-group-control-search">
                                    <label for="pageLimit" style="width: 23%">每页: </label>
                                    <input class="form-control" id="pageLimit" type="text" value="15" placeholder="输入条数限制" maxlength="10" style="width: 60%" onkeydown="pageData.fnSetPageLimit();" >
                                    <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default">设置</a>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group com-group-control-search">
                                    <label for="cn_word" style="width: 23%">中文: </label>
                                    <input class="form-control" id="cn_word" type="text" placeholder="输入中文释义（准确）" maxlength="25" style="width: 60%" onkeydown="pageData.fnSearchCnWord()" >
                                    <a href="javascript:pageData.fnSearchCnWord()" class="btn btn-default">查找</a>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group com-group-control-search">
                                    <label for="en_word" style="width: 23%">英文: </label>
                                    <input class="form-control" id="en_word" type="text" placeholder="输入单词，带'%' 为模糊查找" maxlength="60" style="width: 60%" onkeydown="pageData.fnSearchEnWord()" >
                                    <a href="javascript:pageData.fnSearchEnWord()" class="btn btn-default">查找</a>
                                </div>
                            </div>
                        </div>

                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line" style="font-size: 110%"><i class="fa fa-database"></i><span> 高级检索</span></h4>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group com-group-control-search">
                                    <label for="cn_fuzzy_index" style="width: 23%">中文模糊(索引): </label>
                                    <input class="form-control" id="cn_fuzzy_index" type="text" placeholder="输入中文释义关键字" maxlength="25" style="width: 60%" onkeydown="pageData.fnSearchCnFuzzy()" >
                                    <a href="javascript:pageData.fnSearchCnFuzzy()" class="btn btn-default">查找</a>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group com-group-control-search">
                                    <label for="cn_fuzzy_def" style="width: 23%">中文模糊(定义): </label>
                                    <input class="form-control" id="cn_fuzzy_def" type="text" placeholder="输入中文释义关键字" maxlength="25" style="width: 60%" onkeydown="pageData.fnSearchCnFuzzy(1)" >
                                    <a href="javascript:pageData.fnSearchCnFuzzy(1)" class="btn btn-default">查找</a>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <div class="form-group com-group-control-relate">
                                    <label for="wordSort" style="width: 30%">英文排序: </label>
                                    <select id="wordSort" class="form-control" name="authority" onchange="" style="width: 70%">
                                        <option value="">未排序</option>
                                        <option value="0">字典升序</option>
                                        <option value="1">字典降序</option>
                                        <option value="2">字母数升序</option>
                                        <option value="3">字母数升序</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group com-group-control-search">
                                    <label for="pageid" style="width: 23%">跳页: </label>
                                    <input class="form-control" id="pageid" type="text" value="1" placeholder="输入预跳转的页码" maxlength="10" style="width: 60%" onkeydown="pageData.fnSetPageID();" >
                                    <a href="javascript:pageData.fnSetPageID()" class="btn btn-default">跳转</a>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group com-group-control-search">
                                    <label for="bandWord" style="width: 23%">等级单词: </label>
                                    <input class="form-control" id="bandWord" type="text" maxlength="10" style="width: 60%" onkeydown="" >
                                    <a href="javascript:void(0)" class="btn btn-default">匹配</a>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="text-align: center;">
                            <a href="javascript:void(0);" class="btn btn-danger" id="wordMassDelete" style="border-radius: 0">批量删除</a>
                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" class="btn btn-primary btn-sharp">清除筛选</a>
                        </div>
                    </div>
                </div>
            </div>


            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover crisp-picture-table">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" onclick="Saurye.checkAll(this)" style="width: 20%">全选/ID
                        </th>
                        <th>Enum</th>
                        <th>英文(主词)</th>
                        <th>中文简意</th>
                        <th>音标</th>
                        <th>等级</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody><tr><td colspan="7">Empty Data!</td></tr></tbody>
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
                        <i class="fa fa-plus"></i><span> 添加基本单词</span>
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
                            <td style="width:15%;">English Levels</td>
                            <td colspan="5"><input name="w_level" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="250"/></td>
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
                        <i class="fa fa-edit"></i><span> 修改基本单词</span>
                        <a href="javascript:pPine.Navigate.back()" style="float: right;"><i class="fa fa-reply"></i>返回</a>
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
                            <td style="width:15%;">English Levels</td>
                            <td colspan="5">
                                <input name="w_level" id="w_levelModify" type="text" class="crisp-tiny-input-underline" style="width:80%;" maxlength="250"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer" style="text-align: right;border-radius: 0">
                    <button type="submit" class="btn btn-info" style="width:100px;" ><i class="fa fa-save"></i> Save</button>
                    <a href="javascript:pPine.Navigate.back()"><button type="button" class="btn btn-default" style="width:100px;"><i class="fa fa-reply"></i> Return</button></a>
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
                var hWordsList  = pageData["WordsList"];
                var szTableZone = '';
                var szDeleteURL = Predator.spawnControlQuerySpell( "deleteOneWord" );

                var hRowEnumCounter = Predator.paginate.rowEnumCounter();
                for( var i=0; i < hWordsList.length; i++ ){
                    var row = hWordsList[i];
                    row['phonetic'] = row[ 'us_phonetic_symbol' ] ? row[ 'us_phonetic_symbol' ] : row[ 'uk_phonetic_symbol' ];
                    szTableZone += '<tr>' +
                        '<td style="min-width: 100px"><input type="checkbox" name="massDelete" value="'+row['id']+'"  style="width: 30%"><span>' + row['id'] + '</span></td>' +
                        '<td>' + hRowEnumCounter.now( i + 1 ) + '</td>' + Predator.renderTable( row,['en_word'] ) +
                        '<td style="max-width: 300px">' + row['cn_simple_mean'] + '</td>' +  Predator.renderTable( row,['phonetic'] ) +
                        "<td>"+ Predator.jsonWordDatumCoding.bandWordDecode( row["w_level"], ',' ) +"</td>" + '<td>' +

                        '   <a class="" href="' + Predator.spawnActionQuerySpell( "wordEditor" ) + "&id=" + row['id'] + '" style="">\n' +
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

                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                Predator.smartMassDeleteListener( "wordMassDelete" );

                pageData.fnSearchEnWord = function () {
                    Predator.searcher.bindSingleSearch( "en_word", '#en_word', true );
                };
                pageData.fnSearchCnWord = function () {
                    Predator.searcher.bindSingleSearch( "cn_word", '#cn_word', true );
                };
                pageData.fnSearchCnFuzzy = function ( t ) {
                    if( t === 1 ){
                        Predator.searcher.bindSingleSearch( "cn_fuzzy_def", '#cn_fuzzy_def', true );
                    }
                    else {
                        Predator.searcher.bindSingleSearch( "cn_fuzzy_index", '#cn_fuzzy_index', true );
                    }
                };
                pageData.fnSetPageLimit = function () {
                    Predator.searcher.bindSingleSearch( "pageLimit", '#pageLimit', true );
                };
                pageData.fnSetPageID = function () {
                    Predator.searcher.bindSingleSearch( "pageid", '#pageid' );
                };

                Predator.page.surveyQueryStrAndBind( ["cn_fuzzy_index","cn_fuzzy_def","cn_word","en_word","pageLimit","pageid"] );
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