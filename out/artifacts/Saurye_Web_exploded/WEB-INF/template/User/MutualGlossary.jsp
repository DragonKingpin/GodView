<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC = thisPage.$_GSC();
    JSONObject proto = thisPage.getModularConfig();
    String szWordQuerySpell = thisPage.querySpell().queryWord("");
%>
${StaticHead}
<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label>魔法单词本</label> >> <label id="pageNodeTitle"></label>
                </h4>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-2">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%"><i class="fa fa-list"></i><a href="javascript:void(0)" class="predator-left-super-menu-clip"> 目录</a></h4>
                    </div>
                </div>
                <div class="crisp-union-box predator-left-super-menu">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                    <div class="header">
                                        <i class="fa fa-book"></i>
                                    </div>
                                    <div id="mutualGlossaryIndexLabel" class="content" style="font-size: 140%">社区单词本</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn orange-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell("systemGlossaryList")%>">
                                    <div class="header">
                                        <i class="fa fa-book"></i>
                                    </div>
                                    <div id="systemGlossaryIndexLabel" class="content" style="font-size: 140%">系统单词本</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="mutualGlossaryList" style="display:block;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>社区单词本</span>
                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                    <i class="fa fa-angle-down"></i> 筛选
                                </a>
                            </h4>
                        </div>
                    </div>

                    <div class="box-content" style="display: none;">
                        <div class="panel panel-default" style="border-radius: 0;">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <label for="gNameSearch" style="width: 25%">名称</label>
                                            <input id="gNameSearch" class="form-control"  type='text' style="width: 52%;display:inline;" onchange="pageData.fnSearchGlossaryName()"/>
                                            <a style="float: right;width: 21%;border-radius: 0;" href="#" class="btn btn-default" onclick="pageData.fnSearchGlossaryName()">查找</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group com-group-control-search">
                                            <label style="width: 39%">权限</label>
                                            <select id="glossaryAuthority" class="form-control" style="width: 60%;display:inline;" onchange="pageData.fnSearchGlossaryAuthority()">
                                                <option value="">未选择</option>
                                                <option value="public">公开</option>
                                                <option value="private">私有</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group com-group-control-search">
                                            <label style="width: 39%">标签</label>
                                            <select  class="form-control" style="width: 60%;display:inline;" onchange="">
                                                <option value="">未选择</option>
                                                <option value="0">公开</option>
                                                <option value="1">私有</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="text-align: center;">
                                    <a href="<%=thisPage.spawnActionQuerySpell()%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="crisp-my-box">
                    <div class="row predator-glossary-box" >
                        <script type="text/html" id = "tplGlossaryTable">
                            <# for( var i in PamphletList ) {
                            var row     = PamphletList[i];
                            var classid = row["classid"];
                            var imgurl  = row["g_img_href"];
                            var g_name  = row["g_name"];
                            #>
                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("wordList")%>&class_id=<#=classid#> ">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="<#=imgurl#>" onerror="this.src='/root/root/System/img/noimg.jpg'" >
                                        <div style="position: absolute;margin-top: 10%;">
                                            <span style="color: #999;font-size: 5px;">by </span>
                                            <span style="color: #888;font-size: 10px;"> <#=row["username"]#></span>
                                        </div>
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-heart p-g-used-time" title="收藏人数"></a>
                                            <span style="margin-top: 5%"><#=row["g_c_usage"]#></span>
                                            <a class="glyphicon glyphicon-star-empty p-g-purge" style="font-size: 18px" data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#modalDeleteOne<#=classid#>"></a>
                                        </div>
                                        <div class="p-glossary-title">
                                            <a><#=g_name#></a>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <#}#>

                        </script>
                    </div>

                    <div class="row crisp-my-box">
                        <div class="col-sm-4 ">
                            <div class="form-group com-group-control-search">
                                <label for="mutualGlossaryListPageLimit" style="width: 23%">每页: </label>
                                <input class="form-control" id="mutualGlossaryListPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                            </div>
                        </div>
                        <div class="col-sm-8 predator-row-pagination">
                            <div class="crisp-paginate">
                                <ul class="pagination"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="systemGlossaryList" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>社区单词本</span>
                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                    <i class="fa fa-angle-down"></i> 筛选
                                </a>
                            </h4>
                        </div>
                    </div>

                    <div class="box-content" style="display: none;">
                        <div class="panel panel-default" style="border-radius: 0;">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <label for="gNameSearch" style="width: 25%">名称</label>
                                            <input id="gSystemNameSearch" class="form-control"  type='text' style="width: 52%;display:inline;" onchange="pageData.fnSearchGlossaryName()"/>
                                            <a style="float: right;width: 21%;border-radius: 0;" href="#" class="btn btn-default" onclick="pageData.fnSearchGlossaryName()">查找</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group com-group-control-search">
                                            <label style="width: 39%">权限</label>
                                            <select id="gSystemAuthority" class="form-control" style="width: 60%;display:inline;" onchange="pageData.fnSearchGlossaryAuthority()">
                                                <option value="">未选择</option>
                                                <option value="public">公开</option>
                                                <option value="private">私有</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group com-group-control-search">
                                            <label style="width: 39%">标签</label>
                                            <select  class="form-control" style="width: 60%;display:inline;" onchange="">
                                                <option value="">未选择</option>
                                                <option value="0">公开</option>
                                                <option value="1">私有</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row" style="text-align: center;">
                                    <a href="<%=thisPage.spawnActionQuerySpell()%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="crisp-my-box">
                    <div class="row predator-glossary-box" >
                        <script type="text/html" id = "tplSystemGlossaryTable">
                            <# for( var i in PamphletList ) {
                            var row     = PamphletList[i];
                            var classid = row["classid"];
                            var imgurl  = row["g_img_href"];
                            var g_name  = row["g_name"];
                            #>
                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("wordSystemList")%>&class_id=<#=classid#> ">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="<#=imgurl#>" onerror="this.src='/root/root/System/img/noimg.jpg'" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-heart p-g-used-time" title="学习人数"></a>
                                            <span style="margin-top: 5%"><#=row["g_c_usage"]#></span>
                                        </div>
                                        <div class="p-glossary-title">
                                            <a><#=g_name#></a>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <#}#>

                        </script>
                    </div>

                    <div class="row crisp-my-box">
                        <div class="col-sm-4 ">
                            <div class="form-group com-group-control-search">
                                <label for="systemGlossaryListPageLimit" style="width: 23%">每页: </label>
                                <input class="form-control" id="systemGlossaryListPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                            </div>
                        </div>
                        <div class="col-sm-8 predator-row-pagination">
                            <div class="crisp-paginate">
                                <ul class="pagination"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="col-sm-10" id="wordList" style="display:none;" >
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="crisp-my-profile">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplGlossaryProfile">
                                    <# var row = GlossaryProfile[0];
                                    var imgurl = row["g_img_href"];
                                    var class_id = row["classid"];
                                    #>
                                    <div class="col-md-3">
                                        <img id="user-index-avatar" class="img-responsive crisp-limit-avatar" style="min-width: 200px; min-height: 200px;" src="<#=imgurl#>" alt="" onerror="this.src='/root/root/System/img/noimg.jpg'">
                                    </div>
                                    <div class="col-md-9">
                                        <h3 style="color: black; margin-top: 5px">
                                            <span style="font-weight:bold" ><#=row["g_name"]#></span>
                                            <# if( !bgReadonly ){#>
                                            <a href="?do=MutualGlossary#modalCollectGlossary<#=class_id#>" data-toggle="modal" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-plus"></i>&nbsp;收藏</span>
                                            </a>
                                            <#}else{#>
                                            <a href="" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-check"></i>已收藏</span>
                                            </a>
                                            <#}#>
                                        </h3>
                                        <h5 style="color:#999">
                                            <i class="glyphicon glyphicon-user"></i>
                                            由 <#=row["username"]#> <#=row["g_create_data"]#> 创建
                                        </h5>
                                        <hr style="color: black;border-top:2px solid">
                                        <h4><i class="fa fa-tag"></i><label>标签：</label>
                                            <a href="" style="font-weight: bolder">暂无标签！</a>
                                        </h4>
                                        <h4><i class="fa fa-tag"></i><label>词数：</label> <span style="font-weight: bolder"><#=nWordSum#></span></h4>
                                        <h4><i class="fa fa-tag"></i><label>简介：</label>
                                            <#if( row["g_note"] ){#>
                                            <span style=" font-style:italic"><#=row["g_note"]#></span>
                                            <#}else{#>
                                            <span>该单词本很懒，没有留下简介！</span>
                                            <#}#>
                                        </h4>
                                    </div>
                                    <div class="modal fade crisp-union-win" id="modalCollectGlossary<#=class_id#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                    <h4 class="modal-title" id="crisp-WarnCommonLabel">是否收藏</h4>
                                                </div>
                                                <div class="modal-body"><h4>您确定收藏单词本 《<#=row["g_name"]#>》 吗?</h4></div>
                                                <div class="modal-footer">
                                                    <a href="<%=thisPage.spawnControlQuerySpell("collectWordGlossary")%>&class_id=<#=class_id#>"><button class="btn btn-danger">收藏</button></a>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </script>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="crisp-my-box row">
                    <div class="col-md-12">
                        <div class="header-line predator-player-controller">
                            <div class="p-p-down">
                                <a class="box-down" href="javascript:void(0)"><i class="fa fa-angle-down"></i> 控制台</a>
                            </div>
                            <div class="p-p-control">
                                <div class="p-pc-player" >
                                    <div class="p-pc-s-speed" >
                                        <div class="form-group com-group-control-search">
                                            <label for="seReadSpeed" style="width: 28%">速度: </label>
                                            <select id="seReadSpeed" class="form-control">
                                                <option value="1000">中</option>
                                                <option value="1500">慢</option>
                                                <option value="700">快</option>
                                                <option value="1700">特慢</option>
                                                <option value="1900">极慢</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div style="width: 70px;">
                                        <a href="javascript:void(0);" onclick="pageData.fnReadPageWords();" class="btn btn-primary btn-sharp" title="朗读本页">
                                            <i class="fa fa-play"></i> 朗读
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 box-content" style="display: none">
                        <div class="panel panel-default btn-sharp">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <label for="sort_type">排序: </label>
                                            <select id="sort_type" class="form-control" onchange="pageData.fnSortWords( )">
                                                <option value="" >原始数据</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <label for="wordListKeyWord">搜索: </label>
                                            <input class="form-control" id="wordListKeyWord" type="text" placeholder="输入英文单词" maxlength="50" onkeydown="pageData.fnSearchKeyWord()" required/>
                                            <a href="javascript:pageData.fnSearchKeyWord()" class="btn btn-default">查找</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <input type="checkbox" onclick="Saurye.checkAll(this)" style="width: 15px;margin-top: 10px"><span> 全选</span>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <div class="form-group com-group-control-search">
                                            <label for="wordListPageLimit" style="width: 23%">每页: </label>
                                            <input class="form-control" id="wordListPageLimit" type="number" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                            <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <a href="<%=thisPage.spawnActionQuerySpell("wordList")+"&class_id=" + $_GSC.opt( "class_id" )%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllDef( this );" class="btn btn-info" style="border-radius: 0">隐藏释义</a>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllWordDetail( this );" class="btn btn-primary" style="border-radius: 0">展开详细</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="col-sm-12">
                        <div class="crisp-my-box">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplGlossaryWordList">
                                    <# var nEnum = 1;
                                    for( var en_word in wordList ) {
                                    var row     = wordList[en_word];
                                    var note    = row["g_note"]; #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px">
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<%=szWordQuerySpell%><#=en_word#>"><strong><#=en_word#></strong></a>
                                                        <a class="fa fa-volume-up" href="javascript:pageData.fnPlayWord( '<#=en_word#>' );"></a>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-7" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def"><#= $fnSubstr( row["defs"],0,45 )#></p>
                                                            <p onclick="pageData.fnShowCurrentDef( this )"
                                                               style="margin-top: -1%;display: none; cursor: pointer" class="p-g-w-def-mask"
                                                            >XXXXXX</p>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <p style="margin-top: -1%">
                                                                <span><i class="fa fa-trophy"></i> 词频：<#=row["freq"]<0 ? ">130k" : row["freq"]#> / 130K</span>
                                                                <span style="float: right"><i class="fa fa-clock-o"></i> <#=row["d_add_date"]#></span>
                                                            </p>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <# var szDetailID = "p-w-d-" + row['id'] + "-" + en_word; #>
                                                            <p style="margin-top: -2px"><a href="javascript:pageData.fnShowWordDetail( '<#=szDetailID#>' )"><i class="fa fa-angle-down" ></i> 详细</a></p>
                                                        </div>
                                                    </div>

                                                    <div class="p-w-details" style="display: none" id="<#=szDetailID#>" >
                                                        <hr style="margin-top: 0">
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <p style="margin-top: -1%"><i class="fa fa-sticky-note-o"></i> 笔记：<#=row["g_note"]#>
                                                                </p>
                                                            </div>
                                                            <div class="col-sm-6" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                                <p style="margin-top: -1%"><i class="fa fa-tag"></i> <span><#=row["band"]#></span></p>
                                                                <p style="margin-top: -1%"><i class="fa fa-line-chart"></i> 记忆统计：</p>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <p style="margin-top: -1%"><i class="fa fa-bookmark"></i>
                                                                    近义词：<span><#=row["d_similar_w"]#></span>
                                                                </p>
                                                                <p style="margin-top: -1%"><i class="fa fa-bookmark"></i>
                                                                    排序：<#=row["d_sort_id"]#>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <#}#>
                                </script>
                            </div>

                            <div class="col-sm-12 crisp-margin-ui-fault-tolerant-2">
                                <div class="crisp-paginate">
                                    <ul class="pagination"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="wordSystemList" style="display:none;" >
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="crisp-my-profile">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplSystemGlossaryProfile">
                                    <# var row = GlossaryProfile[0];
                                    var imgurl = row["g_img_href"];
                                    var class_id = row["classid"];

                                    #>
                                    <div class="col-md-3">
                                        <img  class="img-responsive crisp-limit-avatar" style="min-width: 200px; min-height: 200px;" src="<#=imgurl#>" alt="" onerror="this.src='/root/root/System/img/noimg.jpg'">
                                    </div>
                                    <div class="col-md-9">
                                        <h3 style="color: black; margin-top: 5px">
                                            <span style="font-weight:bold" ><#=row["g_name"]#></span>
                                            <a href="<%=thisPage.spawnActionQuerySpell("appendNewWord")%>#appendNewWord" data-toggle="modal" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-plus"></i>&nbsp;导入单词本</span>
                                            </a>
                                        </h3>
                                        <h5 style="color:#999">
                                            <i class="glyphicon glyphicon-user"></i>
                                            由 Predator官网 <#=row["g_create_data"]#> 创建
                                        </h5>
                                        <hr style="color: black;border-top:2px solid">
                                        <h4><i class="fa fa-tag"></i><label>标签：</label>
                                            <a href="" style="font-weight: bolder">暂无标签！</a>
                                        </h4>
                                        <h4><i class="fa fa-tag"></i><label>词数：</label> <span style="font-weight: bolder"><#=nWordSum#></span></h4>
                                        <h4><i class="fa fa-tag"></i><label>简介：</label>
                                            <#if( row["g_note"] ){#>
                                            <span style=" font-style:italic"><#=row["g_note"]#></span>
                                            <#}else{#>
                                            <span>该单词本很懒，没有留下简介！</span>
                                            <#}#>
                                        </h4>
                                    </div>
                                </script>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="crisp-my-box row">
                    <div class="col-md-12">
                        <div class="header-line predator-player-controller">
                            <div class="p-p-control">
                                <div class="p-pc-player" >
                                    <div class="p-pc-s-speed" >
                                        <div class="form-group com-group-control-search">
                                            <label for="seReadSpeed" style="width: 28%">速度: </label>
                                            <select id="seSystemReadSpeed" class="form-control">
                                                <option value="1000">中</option>
                                                <option value="1500">慢</option>
                                                <option value="700">快</option>
                                                <option value="1700">特慢</option>
                                                <option value="1900">极慢</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div style="width: 70px;">
                                        <a href="javascript:void(0);" onclick="pageData.fnReadPageWords();" class="btn btn-primary btn-sharp" title="朗读本页">
                                            <i class="fa fa-play"></i> 朗读
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="crisp-my-box">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplSystemGlossaryWordList">
                                    <# var nEnum = 1;
                                    for( var en_word in wordList ) {
                                    var row     = wordList[en_word];
                                    var note    = row["g_note"]; #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px">
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<%=szWordQuerySpell%><#=en_word#>"><strong><#=en_word#></strong></a>
                                                        <a class="fa fa-volume-up" href="javascript:pageData.fnPlayWord( '<#=en_word#>' );"></a>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-7" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def"><#= $fnSubstr( row["defs"],0,45 )#></p>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <p style="margin-top: -1%">
                                                                <span><i class="fa fa-trophy"></i> 词频：<#=row["freq"]<0 ? ">130k" : row["freq"]#> / 130K</span>
                                                                <span style="float: right"><i class="fa fa-clock-o"></i> <#=row["d_add_date"]#></span>
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <#}#>
                                </script>
                            </div>

                            <div class="col-sm-12 crisp-margin-ui-fault-tolerant-2">
                                <div class="crisp-paginate">
                                    <ul class="pagination"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

${StaticFooter}
<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/bootstrap.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/art-template.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script src="/root/root/System/elements/pamphlet/glossary.js"></script>
<script src="/root/assets/js/plugins/Chart.min.js"></script>
${SingleImgUploader}
<script>
    var pageData = ${szPageData};
    $_Predator( pageData, {
        "init": function ( parent ){

        },
        "genies": function( parent ){
            $_CPD({
                "mutualGlossaryList": {
                    title: "社区单词本列表",
                    fn: function( parent ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['PamphletList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderBuildList":function (self) {
                                self.genieData["PamphletList"] = pageData["PamphletList"];
                                self.renderById("tplGlossaryTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "g_name", "#gNameSearch", true );
                                };
                                pageData.fnSearchGlossaryAuthority = function () {
                                    Predator.searcher.bindSingleSearch( "g_authority", "#glossaryAuthority", true );
                                };
                                if( $_GET["g_word"] || $_GET["g_authority"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "systemGlossaryList": {
                    title: "系统单词本列表",
                    fn: function( parent ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['systemGlossaryList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderBuildList":function (self) {
                                self.genieData["PamphletList"] = pageData["systemGlossaryList"];
                                self.renderById("tplSystemGlossaryTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "g_name", "#gSystemNameSearch", true );
                                };
                                pageData.fnSearchGlossaryAuthority = function () {
                                    Predator.searcher.bindSingleSearch( "g_authority", "#glossaryAuthority", true );
                                };
                                if( $_GET["g_word"] || $_GET["g_authority"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "wordList": {
                    title: "单词本内容",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                Predator.wizard.conjurer.superBtn.summoned( parent.mDefaultChild );
                            },
                            "renderGlossary": function (self) {
                                self.genieData["GlossaryProfile"] = pageData["GlossaryProfile"];
                                self.genieData["nWordSum"       ] = pageData["nPageDataSum"];
                                self.genieData[ "bgReadonly" ]     = pageData["bgReadonly"];
                                self.renderById("tplGlossaryProfile");

                                $EP_Glossary.MagicSort.mountSelector( "#sort_type" );
                            },
                            "renderGlossaryContent":function (self) {
                                var hList = pageData[ "WordList" ];
                                if( hList.length > 0 ) {
                                    var sMap = $EP_Glossary.multipleWordsList2Map( hList );

                                    //console.log( sMap );
                                    self.genieData[ "class_id"]        = $_GET["classid"];
                                    self.genieData[ "wordList" ]       = sMap;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplGlossaryWordList");
                                }
                                else {
                                    $_PINE("#tplGlossaryWordList").parent().html(
                                        "<div class=\"table-responsive\">" +
                                        "<table class=\"table table-striped table-bordered table-hover crisp-picture-table\"><tbody><tr><td>暂无数据</td></tr></tbody></table>" +
                                        "</div>" )
                                }
                            },
                            "afterWordListRendered" : function ( self ) {
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                                Predator.elements.pamphlet.glossary.registerWordListAction( pageData, self );
                                Predator.smartMassDeleteListener( "wordMassDelete" );
                            }
                        });
                    }
                },

                "wordSystemList": {
                    title: "单词本内容",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                Predator.wizard.conjurer.superBtn.summoned( parent.mDefaultChild );
                            },
                            "renderGlossary": function (self) {
                                self.genieData["GlossaryProfile"] = pageData["GlossaryProfile"];
                                self.genieData["nWordSum"       ] = pageData["nPageDataSum"];
                                self.renderById("tplSystemGlossaryProfile");
                            },
                            "renderGlossaryContent":function (self) {
                                var hList = pageData[ "GlossaryWordList" ];
                                if( hList.length > 0 ) {
                                    var sMap = {};
                                    for ( var i = 0; i < hList.length; i++ ) {
                                        var row = hList[i];
                                        var szWord = row["en_word"];
                                        var szCnD  = row["cn_means"];
                                        var nCoca  = row["coca_rank"] ? row["coca_rank"] : 1e8;
                                        sMap[ szWord ] = pPine.Objects.affirmObject( sMap[ szWord ] );
                                        if( sMap[ szWord ][ "freq" ] === undefined ){
                                            sMap[ szWord ][ "freq" ] = nCoca;
                                        }
                                        else {
                                            sMap[ szWord ][ "freq" ] = Math.min( sMap[ szWord ][ "freq" ], nCoca );
                                        }
                                        sMap[ szWord ][ "band"    ] = Predator.jsonWordDatumCoding.bandWordDecode( row["w_level"], ',' );
                                        pPine.Objects.merge( sMap[ szWord ], row, [ "id","g_note","w_level" ] );

                                        var szCnKey = row[ "m_property" ] + ". " + szCnD;
                                        sMap[ szWord ][ "defs" ]            = pPine.Objects.affirmObject( sMap[ szWord ][ "defs" ]  );
                                        sMap[ szWord ][ "defs" ][ szCnKey ] = pPine.Objects.affirmObject( sMap[ szWord ][ "defs" ][ szCnKey ] );
                                    }

                                    for( var k in sMap ){
                                        if( sMap.hasOwnProperty( k ) ){
                                            var each = sMap[ k ][ "defs" ];
                                            var szCnDef = "";
                                            var nSize   = sizeof( each );
                                            var i = 0;
                                            for( var szCn in each ){
                                                szCnDef += szCn;
                                                if( ++i !== nSize ){
                                                    szCnDef += ';';
                                                }
                                            }
                                            sMap[ k ][ "defs" ] = szCnDef;
                                        }
                                    }

                                    //console.log( sMap );
                                    self.genieData[ "class_id"]        = $_GET["classid"];
                                    self.genieData[ "wordList" ]       = sMap;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplSystemGlossaryWordList");
                                }
                                else {
                                    $_PINE("#tplGlossaryWordList").parent().html(
                                        "<div class=\"table-responsive\">" +
                                        "<table class=\"table table-striped table-bordered table-hover crisp-picture-table\"><tbody><tr><td>暂无数据</td></tr></tbody></table>" +
                                        "</div>" )
                                }
                            },
                            "afterWordListRendered" : function ( self ) {
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                                pageData.fnPlayWord = function ( s ){
                                    return Predator.vocabulary.phonetic.audioPlay( s, 1 );
                                };
                                pageData.fnReadPageWords = function(){
                                    if( self.genieData.threadFnReadPageWords ){
                                        window.clearInterval( self.genieData.threadFnReadPageWords );
                                    }
                                    var adWords = [], iW = 0;
                                    for( var word in self.genieData[ "wordList" ] ){
                                        if( self.genieData[ "wordList" ].hasOwnProperty( word ) ){
                                            adWords.push( Predator.vocabulary.phonetic.getAudio( word, 1 ) );
                                        }
                                    }
                                    var nSpeed = parseInt( $_PINE("#seSystemReadSpeed").val() );
                                    self.genieData.threadFnReadPageWords = setInterval(function(){
                                        if( iW < adWords.length ){
                                            var audio = adWords[iW++] ;
                                            audio.play();
                                        }
                                        else {
                                            window.clearInterval( self.genieData.threadFnReadPageWords );
                                        }
                                    }, nSpeed );
                                };
                            }
                        });
                    }
                },

            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );

                        pageData.fnSearchKeyWord = function () {
                            Predator.searcher.bindSingleSearch( "en_word", "#"+ who +"KeyWord", true );
                        };
                        pageData.fnSetPageLimit = function () {
                            Predator.searcher.bindSingleSearch( "pageLimit", "#"+ who +"PageLimit", true );
                        };
                    }
                };
            }).summon(Predator.getAction());
        },
        "final":function( parent ){
            Predator.page.surveyQueryStrAndBind({
                "pageLimit"   : [ "#wordListPageLimit","#mutualGlossaryListPageLimit","#systemGlossaryListPageLimit","#wordSystemListPageLimit"],
                "en_word"     : [ "#wordListKeyWord" ],
                "sort_type"   : [ "#sort_type" ],
                "g_word"      : [ "#gNameSearch", "#gcNameSearch" ,"#gSystemNameSearch"],
                "g_authority" : [ "#glossaryAuthority" ],
                "g_c_type"    : [ "#cGlossaryType" ]
            });
        }
    });


</script>
${StaticPageEnd}