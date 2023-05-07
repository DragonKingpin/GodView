<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC        = thisPage.$_GSC();
    JSONObject proto        = thisPage.getModularConfig();
    String szWordQuerySpell = thisPage.querySpell().queryWord("");
    boolean bReadonly       = thisPage.getPageData().optBoolean( "bgReadonly" );
    boolean bHistoryMode    = thisPage.getPageData().optBoolean( "bgHistoryMode" );
    boolean bIsReciting     = thisPage.getPageData().optBoolean( "bIsReciting");
%>
${StaticHead}
<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label>魔法单词本</label> >> <label id="pageNodeTitle"></label>
                    <span id="head-line" style="float: right"></span>
                </h4>
            </div>
        </div>

        <div class="row"  >
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
                                    <div id="pamphletListIndexLabel" class="content" style="font-size: 140%">我的词本</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn green-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell( "pamphletCollection" )%>">
                                    <div class="header">
                                        <i class="fa fa-folder"></i>
                                    </div>
                                    <div id="pamphletCollectionIndexLabel"  class="content" style="font-size: 140%">我的收藏</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell("megaPamphlet")%>">
                                    <div class="header">
                                        <i class="fa fa-flask"></i>
                                    </div>
                                    <div id="megaPamphletIndexLabel" class="content" style="font-size: 140%">超级词库</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn dark-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell("wordsHistory")%>">
                                    <div class="header">
                                        <i class="fa fa-clock-o"></i>
                                    </div>
                                    <div id="wordsHistoryIndexLabel" class="content" style="font-size: 140%">历史记录</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn orange-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell("wordsRank")%>">
                                    <div class="header">
                                        <i class="fa fa-line-chart"></i>
                                    </div>
                                    <div id="wordsRankIndexLabel" class="content" style="font-size: 140%">单词排行</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="pamphletList" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>我创建的单词本</span>
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
                                            <label for="phNameSearch" style="width: 25%">名称</label>
                                            <input id="phNameSearch" class="form-control"  type='text' style="width: 52%;display:inline;" onchange="pageData.fnSearchGlossaryName()"/>
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
                            <# for( var i in userPamphletList ) {
                            var row     = userPamphletList[i];
                            var classid = row["classid"];
                            var imgurl  = row["ph_img_href"];
                            var ph_name = row["ph_name"];
                            #>
                            <a href="<%=thisPage.spawnActionQuerySpell("wordList")%>&class_id=<#=classid#><#=szConfSift#>">
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
                                                            <h4 class="modal-title" style="color:black" >Warning</h4>
                                                        </div>
                                                        <div class="modal-body" style="color: black"><h3>您确实要删除单词本 <#=ph_name#> 吗?</h3></div>
                                                        <div class="modal-footer">
                                                            <a href="<%=thisPage.spawnControlQuerySpell("deleteOnePamphlet")%>&classid=<#=classid#>"><button class="btn btn-danger">确定</button></a>
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

                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletDeviser")%>">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="/root/assets/img/icon-plus.jpg" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-plus p-g-used-time"></a>
                                            <span style="margin-top: 5%">添加单词本</span>
                                        </div>
                                        <div class="p-glossary-title">
                                            <span class="nb" style="margin-left: 30%"><i class="fa fa-plus"></i>添加单词本</span>
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

            <div class="col-sm-10" id="pamphletDeviser" style="display:none;">
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
                            <form name="pamphletDeviser" method="post" action="<%=thisPage.spawnActionControlSpell( "pamphletDeviser", "appendNewPamphlet" )%>" enctype="multipart/form-data">
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">单词本名称: </label>
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
                                    <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="pamphletEditor" style="display:none;" >
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-edit"></i><span> 编辑单词本</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" >
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="editPamphlet" method="post" action="<%=thisPage.spawnControlQuerySpell("editPamphlet" )%>" enctype="multipart/form-data" >
                                <input class="form-control" name="classid" id="classidModify" type="hidden" />
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">单词本名称: </label>
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
                                                    <select id="ph_authorityModify" name="ph_authority" class="form-control" style="width: 80%">
                                                        <option value="public">公开</option>
                                                        <option value="private">私有</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group com-group-control" id="pamphletCoverField">
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

            <div class="col-sm-10" id="pamphletClone" style="display:none;" >
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-copy"></i><span> 欢迎使用单词本克隆向导</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12" >
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="editPamphlet" method="post" action="<%=thisPage.spawnControlQuerySpell("cloneGlossary" )%>" enctype="multipart/form-data" >
                                <input class="form-control" name="usernameProto" id="usernameClone" type="hidden" />
                                <input class="form-control" name="classid" id="classidClone" type="hidden" />
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="form-group com-group-control-relate">
                                            <label style="width: 20%">单词本名称: </label>
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

            <div class="col-sm-10" id="pamphletCollection" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-sticky-note-o"></i><span>我收藏的单词本</span>
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
                                            <label for="phcNameSearch" style="width: 25%">名称</label>
                                            <input id="phcNameSearch" class="form-control"  type='text' style="width: 52%;display:inline;" onchange="pageData.fnSearchGlossaryName()"/>
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
                            var ph_name = row["ph_name"];
                            #>
                            <a href="<%=thisPage.spawnActionQuerySpell("wordList")%>&class_id=<#=classid#>">
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
                                                        <div class="modal-body" style="color: black"><h3>您确实要取消收藏单词本 <#=ph_name#> 吗?</h3></div>
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

            <div class="col-sm-10" id="wordList" style="display:none;" >
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
                                            <#if( !bReadonly  ) { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletEditor")%>&class_id=<#=class_id#>">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="<%=thisPage.spawnActionQuerySpell("appendNewWord")%>#appendNewWord" data-toggle="modal" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-plus"></i>&nbsp;单词</span>
                                            </a>
                                            <#} else { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletClone")+"&class_id="+$_GSC.optString( "class_id" )%>"
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
                                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletEditor")%>&class_id=<#=class_id#>" style="font-weight: bolder">添加标签</a>
                                            <#} else { #> 暂无标签 <#}#>
                                        </h4>
                                        <h4><i class="fa fa-tag"></i><label>词数：</label> <span style="font-weight: bolder"><#=nWordSum#></span></h4>
                                        <h4><i class="fa fa-tag"></i><label>简介：</label>
                                            <#if( row["ph_note"] ){#>
                                            <span style=" font-style:italic"><#=row["ph_note"]#></span>
                                            <#}else{
                                            if( !bReadonly ) { #>
                                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletEditor")%>&class_id=<#=class_id#>" style="font-weight: bolder">添加简介</a>
                                            <#} else { #> 暂无简介 <#} } #>
                                        </h4>

                                        <% if( !bReadonly ) { // For safe %>
                                        <div class="modal fade" id="appendNewWord" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="margin-top: 6%">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title" id="myModalLabel">添加单词</h4>
                                                    </div>
                                                    <form name="appendNewWord" id="appendNewWordForm" method="POST" action="<%=thisPage.spawnControlQuerySpell("appendNewWord")%>">
                                                        <input id="classid" name="classid" type="text" value="<#=class_id#>" hidden/>
                                                        <input id="referHref" name="referHref" type="text" value="<#=referHref#>" hidden/>
                                                        <div class="modal-body">
                                                            <div class="form-group com-group-control">
                                                                <div class="form-group com-group-control">
                                                                    <label style="margin-left: 0">单词: </label>
                                                                    <textarea name="en_word" class="form-control" style="width: 83%;height: 150px;" ></textarea>
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
                                    <div class="modal fade" id="BookPlan" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="myModalPlanLabel">计划制定</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <h3 style="font-weight: lighter"><i class="fa fa-book"></i>词汇书总词量：<strong> <#=nWordSum#></strong></h3>
                                                    <form method="POST" name="BookStudyPlan" action="?do=ReciteCenter&control=startStudyBook&class_id=<#=class_id#>&username=<#=row['username']#>&ph_name=<#=row['ph_name']#>" onsubmit="return PineconeInputValueCheck.checkResult()">
                                                        <label>选择每日任务</label>
                                                        <select multiple class="form-control" name="p_word" id="p_word" onblur="PineconeInputValueCheck.checkInputValue(this)">
                                                            <option value="10"><strong>10 单词 &nbsp;<#var day1=Math.ceil(nWordSum/10) #><#=day1#>天</strong></option>
                                                            <option value="20"><strong>20 单词 &nbsp;<#var day2=Math.ceil(nWordSum/20) #><#=day2#>天</strong></option>
                                                            <option value="30"><strong>30 单词 &nbsp;<#var day3=Math.ceil(nWordSum/30) #><#=day3#>天</strong></option>
                                                            <option value="40"><strong>40 单词 &nbsp;<#var day4=Math.ceil(nWordSum/40) #><#=day4#>天</strong></option>
                                                            <option value="50"><strong>50 单词 &nbsp;<#var day5=Math.ceil(nWordSum/50) #><#=day5#>天</strong></option>
                                                            <option value="100"><strong>100 单词 &nbsp;<#var day6=Math.ceil(nWordSum/100) #><#=day6#>天</strong></option>
                                                            <option value="150"><strong>150 单词 &nbsp;<#var day7=Math.ceil(nWordSum/150) #><#=day7#>天</strong></option>
                                                            <option value="300"><strong>300 单词 &nbsp;<#var day8=Math.ceil(nWordSum/300) #><#=day8#>天</strong></option>
                                                            <option value="500"><strong>500 单词 &nbsp;<#var day9=Math.ceil(nWordSum/500) #><#=day9#>天</strong></option>
                                                        </select>
                                                        <div class="modal-footer">
                                                            <button type="submit" class="btn btn-info" style="width:100px;" ><i class="fa fa-bookmark"></i> 开始背书</button>
                                                        </div>
                                                    </form>
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
                    <div class="col-md-12 box-content " id="wordListSearcher" >
                        <div class="panel panel-default btn-sharp">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group com-group-control-search">
                                            <% if ( !bReadonly && !bHistoryMode ){ %>
                                            <label for="sort_type" style="width: 23%">排序: </label>
                                            <select id="sort_type" style="width: 55%" class="form-control" onchange="pageData.fnSortWords( )">
                                            <% } else { %>
                                            <label for="sort_type" style="width: 23%">排序: </label>
                                            <select id="sort_type" class="form-control" style="width: 76%" onchange="pageData.fnSortWords( )">
                                            <% } %>
                                                <option value="" >默认顺序</option>
                                            </select>
                                            <% if ( !bReadonly && !bHistoryMode ){ %>
                                            <a href="javascript:pageData.fnSaveSortedList()" class="btn btn-primary btn btn-default" style="width: 20%"> 应用 </a>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group com-group-control-relate">
                                            <label for="band_type" style=" width: 30%">考试: </label>
                                            <select id="band_type" style=" width: 68%" class="form-control" onchange="pageData.fnSiftBand()">
                                                <option value="" >未选择</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <div class="form-group com-group-control-search">
                                            <label for="wordListKeyWord">搜索: </label>
                                            <input class="form-control" id="wordListKeyWord" type="text" placeholder="输入英文单词" maxlength="50" onkeydown="pageData.fnSearchKeyWord()" required/>
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
                                            <label for="wordListPageLimit" style="width: 23%">每页: </label>
                                            <input class="form-control" id="wordListPageLimit" type="number" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                            <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <% if ( !bReadonly ){ %>
                                        <a href="javascript:void(0);" class="btn btn-danger" id="<%=bHistoryMode?"history": "word"%>MassDelete" style="border-radius: 0">批量删除</a>
                                        <% } %>
                                        <% if ( !bHistoryMode ){ %>
                                        <a href="<%=thisPage.spawnActionQuerySpell("wordList")+"&class_id=" + $_GSC.opt( "class_id" )%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                        <%} else { %>
                                        <a href="<%=thisPage.spawnActionQuerySpell("wordsHistory")%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                        <%} %>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllWordDetail( this );" class="btn btn-info btn-sharp" >展开详细</a>
                                        <a href="javascript:void(0);" onclick="pageData.fnHideAllDef( this );" class="btn btn-primary btn-sharp" >隐藏释义</a>
                                    </div>

                                    <div class="col-sm-1">
                                        <div style="margin-top: 8px;text-align: center">
                                            <a href="javascript:pageData.fnAdvanceSwitch( )" ><i class="fa fa-angle-down"></i> 高级</a>
                                        </div>
                                    </div>
                                </div>


                                <div class="row p-p-searcher-advance" style="display: none">
                                    <hr style="margin-top: -1px">
                                    <div class="col-sm-5" >
                                        <div class='form-group com-group-control-date' >
                                            <label class="main-label" style="width: 25%;">开始时间: </label>
                                            <input id='startTime' name='startTime' type='text' value="" class="form-control" placeholder="yyyy-mm-dd" style="width: 64%;" required/>
                                            <label for="startTime" class="span-label" style="width: 10%"><i class="fa fa-calculator"></i> </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-5" >
                                        <div class='form-group com-group-control-date' >
                                            <label class="main-label" style="width: 25%;">截止时间: </label>
                                            <input id='endTime' name='endTime' type='text' value="" class="form-control" placeholder="yyyy-mm-dd" style="width: 64%;" required/>
                                            <label for="endTime" class="span-label" style="width: 10%"><i class="fa fa-calculator"></i> </label>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <a href="#" onclick="javascript:pageData.fnSiftByDate()" style="width: 48%" class="btn btn-default btn-sharp">查找</a>
                                        <a href="#" onclick="javascript:pageData.fnClearDateSearch()" style="width: 48%" class="btn btn-default btn-sharp">清除</a>
                                    </div>

                                    <div class="col-sm-4">
                                        <div class="form-group com-group-control-search">
                                            <label for="daily_type" style="width: 23%">按日: </label>
                                            <select id="daily_type" style="width: 76%" class="form-control" onchange="pageData.fnSiftByDaily( )">
                                                <option value="" >请选择</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                    <div class="col-sm-2" style="text-align: right">
                                        <a href="javascript:void(0);" onclick="pageData.fnDownloadAsTable( );" class="btn btn-primary btn-sharp" >导出表格</a>
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
                                                        <% if (!bReadonly) { %> <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px"> <%} %>
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<%=szWordQuerySpell%><#=en_word#>" target="_blank"><strong><#=en_word#></strong></a>
                                                        <a class="fa fa-volume-up" href="javascript:pageData.fnPlayWord( '<#=en_word#>' );"></a>
                                                        <%if (!bReadonly) { %>
                                                        <a class="btn btn-primary btn-sharp" style="float: right;margin-left: 1%" data-toggle="modal" href="#modalDeleteOne<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                        <a class="btn btn-warning btn-sharp" style="float: right;margin-left: 1%" href="" title="标记遗忘"><i class="fa fa-tag"></i></a>
                                                        <%} %>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-7" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def">
                                                                <i class="fa fa-eye-slash" onclick="pageData.fnHideCurrentDef( this )" style="cursor: pointer"></i>
                                                                <#= $fnSubstr( row["defs"],0,42 )#>
                                                            </p>
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
                                                                    <# if (!bReadonly) { #>
                                                                    <a data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#wordProfileEditor<#=en_word#>"><i class="fa fa-edit"></i></a>
                                                                    <#}#>
                                                                    <a class="fa fa-thumb-tack" href="<%=thisPage.querySpell().searchUserSentence("")%><#=en_word#>" target="_blank"> 造句</a>
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
                                                                    <% if (!bReadonly) { %>
                                                                    <a data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell()%>#wordProfileEditor<#=en_word#>"><i class="fa fa-edit"></i></a>
                                                                    <%}%>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% if( !bReadonly){ %>
                                                    <div class="modal fade crisp-union-win" id="modalDeleteOne<#=row['id']#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title" >是否删除</h4>
                                                                </div>
                                                                <div class="modal-body"><h4>您确实要删除该单词 "<#=en_word#>" 吗?</h4></div>
                                                                <div class="modal-footer">
                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteOneWord")%>&id=<#=row['id']#>&class_id=<%=$_GSC.optString( "class_id" )%>"><button class="btn btn-danger">确定</button></a>
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
                                                        <h4 class="modal-title" id="editNoteLabel">编辑单词</h4>
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

            <div class="col-md-10" id="megaPamphlet" style="display:none;" >
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
                            <form name="CompareTo" method="POST" action="<%=thisPage.spawnActionControlSpell("megaPamphlet","BuildCompare")%>">
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

            <div class="col-sm-10" id="wordsHistory" style="display:none;">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%"><i class="fa fa-clock-o"></i>
                            <span>我的单词历史</span>
                        </h4>
                    </div>
                </div>

                <div class="crisp-my-box row">
                    <div class="col-md-12 box-content" id="wordsHistorySearcher">

                    </div>

                    <div class="col-sm-12">
                        <div class="crisp-my-box">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplHistoryWordList">
                                    <# var nEnum = 1;
                                    for( var en_word in wordList ) {
                                    var row     = wordList[en_word];
                                    var note    = row["g_note"]; #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <# if (!bReadonly) { #> <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px"> <#} #>
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<%=szWordQuerySpell%><#=en_word#>"><strong><#=en_word#></strong></a>
                                                        <a class="fa fa-volume-up" href="javascript:pageData.fnPlayWord( '<#=en_word#>' );"></a>
                                                        <# if (!bReadonly) { #>
                                                        <a class="btn btn-primary btn-sharp" style="float: right;margin-left: 1%" data-toggle="modal" href="#modalPurgeHistory<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                        <a class="btn btn-success btn-sharp" style="float: right;margin-left: 1%" href="" title="添加单词本"><i class="fa fa-plus"></i></a>
                                                        <#} #>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-7" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def">
                                                                <i class="fa fa-eye-slash" onclick="pageData.fnHideCurrentDef( this )" style="cursor: pointer"></i>
                                                                <#= $fnSubstr( row["defs"],0,42 )#>
                                                            </p>
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
                                                            <# var szHDetailID = "p-w-d-" + row['id'] + "-" + en_word; #>
                                                            <p style="margin-top: -2px"><a href="javascript:pageData.fnShowWordDetail( '<#=szHDetailID#>' )"><i class="fa fa-angle-down" ></i> 详细</a></p>
                                                        </div>
                                                    </div>

                                                    <div class="p-w-details" style="display: none" id="<#=szHDetailID#>" >
                                                        <hr style="margin-top: 0">
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <p style="margin-top: -1%"><i class="fa fa-tag"></i> <span><#=row["band"]#></span></p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal fade crisp-union-win" id="modalPurgeHistory<#=row['id']#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title" id="crisp-WarnCommonLabel">是否删除</h4>
                                                                </div>
                                                                <div class="modal-body"><h4>您确实要删除该单词 "<#=en_word#>" 的记录吗?</h4></div>
                                                                <div class="modal-footer">
                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteOneHistory")%>&id=<#=row['id']#>"><button class="btn btn-danger">确定</button></a>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                                </div>
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


                            <div class="row">
                                <div class="col-sm-4 ">
                                    <div class="form-group">
                                        <a href="javascript:void(0)" class="btn btn-default btn-sharp" >批量添加</a>
                                    </div>
                                </div>

                                <div class="col-sm-8 crisp-margin-ui-fault-tolerant-2" >
                                    <div class="crisp-paginate" style="margin-right: 3%">
                                        <ul class="pagination"></ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="wordsRank" style="display:none;">
                <div class="crisp-my-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <i class="fa fa-line-chart"></i><span>我的单词记忆排行</span>
                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                    <i class="fa fa-angle-down"></i> 筛选
                                </a>
                            </h4>
                        </div>
                    </div>
                    <div class="box-content row" >
                        <div class="col-md-12">
                            <div class="panel panel-default btn-sharp">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-1">
                                            <div class="form-group">
                                                <input type="checkbox" onclick="Saurye.checkAll(this)" style="width: 15px;margin-top: 10px"><span> 全选</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group com-group-control-search">
                                                <label for="wordsRankPageLimit" style="width: 23%">每页: </label>
                                                <input class="form-control" id="wordsRankPageLimit" type="number" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                                <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group com-group-control-search">
                                                <label for="wordsRankKeyWord" style="width: 23%">搜索: </label>
                                                <input class="form-control"  style="width: 50%" id="wordsRankKeyWord" type="text" placeholder="输入英文单词" maxlength="50" onkeydown="pageData.fnSearchKeyWord()" required/>
                                                <a href="javascript:pageData.fnSearchKeyWord()" style="width: 25%" class="btn btn-default">查找</a>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <a href="javascript:void(0);" class="btn btn-danger" id="wordsRankMassDelete" style="border-radius: 0">批量删除</a>
                                            <a href="<%=thisPage.spawnActionQuerySpell("wordsRank")%>" class="btn btn-primary btn-sharp">清除筛选</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="table-responsive" id="wordsRankList">
                                <table class="table table-striped table-bordered table-hover predator-fat-table-simple" >
                                    <tbody>
                                    <script type="text/html" id="tplWordsRankList">
                                        <# var nEnum = 1;
                                            for( var i = 0; i < wordList.length ; ++i ) {
                                            var row  = wordList[ i ];
                                            var word = row[ "en_word" ];
                                            var nC   = row[ "nCount" ];
                                        #>
                                            <tr>
                                                <td style="width: 60%">
                                                    <input type="checkbox" name="massDelete" value="<#=word#>"  style="width: 15px">
                                                    <#=$fnEnumGet().now( nEnum++ )#>.
                                                    <a href="<%=szWordQuerySpell%><#=row[ 'en_word' ]#>"><strong><#=word#></strong></a>
                                                    <a class="fa fa-volume-up" href="javascript:pageData.fnPlayWord( '<#=word#>' );"></a>
                                                    [ <#=row[ "m_property" ]#>. <#=row[ "cn_word" ]#>... ]
                                                    <a style="float: right;margin-left: 1%" data-toggle="modal" href="#modalForgetOneRecall<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                </td>
                                                <td style="width: 40%" class="predator-word-rank-td">
                                                    <span class="p-w-r-index" style="width:<#=( nC / nMax )*98#>%;"></span>
                                                    <span><#=nC#>次</span>
                                                </td>
                                                <div class="modal fade crisp-union-win" id="modalForgetOneRecall<#=row['id']#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                <h4 class="modal-title" >是否删除</h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <h4>您确实要删除该单词 "<#=word#>" 的记忆信息吗？</h4>
                                                                <p style="color: red">该单词的记忆记录将被重置，并重新统计，这可能影响分析的准确性!</p>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <a href="<%=thisPage.spawnControlQuerySpell("forgetOneRecall")%>&en_word=<#=word#>"><button class="btn btn-danger">确定</button></a>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </tr>
                                        <#} #>
                                    </script>
                                    </tbody>
                                </table>
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
<script src="/root/root/System/elements/pamphlet/pamphlet.js"></script>
<script src="/root/root/System/elements/pamphlet/glossary.js"></script>
<script src="/root/assets/js/plugins/Chart.min.js"></script>
${SingleImgUploader}
<script>
    var pageData = ${szPageData};

    $_Predator( pageData, {
        "init"   : function ( parent ) { },
        "genies" : function( parent ){
            $_CPD({
                "pamphletList"       : {
                    title: "单词本列表",
                    fn: function( wizard ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['userPamphletList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderBuildList":function (self) {
                                var hGConfig = pageData[ "GlossaryConfig" ];
                                var hDGConf  = {};
                                if ( $isTrue( hGConfig ) ) {
                                    hDGConf[ "pageLimit" ] = hGConfig [ "pc_each_page"    ];
                                    hDGConf[ "sort_type" ] = hGConfig [ "pc_sort_default" ];
                                    self.genieData[ "szConfSift" ] = pPine.Navigate.queryStringify( "", hDGConf );
                                }

                                self.genieData["userPamphletList"] = pageData["userPamphletList"];
                                self.renderById("tplGlossaryTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "ph_name", "#phNameSearch", true );
                                };
                                pageData.fnSearchGlossaryAuthority = function () {
                                    Predator.searcher.bindSingleSearch( "ph_authority", "#glossaryAuthority", true );
                                };
                                if( $_GET["ph_name"] || $_GET["ph_authority"] ){
                                    $_PINE( wizard.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "pamphletDeviser"    : {
                    title: "新建单词本",
                    fn: function () {
                        $_PINE("#newPamphletCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                    }
                },

                "pamphletEditor"     : {
                    title:"修改单词本",
                    fn: function (wizard) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init":function (self) {
                                if( pageData['oldPamphletProfile'] ){
                                    $_PINE("#pamphletCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                                    $_PMVC.formDynamicRenderer( pageData[ 'oldPamphletProfile' ], "Modify", null );
                                }
                            }
                        });
                    }
                },

                "pamphletClone"      : {
                    title: "单词本克隆",
                    fn: function () {
                        Predator.wizard.smartGenieInstance(this, {
                            "init":function (self) {
                                if( pageData['oldPamphletProfile'] ){
                                    var buildData = pageData[ 'oldPamphletProfile' ];
                                    $_PINE("#pamphletCloneCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                                    $_PMVC.formDynamicRenderer( buildData, "Clone", null );
                                }
                            }
                        });
                    }
                },

                "pamphletCollection" : {
                    title: "我的收藏",
                    fn: function( wizard ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['collectedPamphletList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderBuildList":function (self) {
                                self.genieData["collectedPamphletList"] = pageData["collectedPamphletList"];
                                self.renderById("tplGlossaryCollectTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "ph_name", "#phcNameSearch", true );
                                };
                                if( $_GET["ph_name"] ){
                                    $_PINE( wizard.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "wordList"           : {
                    title: "单词本内容",
                    fn: function ( wizard ) {
                        var bReadonly = pageData["bgReadonly"];
                        var bIsReciting = pageData["bIsReciting"];

                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                var szRecitingTitle = '';
                                if( bIsReciting ){
                                    szRecitingTitle = "<i class=\"fa fa-check-square\"></i><a href=\"#\"> 正在背诵....</a>";
                                }
                                else{
                                    szRecitingTitle = "<i class=\"fa fa-check-square-o\"></i><a data-toggle=\"modal\" href=\"?do=PersonalGlossary&action=wordList#BookPlan\"> 背诵！</a>";
                                }
                                $_PINE("#head-line").html(szRecitingTitle);
                                Predator.wizard.conjurer.superBtn.summoned( bReadonly ? "pamphletCollection" : wizard.mDefaultChild );
                                self.genieData["bReadonly"      ] = bReadonly;
                                self.genieData["bIsReciting"    ] = bIsReciting;
                                self.genieData.Math = Math;
                            },
                            "renderGlossary": function (self) {
                                self.genieData["GlossaryProfile"] = pageData["GlossaryProfile"];
                                self.genieData[ "referHref"     ] = "?" + pPine.Http.getQueryString();
                                self.genieData[ "nWordSum"      ] = pageData["nPageDataSum"];
                                self.renderById("tplGlossaryProfile");
                                $EP_Glossary.renderWordSearcher();
                                $EP_Pamphlet.renderDailySearch( "#daily_type", "d_add_date" );
                            },
                            "renderGlossaryContent": function (self) {
                                var hList = pageData[ "WordList" ];
                                if( hList.length > 0 ) {
                                    var sMap = $EP_Glossary.multipleWordsList2Map( hList );
                                    pageData.glossaryDownloadDataMap = sMap;

                                    //console.log( sMap );
                                    self.genieData[ "class_id"]        = $_GET["classid"];
                                    self.genieData[ "wordList" ]       = sMap;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplGlossaryWordList");
                                }
                                else {
                                    $_PINE("#tplGlossaryWordList").parent().html( Predator.tpl.notice.simpleNoData );
                                }
                            },
                            "afterWordListRendered" : function ( self ) {
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                                Predator.elements.pamphlet.glossary.registerWordListAction( pageData, self );
                                Predator.smartMassDeleteListener( "wordMassDelete" );
                            },
                        });
                    }
                },

                "megaPamphlet"       : {
                    title: "我的超级词库",
                    fn   : function (wizard) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function ( self ) {
                                if( !$isTrue( pageData[ 'glossaryWordEachSum' ] ) ){
                                    $_PINE("#megaPamphlet .box-content").parent().html( Predator.tpl.notice.simpleNoData  );
                                    return false;
                                }
                            },
                            "renderWordEachSum": function ( self ) {
                                var hEachWords       = pageData[ 'glossaryWordEachSum' ];
                                var hEachWordsRender = [];
                                for( var i = 0; i < hEachWords.length; i++ ){
                                    hEachWordsRender[i] = [ hEachWords[i]['ph_name'], hEachWords[i]['nCount'], Pinecone.Random.nextColor() ];
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
                                Predator.chart.mountDefaultLine("#megaPamphlet #StudyRate",["1月3日","1月4日" ,"1月5日","1月6日" ,"1月7日" ],
                                    [["学习单词",[3, 2, 4, 18, 30],"rgb(75, 192, 192)"],
                                        ["复习单词",[1.3, 0.9, 1.5, 2.4, 3.5],"rgba(255,99,132,1)"],
                                        ["遗忘单词",[0.0, 0.1,0.6, 0.9, 1.4],"#3889FC"]]);
                                //Saurye.chart.mountDefaultPie("#pieChartContainerCompare",186,[["相似度",pageData['Result'],"#A8D582"],["不相似度",100-pageData['Result'],"#4ED688"]])
                            }
                        });
                    }
                },

                "wordsHistory"       : {
                    title: "历史记录",
                    fn   : function ( wizard ) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                var hWordListSearcher = $_PINE( "#wordListSearcher" );
                                hWordListSearcher.remove();
                                $_PINE( "#wordsHistorySearcher" ).html( hWordListSearcher.html() );
                            },
                            "renderList": function ( self ) {
                                var hList = pageData[ "WordList" ];
                                if( hList.length > 0 ) {
                                    var sMap = Predator.elements.pamphlet.glossary.multipleWordsList2Map( hList );
                                    pageData.glossaryDownloadDataMap = sMap;

                                    //console.log( sMap );
                                    self.genieData[ "wordList" ]       = sMap;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplHistoryWordList");
                                }
                                else {
                                    $_PINE("#tplHistoryWordList").parent().html( Predator.tpl.notice.simpleNoData  );
                                }
                            },
                            "afterWordListRendered" : function ( self ) {
                                $EP_Glossary.renderWordSearcher();
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                                Predator.elements.pamphlet.glossary.registerWordListAction( pageData, self );
                                Predator.smartMassDeleteListener( "historyMassDelete" );
                            }
                        });
                    }
                },

                "wordsRank"          : {
                    title: "单词排行",
                    fn   : function ( parent ) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self){
                                if( $isTrue( pageData[ "wordsRecallRanks" ] ) ){
                                    self.genieData[ "wordList" ]       = pageData[ "wordsRecallRanks" ];
                                    self.genieData[ "nMax"     ]       = pageData[ "wordsRecallRanks" ][0]['nCount'];
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.renderById("tplWordsRankList");
                                }
                                else  {
                                    $_PINE("#wordsRankList").parent().html( Predator.tpl.notice.simpleNoData  );
                                }
                            },
                            "afterWordsRankRendered" : function ( self ) {
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                                pageData.fnPlayWord = function ( s ){
                                    return Predator.vocabulary.phonetic.audioPlay( s, 1 );
                                };
                                Predator.smartMassDeleteListener( "wordsRankMassDelete", 'en_word' );
                            }
                        });
                    }
                }
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
                            Predator.searcher.bindSingleSearch( "en_word", "#"+ who +"KeyWord", true );
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
                "pageLimit"    : [ "#wordListPageLimit","#glossaryListPageLimit", "#wordsRankPageLimit" ],
                "en_word"      : [ "#wordListKeyWord", "#wordsRankKeyWord" ],
                "sort_type"    : [ "#sort_type" ],
                "ph_name"      : [ "#phNameSearch", "#phcNameSearch" ],
                "ph_authority" : [ "#glossaryAuthority" ],
                "ph_c_type"    : [ "#cGlossaryType" ],
                "band_type"    : [ "#band_type" ],
                "startTime"    : [ "#startTime" ],
                "endTime"      : [ "#endTime"   ],
            });
        }
    });

</script>
${StaticPageEnd}