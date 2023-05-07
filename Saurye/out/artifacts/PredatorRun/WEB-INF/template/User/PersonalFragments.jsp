<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC = thisPage.$_GSC();
    JSONObject proto = thisPage.getModularConfig();
    String szWordQuerySpell = thisPage.querySpell().queryWord("");
    boolean bReadonly       = thisPage.getPageData().optBoolean( "bgReadonly" );
    boolean bHistoryMode    = thisPage.getPageData().optBoolean( "bgHistoryMode" );
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
            <div class="col-sm-2" >
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
                                    <div id="glossaryListIndexLabel" class="content" style="font-size: 140%">我的词本</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn green-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell( "glossaryCollection" )%>">
                                    <div class="header">
                                        <i class="fa fa-folder"></i>
                                    </div>
                                    <div id="glossaryCollectionIndexLabel"  class="content" style="font-size: 140%">我的收藏</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell("overallAnalysis")%>">
                                    <div class="header">
                                        <i class="fa fa-flask"></i>
                                    </div>
                                    <div id="overallAnalysisIndexLabel" class="content" style="font-size: 140%">综合分析</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="glossaryList" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>我创建的词根本</span>
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
                            var imgurl  = row["ph_img_href"];
                            var ph_name  = row["ph_name"];
                            #>
                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("rootList")%>&class_id=<#=classid#> ">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="<#=imgurl#>" onerror="this.src='/root/root/System/img/noimg.jpg'" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-user p-g-used-time" title="使用次数"></a>
                                            <span style="margin-top: 5%"><#=row["ph_c_usage"]#></span>
                                            <a class="glyphicon glyphicon-trash p-g-purge" data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#modalDeleteOne<#=classid#>"></a>
                                            <div class="modal fade crisp-union-win" id="modalDeleteOne<#=classid#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            <h4 class="modal-title" style="color:black" >Waring</h4>
                                                        </div>
                                                        <div class="modal-body" style="color: black"><h3>您确实要删除词根本 <#=ph_name#> 吗?</h3></div>
                                                        <div class="modal-footer">
                                                            <a href="<%=thisPage.spawnControlQuerySpell("deleteOneGlossary")%>&classid=<#=classid#>"><button class="btn btn-danger">确定</button></a>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-glossary-title">
                                            <a><#=ph_name#></a>
                                        </div>
                                    </div>
                                </div>
                            </a>

                            <#}#>

                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("appendNewGlossary")%>">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="/root/assets/img/icon-plus.jpg" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-plus p-g-used-time"></a>
                                            <span style="margin-top: 5%">添加词根本</span>
                                        </div>
                                        <div class="p-glossary-title">
                                            <span class="nb" style="margin-left: 30%"><i class="fa fa-plus"></i>添加词根本</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </script>
                    </div>

                    <div class="row crisp-my-box">
                        <div class="col-sm-4 ">
                            <div class="form-group com-group-control-search">
                                <label for="glossaryListPageLimit" style="width: 23%">每页: </label>
                                <input class="form-control" id="glossaryListPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
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

            <div class="col-sm-10" id="glossaryCollection" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>我收藏的词根本</span>
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
                                    <div class="col-sm-12">
                                        <div class="form-group com-group-control-search">
                                            <label for="gcNameSearch" style="width: 25%">名称</label>
                                            <input id="gcNameSearch" class="form-control"  type='text' style="width: 52%;display:inline;" onchange="pageData.fnSearchGlossaryName()"/>
                                            <a style="float: right;width: 21%;border-radius: 0;" href="#" class="btn btn-default" onclick="pageData.fnSearchGlossaryName()">查找</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="crisp-my-box">
                    <div class="row predator-glossary-box" >
                        <script type="text/html" id = "tplGlossaryCollectTable">
                            <# for( var i in collectedPamphletList ) {
                            var row     = collectedPamphletList[i];
                            var classid = row["classid"];
                            var imgurl  = row["ph_img_href"];
                            var ph_name  = row["ph_name"];
                            #>
                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("rootList")%>&class_id=<#=classid#>">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="<#=imgurl#>" onerror="this.src='/root/root/System/img/noimg.jpg'" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-user p-g-used-time" title="使用次数"></a>
                                            <span style="margin-top: 5%"><#=row["ph_c_usage"]#></span>
                                            <a class="glyphicon glyphicon-trash p-g-purge" data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#modalAbortCollect<#=classid#>"></a>
                                            <div class="modal fade crisp-union-win" id="modalAbortCollect<#=classid#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                            <h4 class="modal-title" style="color:black" >Waring</h4>
                                                        </div>
                                                        <div class="modal-body" style="color: black"><h3>您确定要取消收藏词根本 <#=f_name#> 吗?</h3></div>
                                                        <div class="modal-footer">
                                                            <a href="<%=thisPage.spawnControlQuerySpell("abortOneCollection")%>&classid=<#=classid#>"><button class="btn btn-danger">确定</button></a>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="p-glossary-title">
                                            <a><#=ph_name#></a>
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
                                <label for="glossaryListPageLimit" style="width: 23%">每页: </label>
                                <input class="form-control" id="glossaryCollectionPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
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

            <div class="col-sm-10" id="rootList" style="display:none;" >
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="crisp-my-profile">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplGlossaryProfile">
                                    <# var row = GlossaryProfile[0];
                                    var imgurl = row["ph_img_href"];
                                    var class_id = row["classid"];

                                    #>
                                    <div class="col-md-3">
                                        <img id="user-index-avatar" class="img-responsive crisp-limit-avatar" style="min-width: 200px; min-height: 200px;" src="<#=imgurl#>" alt="" onerror="this.src='/root/root/System/img/noimg.jpg'">
                                    </div>
                                    <div class="col-md-9">
                                        <h3 style="color: black; margin-top: 5px">
                                            <span style="font-weight:bold" ><#=row["ph_name"]#></span>
                                            <#if( !bReadonly ) { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("editGlossary")%>&class_id=<#=class_id#>">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="<%=thisPage.spawnActionQuerySpell("appendNewRoot")%>#appendNewRoot" data-toggle="modal" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-plus"></i>&nbsp;词根</span>
                                            </a>
                                            <#} else { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("glossaryClone")+"&class_id="+$_GSC.optString( "class_id" )%>"
                                               style="font-weight: bolder"><span style="float: right;font-size: 80%"><i class="fa fa-copy"></i>&nbsp;克隆</span>
                                            </a>
                                            <#}#>
                                        </h3>
                                        <h5 style="color:#999">
                                            <i class="glyphicon glyphicon-user"></i>
                                            由 <#=row["username"]#> <#=row["ph_create_data"]#> 创建
                                        </h5>
                                        <hr style="color: black;border-top:2px solid">
                                        <h4><i class="fa fa-tag"></i><label>标签：</label>
                                            <#if( !bReadonly ) { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("editGlossary")%>&class_id=<#=class_id#>" style="font-weight: bolder">添加标签</a>
                                            <#} else { #> 暂无标签 <#}#>
                                        </h4>
                                        <h4><i class="fa fa-tag"></i><label>词数：</label> <span style="font-weight: bolder"><#=nWordSum#></span></h4>
                                        <h4><i class="fa fa-tag"></i><label>简介：</label>
                                            <#if( row["ph_note"] ){#>
                                            <span style=" font-style:italic"><#=row["ph_note"]#></span>
                                            <#}else{
                                            if( !bReadonly ) { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("editGlossary")%>&class_id=<#=class_id#>" style="font-weight: bolder">添加简介</a>
                                            <#} else { #> 暂无简介 <#} } #>
                                        </h4>

                                        <% if( !bReadonly ) { // For safe %>
                                        <div class="modal fade" id="appendNewRoot" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 6%">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title" id="myModalLabel">添加词根</h4>
                                                    </div>
                                                    <form name="appendNewWord" id="appendNewWordForm" method="POST" action="<%=thisPage.spawnControlQuerySpell("appendNewRoot")%>">
                                                        <input id="classid" name="classid" type="text" value="<#=class_id#>" hidden/>
                                                        <div class="modal-body">
                                                            <div class="form-group com-group-control">
                                                                <div class="form-group com-group-control">
                                                                    <label style="margin-left: 0">词根: </label>
                                                                    <textarea name="en_root" class="form-control" style="width: 83%;height: 150px;" ></textarea>
                                                                    <p class="help-block">温馨：用 ',' 空格或回车分割可以批量添加哦！</p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <input type="submit" class="btn btn-primary" style="width: 15%" value="添加">
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <%} %>

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
                        </div>
                    </div>
                    <div class="col-md-12 box-content " id="wordListSearcher" >
                        <div class="panel panel-default btn-sharp">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group com-group-control-search">
                                            <% if ( !bReadonly ){ %>
                                            <label for="sort_type" style="width: 23%">排序: </label>
                                            <select id="sort_type" style="width: 55%" class="form-control" onchange="pageData.fnSortWords( )">
                                                    <% } else { %>
                                                <label for="sort_type" style="width: 23%">排序: </label>
                                                <select id="sort_type" class="form-control" style="width: 76%" onchange="pageData.fnSortWords( )">
                                                    <% } %>
                                                    <option value="" >原始数据</option>
                                                    <option value="0">随机排序</option>
                                                    <option value="1">字典排序</option>
                                                    <option value="2">词长排序</option>
                                                    <option value="3">词频排序</option>
                                                    <option value="4">添加顺序</option>
                                                </select>
                                                    <% if ( !bReadonly && !bHistoryMode ){ %>
                                                <a href="javascript:pageData.fnSaveSortedList()" class="btn btn-primary btn btn-default" style="width: 20%"> 应用 </a>
                                                    <% } %>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="form-group com-group-control-search">
                                            <label for="wordListKeyWord">搜索: </label>
                                            <input class="form-control" id="rootListKeyWord" type="text" placeholder="输入英文单词" maxlength="50" onkeydown="pageData.fnSearchKeyWord()" required/>
                                            <a href="javascript:pageData.fnSearchKeyWord()" class="btn btn-default">查找</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <% if ( !bReadonly ){ %>
                                    <div class="col-sm-1">
                                        <div class="form-group">
                                            <input type="checkbox" onclick="Saurye.checkAll(this)" style="width: 15px;margin-top: 10px"><span> 全选</span>
                                        </div>
                                    </div>
                                    <% } %>
                                    <div class="col-sm-<%=bReadonly? 6 : 5%>">
                                        <div class="form-group com-group-control-search">
                                            <label for="rootListPageLimit" style="width: 23%">每页: </label>
                                            <input class="form-control" id="rootListPageLimit" type="number" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                            <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <% if ( !bReadonly ){ %>
                                        <a href="javascript:void(0);" class="btn btn-danger" id="<%=bHistoryMode?"history": "word"%>MassDelete" style="border-radius: 0">批量删除</a>
                                        <%} else { %>
                                        <a href="<%=thisPage.spawnActionQuerySpell("wordsHistory")%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                        <a href="javascript:void(0);" onclick="" class="btn btn-info" style="border-radius: 0" title="批量添加到单词本">批量添加</a>
                                        <%} %>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllWordDetail( this );" class="btn btn-info" style="border-radius: 0">展开详细</a>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllDef( this );" class="btn btn-primary" style="border-radius: 0">隐藏释义</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="crisp-my-box">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplGlossaryRootList">
                                    <# var nEnum = 1;
                                    for( var k in rootList ) {
                                    var row     = rootList[k];
                                    var note    = row["g_note"];
                                    var en_root = row["en_fragment"];
                                    #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <# if (!bReadonly) { #> <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px"> <#} #>
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<%=szWordQuerySpell%><#=en_root#>"><strong><#=en_root#></strong></a>
                                                        <# if (!bReadonly) { #>
                                                        <a class="btn btn-primary btn-sharp" style="float: right;margin-left: 1%" data-toggle="modal" href="#modalDeleteOne<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                        <#} #>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-7" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def"><#= $fnSubstr( row["cn_means"],0,45 )#></p>
                                                            <p onclick="pageData.fnShowCurrentDef( this )"
                                                               style="margin-top: -1%;display: none; cursor: pointer" class="p-g-w-def-mask"
                                                            >XXXXXX</p>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <p style="margin-top: -1%">
                                                                <span><i class="fa fa-trophy"></i> 词族：<#=row["f_clan_name"]#></span>
                                                                <span style="float: right"><i class="fa fa-clock-o"></i> <#=row["d_add_date"]#></span>
                                                            </p>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <# var szDetailID = "p-w-d-" + row['id'] + "-" + en_root; #>
                                                            <p style="margin-top: -2px"><a href="javascript:pageData.fnShowWordDetail( '<#=szDetailID#>' )"><i class="fa fa-angle-down" ></i> 详细</a></p>
                                                        </div>
                                                    </div>

                                                    <div class="p-w-details" style="display: none" id="<#=szDetailID#>" >
                                                        <hr style="margin-top: 0">
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <p style="margin-top: -1%"><i class="fa fa-sticky-note-o"></i> 笔记：<#=row["g_note"]#>
                                                                    <# if (!bReadonly) { #>
                                                                    <a data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#wordProfileEditor<#=en_word#>"><i class="fa fa-edit"></i></a>
                                                                    <#}#>
                                                                </p>
                                                            </div>
                                                            <div class="col-sm-6" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                                <p style="margin-top: -1%"><i class="fa fa-tag"></i> <span>例词：<#=row["w_epitome"]#></span></p>
                                                                <p style="margin-top: -1%"><i class="fa fa-line-chart"></i> 记忆统计：</p>
                                                            </div>
                                                            <div class="col-sm-6">
                                                                <p style="margin-top: -1%"><i class="fa fa-bookmark"></i>
                                                                    排序：<#=row["d_sort_id"]#>
                                                                    <# if (!bReadonly) { #>
                                                                    <a data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#wordProfileEditor<#=en_word#>"><i class="fa fa-edit"></i></a>
                                                                    <#}#>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% if( !bReadonly ){ %>
                                                    <div class="modal fade crisp-union-win" id="modalDeleteOne<#=row['id']#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title" >是否删除</h4>
                                                                </div>
                                                                <div class="modal-body"><h4>您确实要删除该词根 "<#=en_fragment#>" 吗?</h4></div>
                                                                <div class="modal-footer">
                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteOneRoot")%>&id=<#=row['id']#>"><button class="btn btn-danger">确定</button></a>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%} %>
                                                </div>
                                            </div>


                                        </div>
                                        <% if( !bReadonly ){ %>
                                        <div class="modal fade" id="wordProfileEditor<#=en_word#>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 6%">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title" id="editNoteLabel">编辑词根</h4>
                                                    </div>
                                                    <form name="editNote" id="editNoteForm" method="POST" action="<%=thisPage.spawnControlQuerySpell("editWordProfile")%>">
                                                        <input name="id" type="hidden" value="<#=row['id']#>" />
                                                        <div class="modal-body">
                                                            <div class="form-group com-group-control-relate">
                                                                <label style="width: 20%">排序: </label>
                                                                <input class="form-control" name="d_sort_id" type="number" value="<#=row['d_sort_id']#>" style="width: 80%;display:inline" required />
                                                            </div>
                                                            <div class="form-group com-group-control-relate">
                                                                <label for="noteModify" style="width: 20%" >笔记内容: </label>
                                                                <textarea id="noteModify" name="g_note" class="form-control" style="width: 80%;height: 150px;" placeholder="<#=note#>"><#=note#></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                                            <button type="submit" class="btn btn-primary" style="width: 15%">保存</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <%} %>
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

            <div class="col-sm-10" id="appendNewGlossary" style="display:none;">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-edit"></i><span> 新建单词本</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="appendNewGlossary" method="post" action="<%=thisPage.spawnActionControlSpell( "appendNewGlossary", "appendNewGlossary" )%>" enctype="multipart/form-data">
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">词根本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_name" type="text" placeholder="请输入单词本名称" style="width: 80%;display:inline" required>
                                        </div>
                                        <div class="form-group com-group-control-relate">
                                            <label style="height: 150px;width:20%;text-align: center">备注: </label>
                                            <textarea id="ph_note" name="ph_note" class="form-control" style="width: 80%;height: 150px;"></textarea>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group com-group-control-relate">
                                                    <label style="width: 20%">状态: </label>
                                                    <select id="ph_authority" name="ph_authority" class="form-control" style="width: 80%">
                                                        <option value="public" selected>公开</option>
                                                        <option value="private">私有</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group com-group-control" id="newPamphletCoverField">
                                            <label  style="margin-right: 1%;width: 20%">封面: </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: right">
                                    <button id="sendbtn" class='btn btn-primary' type='submit'>
                                        <i class='fa fa-save'></i> 添加
                                    </button>
                                    <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="editGlossary" style="display:none;" >
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-edit"></i><span> 编辑词根本</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" >
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="editGlossary" method="post" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("editGlossary" )%>" enctype="multipart/form-data" >
                                <input class="form-control" name="classid" id="classidModify" type="hidden" />
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">词根本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_nameModify" type="text" placeholder="请输入单词本名称" style="width: 80%;display:inline" required>
                                        </div>
                                        <div class="form-group com-group-control-relate">
                                            <label style="height: 150px;width:20%;text-align: center">备注: </label>
                                            <textarea id="ph_noteModify" name="ph_note" class="form-control" style="width: 80%;height: 150px;"></textarea>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group com-group-control-relate">
                                                    <label style="width: 20%">状态: </label>
                                                    <select id="f_authorityModify" name="ph_authority" class="form-control" style="width: 80%">
                                                        <option value="public">公开</option>
                                                        <option value="private">私有</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group com-group-control" id="glossaryCoverField">
                                            <label  style="margin-right: 1%;width: 20%">封面: </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: right">
                                    <button id="e_sendbtn" class='btn btn-primary' type='submit'>
                                        <i class='fa fa-save'></i> 保存
                                    </button>
                                    <a href="<%=thisPage.spawnActionQuerySpell("wordList") + "&class_id=" + $_GSC.optString( "class_id" ) %>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="glossaryClone" style="display:none;" >
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-copy"></i><span> 欢迎使用词根本克隆向导</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" >
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="editGlossary" method="post" action="<%=PredatorProto.mySoul(request).spawnControlQuerySpell("cloneGlossary" )%>" enctype="multipart/form-data" >
                                <input class="form-control" name="usernameProto" id="usernameClone" type="hidden" />
                                <input class="form-control" name="classid" id="classidClone" type="hidden" />
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">词根本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_nameClone" type="text" placeholder="请输入单词本名称" style="width: 80%;display:inline" required>
                                        </div>
                                        <div class="form-group com-group-control-relate">
                                            <label style="height: 150px;width:20%;text-align: center">备注: </label>
                                            <textarea id="ph_noteClone" name="ph_note" class="form-control" style="width: 80%;height: 150px;"></textarea>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group com-group-control-relate">
                                                    <label style="width: 20%">状态: </label>
                                                    <select id="ph_authorityClone" name="ph_authority" class="form-control" style="width: 80%">
                                                        <option value="public">公开</option>
                                                        <option value="private">私有</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group com-group-control" id="pamphletCloneCoverField">
                                            <label  style="margin-right: 1%;width: 20%">封面: </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: right">
                                    <button class='btn btn-primary' type='submit'>
                                        <i class='fa fa-save'></i> 保存
                                    </button>
                                    <a href="<%=thisPage.spawnActionQuerySpell("wordList") + "&class_id=" + $_GSC.optString( "class_id" ) %>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-10" id="overallAnalysis" style="display:none;" >
                <div id="learnIndex">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%"><i class="fa fa-pie-chart"></i> <span>单词本统计</span></h4>
                        </div>
                    </div>

                    <div class="row box-content">
                        <div class="col-sm-6">
                            <div id="pieChartContainerWordSum" style="border: 1px solid #428bca;text-align: center">
                                <canvas class="chartjs-render-monitor" width="200" height="200">
                                </canvas>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="table-responsive" id="glossaryWordPoSList" >
                                <table class="table table-hover table-bordered">
                                    <tbody>
                                    <tr>
                                        <td>单词总量：</td>
                                        <td><span id="GlossaryWordSum">0</span></td>
                                        <td>其他 other.：</td>
                                        <td><span id="gwPoS_other">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>名词 n.：</td>
                                        <td><span id="gwPoS_n">0</span></td>
                                        <td>动词 v.：</td>
                                        <td><span id="gwPoS_v">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>形容词 adj.：</td>
                                        <td><span id="gwPoS_adj">0</span></td>
                                        <td>副词 adv.：</td>
                                        <td><span id="gwPoS_adv">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>及物动词 vt.：</td>
                                        <td><span id="gwPoS_vt">0</span></td>
                                        <td>不及物动词 vi.：</td>
                                        <td><span id="gwPoS_vi">0</span></td>
                                    </tr>
                                    <tr>
                                        <td>代名词 pron.：</td>
                                        <td><span id="gwPoS_pron">0</span></td>
                                        <td>连接词 conj.：</td>
                                        <td><span id="gwPoS_conj">0</span></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-md-6"  style="text-align: center">
                            <span>单词本单词数量统计</span>
                            <div class="" style="border: 1px solid #428bca; text-align: center" >
                                <canvas id="chartGlossaryWordSum"></canvas>
                            </div>
                        </div>
                        <div class="col-sm-6" style="text-align: center">
                            <span>单词学习曲线</span>
                            <div style="border: 1px solid #428bca;">
                                <canvas id="StudyRate"></canvas>
                            </div>
                        </div>

                        <!--<div class="col-sm-6" style="text-align: center">
                            <span>单词本相似度</span>
                            <div id="pieChartContainerCompare" style="border: 1px solid #428bca;text-align: center">
                                <canvas class="chartjs-render-monitor" width="200" height="200">
                                </canvas>
                            </div>
                        </div>-->

                    </div>
                </div>
                <div class="modal fade" id="CompareBuild" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 6%">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title">单词本分析</h4>
                            </div>
                            <form name="CompareTo" method="POST" action="<%=thisPage.spawnActionControlSpell("overallAnalysis","BuildCompare")%>">
                                <input id="class_id" name="class_id" type="text" value="" hidden/>
                                <div class="modal-body">
                                    <div class="form-group com-group-control">
                                        <label>单词本A名: </label>
                                        <input id="BuildA" name="BuildA" class="form-control" type="text" value="" placeholder="输入单词本" required>
                                    </div>
                                    <div class="form-group com-group-control">
                                        <label>单词本B名: </label>
                                        <input id="BuildB" name="BuildB" class="form-control" type="text" value="" placeholder="输入单词本" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    <input type="submit" class="btn btn-primary" style="width: 15%" value="比较">
                                </div>
                            </form>
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
        "init"   : function ( parent ){
            Predator.page.surveyQueryStrAndBind({
                "pageLimit"   : [ "#rootListPageLimit","#mutualGlossaryListPageLimit","#systemGlossaryListPageLimit","#wordSystemListPageLimit"],
                "en_word"     : [ "#wordListKeyWord" ],
                "sort_type"   : [ "#sort_type" ],
                "g_name"      : [ "#gNameSearch", "#gcNameSearch" ,"#gSystemNameSearch"],
                "g_authority" : [ "#glossaryAuthority" ],
                "g_c_type"    : [ "#cGlossaryType" ]
            });
        },
        "genies" : function( parent ){
            $_CPD({
                "glossaryList"       : {
                    title: "词根本列表",
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
                                    Predator.searcher.bindSingleSearch( "ph_name", "#gNameSearch", true );
                                };
                                pageData.fnSearchGlossaryAuthority = function () {
                                    Predator.searcher.bindSingleSearch( "ph_authority", "#glossaryAuthority", true );
                                };
                                if( $_GET["f_name"] || $_GET["f_authority"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "rootList"           : {
                    title: "词根本内容",
                    fn: function ( parent ) {
                        var bReadonly = pageData["bgReadonly"];
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                Predator.wizard.conjurer.superBtn.summoned( bReadonly ? "glossaryCollection" : parent.mDefaultChild );
                                self.genieData["bReadonly"      ] = bReadonly;
                            },
                            "renderGlossary": function (self) {
                                self.genieData["GlossaryProfile"] = pageData["GlossaryProfile"];
                                self.genieData["nWordSum"       ] = pageData["nPageDataSum"];
                                self.renderById("tplGlossaryProfile");
                            },
                            "renderGlossaryContent": function (self) {
                                var hList = pageData[ "GlossaryRootList" ];
                                if( hList.length > 0 ) {
                                    self.genieData["rootList"] = hList;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplGlossaryRootList");
                                }
                                else {
                                    $_PINE("#tplGlossaryRootList").parent().html( Predator.tpl.notice.simpleNoData );
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

                "glossaryCollection" : {
                    title: "我的收藏",
                    fn: function( parent ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['collectedPamphletList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderBuildList":function (self) {
                                self.genieData["collectedPamphletList"] = pageData["collectedPamphletList"];
                                self.renderById("tplGlossaryCollectTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "ph_name", "#gcNameSearch", true );
                                };
                                if( $_GET["ph_name"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "appendNewGlossary"  : {
                    title: "新建单词本",
                    fn: function () {
                        $_PINE("#newPamphletCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                    }
                },

                "editGlossary"       : {
                    title:"修改单词本",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init":function (self) {
                                if( pageData['oldGlossaryProfile'] ){
                                    $_PINE("#glossaryCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                                    $_PMVC.formDynamicRenderer( pageData[ 'oldGlossaryProfile' ], "Modify", null );
                                }
                            }
                        });
                    }
                },

                "glossaryClone"      : {
                    title: "单词本克隆",
                    fn: function () {
                        Predator.wizard.smartGenieInstance(this, {
                            "init":function (self) {
                                if( pageData['oldGlossaryProfile'] ){
                                    var buildData = pageData[ 'oldGlossaryProfile' ];
                                    $_PINE("#pamphletCloneCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                                    $_PMVC.formDynamicRenderer( buildData, "Clone", null );
                                }
                            }
                        });
                    }
                },

                "overallAnalysis"    : {
                    title: "单词本综合分析",
                    fn   : function (parent) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function ( self ) {
                                if( !$isTrue( pageData[ 'glossaryWordEachSum' ] ) ){
                                    $_PINE("#overallAnalysis .box-content").parent().html( Predator.tpl.notice.simpleNoData  );
                                    return false;
                                }
                            },
                            "renderWordEachSum": function ( self ) {
                                var hEachWords       = pageData[ 'glossaryWordEachSum' ];
                                var hEachWordsRender = [];
                                for( var i = 0; i < hEachWords.length; i++ ){
                                    hEachWordsRender[i] = [ hEachWords[i]['g_name'], hEachWords[i]['nCount'], Pinecone.Random.nextColor() ];
                                }
                                Predator.chart.mountDefaultBar( "#chartGlossaryWordSum","单词本单词数量统计", 480, hEachWordsRender );
                            },
                            "renderWordPoS": function ( self ) {
                                var hWordPoS = pageData[ 'glossaryWordPoS' ];
                                var hColors  = {
                                    "n"    : "#A8D582", "adj" : "#F7604D", "adv" : "#00ACEC", "v"   : "#DB9C3F", "vt"   : "#77ecd5",
                                    "vi"   : "#f8f8a7", "pron": "#3889FC", "prep": "#a898d7", "conj": "#9D66CC", "int"  : "#ec4e6c",
                                    "abbr" : "#D7D768", "aux" : "#4ED6B8", "art" : "#f8a326", "num" : "#d66122", "other": "#ec5618",
                                };
                                var commonPoS = { "n": 1, "adj": 1, "adv": 1, "v": 1, 'vt': 1, 'vi': 1, 'pron': 1, 'conj': 1 };
                                if( $isTrue( hWordPoS ) ){
                                    var hRender = [];
                                    var nOther  = 0;
                                    for ( var i = 0; i < hWordPoS.length; i++ ) {
                                        var row    = hWordPoS[ i ];
                                        var szPoS  = row[ "m_property" ];
                                        var nPoS   = row[ "nCount" ];
                                        if( commonPoS[ szPoS ] ){
                                            $_PINE( "#gwPoS_" + szPoS ).text( nPoS );
                                        }else {
                                            nOther += nPoS;
                                        }
                                        hRender[ i ] = [ szPoS, nPoS, hColors[ szPoS ] ];
                                    }
                                    $_PINE( "#gwPoS_other" ).text( nOther );
                                    Predator.chart.mountDefaultPie("#pieChartContainerWordSum", $("#glossaryWordPoSList").height(), hRender );
                                }
                                $_PINE( "#GlossaryWordSum" ).text( pageData[ "glossaryWordSum" ] );
                            },
                            "hold": function ( self ) {
                                Predator.chart.mountDefaultLine("#overallAnalysis #StudyRate",["1月3日","1月4日" ,"1月5日","1月6日" ,"1月7日" ],
                                    [["学习单词",[3, 2, 4, 18, 30],"rgb(75, 192, 192)"],
                                        ["复习单词",[1.3, 0.9, 1.5, 2.4, 3.5],"rgba(255,99,132,1)"],
                                        ["遗忘单词",[0.0, 0.1,0.6, 0.9, 1.4],"#3889FC"]]);
                                //Saurye.chart.mountDefaultPie("#pieChartContainerCompare",186,[["相似度",pageData['Result'],"#A8D582"],["不相似度",100-pageData['Result'],"#4ED688"]])
                            }
                        });
                    }
                },

            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );

                        if( who === 'wordsHistory' ){
                            who = "wordList";
                        }
                        $_PINE( "#band_type" ).append( Predator.vocabulary.band.assembleSelector() );
                        pageData.fnSearchKeyWord = function () {
                            Predator.searcher.bindSingleSearch( "en_root", "#"+ who +"KeyWord", true );
                        };
                        pageData.fnSetPageLimit = function () {
                            Predator.searcher.bindSingleSearch( "pageLimit", "#"+ who +"PageLimit", true );
                        };
                        pageData.fnSiftBand = function(){
                            Predator.searcher.bindSingleSearch( "band_type", "#band_type", true );
                        };
                    }
                };
            }).summon(Predator.getAction());
        },
        "final"  : function( parent ){
            Predator.page.surveyQueryStrAndBind({
                "pageLimit"   : [ "#wordListPageLimit","#glossaryListPageLimit", "#wordsRankPageLimit" ],
                "en_word"     : [ "#wordListKeyWord", "#wordsRankKeyWord" ],
                "sort_type"   : [ "#sort_type" ],
                "g_word"      : [ "#gNameSearch", "#gcNameSearch" ],
                "g_authority" : [ "#glossaryAuthority" ],
                "g_c_type"    : [ "#cGlossaryType" ],
                "band_type"   : [ "#band_type" ]
            });
        }
    });

</script>
${StaticPageEnd}