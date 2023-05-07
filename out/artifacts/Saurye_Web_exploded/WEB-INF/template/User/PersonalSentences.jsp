<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC = thisPage.$_GSC();
    JSONObject proto = thisPage.getModularConfig();
    String szWordQuerySpell = thisPage.querySpell().queryWord("");
    String  szClassId       = $_GSC.optString( "class_id" );
    boolean bReadonly       = thisPage.getPageData().optBoolean( "bgReadonly" );
    boolean bMegaMode       = thisPage.getPageData().optBoolean( "bgMegaMode" );
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
                <div class="crisp-union-box predator-left-super-menu" >
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background super-btn-add-gap">
                                <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                    <div class="header">
                                        <i class="fa fa-book"></i>
                                    </div>
                                    <div id="pamphletListIndexLabel" class="content" style="font-size: 140%">我的册子</div>
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
                                    <div id="megaPamphletIndexLabel" class="content" style="font-size: 140%">超级句库</div>
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
                                <i class="fa fa-sticky-note-o"></i><span>我创建的造句本</span>
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
                        <script type="text/html" id = "tplPamphletTable">
                            <# for( var i in userPamphletList ) {
                            var row     = userPamphletList[i];
                            var classid = row["classid"];
                            var imgurl  = row["ph_img_href"];
                            var ph_name  = row["ph_name"];
                            #>
                            <a href="<%=thisPage.spawnActionQuerySpell("sentenceList")%>&class_id=<#=classid#> ">
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
                                                        <div class="modal-body" style="color: black"><h3>您确实要删除造句本 <#=ph_name#> 吗?</h3></div>
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

                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("pamphletDeviser")%>">
                                <div class="col-md-3 col-sm-3 col-xs-6">
                                    <div class="p-glossary-frame">
                                        <img src="/root/assets/img/icon-plus.jpg" >
                                        <div class="bottom">
                                            <a class="glyphicon glyphicon-plus p-g-used-time"></a>
                                            <span style="margin-top: 5%">添加造句本</span>
                                        </div>
                                        <div class="p-glossary-title">
                                            <span class="nb" style="margin-left: 30%"><i class="fa fa-plus"></i>添加造句本</span>
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
                            <i class="fa fa-edit"></i><span> 新建造句本</span>
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
                                            <label style="width: 20%">造句本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_name" type="text" placeholder="请输入造句本名称" style="width: 80%;display:inline" required>
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
                            <i class="fa fa-edit"></i><span> 编辑造句本</span>
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
                                            <label style="width: 20%">造句本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_nameModify" type="text" placeholder="请输入造句本名称" style="width: 80%;display:inline" required>
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
                            <i class="fa fa-copy"></i><span> 欢迎使用造句本克隆向导</span>
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
                                            <label style="width: 20%">造句本名称: </label>
                                            <input class="form-control" name="ph_name" id="ph_nameClone" type="text" placeholder="请输入造句本名称" style="width: 80%;display:inline" required>
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
                                <i class="fa fa-sticky-note-o"></i><span>我收藏的造句本</span>
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
                                                        <div class="modal-body" style="color: black"><h3>您确实要取消收藏造句本 <#=ph_name#> 吗?</h3></div>
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


            <div class="col-sm-10" id="sentenceList" style="display:none;" >
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="crisp-my-profile">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplSentenceProfile">
                                    <# var row = SentenceProfile[0];
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
                                            <a href="<%=thisPage.spawnActionQuerySpell("pamphletEditor")%>&class_id=<#=class_id#>">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="<#=szMakeSentHref#>" style="font-weight: bolder">
                                                <span style="float: right;font-size: 80%"><i class="fa fa-magic"></i>&nbsp;造句</span>
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

                                    </div>
                                </script>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="crisp-my-box row">
                    <div class="pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%">
                                <span> </span>
                                <a class="box-down" href="javascript:void(0)" style="float: right"><i class="fa fa-angle-down"></i> 控制台</a>
                            </h4>
                        </div>
                    </div>
                    <div class="col-md-12 box-content " id="sentenceListSearcher" >
                        <div class="panel panel-default btn-sharp">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <% if ( !bReadonly ){ %>
                                            <label for="sort_type" style="width: 23%">排序: </label>
                                            <select id="sort_type" style="width: 55%" class="form-control" onchange="pageData.fnSortSentences ( )">
                                            <% } else { %>
                                            <label for="sort_type" style="width: 23%">排序: </label>
                                            <select id="sort_type" class="form-control" style="width: 76%" onchange="pageData.fnSortSentences ( )">
                                            <% } %>
                                                <option value="" >默认顺序</option>
                                            </select>
                                            <% if ( !bReadonly ){ %>
                                            <a href="javascript:pageData.fnSaveSortedList()" class="btn btn-primary btn btn-default" style="width: 20%"> 应用 </a>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group com-group-control-search">
                                            <label for="sentenceListKeyWord">搜索: </label>
                                            <input class="form-control" id="sentenceListLinkedWord" type="text" placeholder="输入关联单词" maxlength="50" onkeydown="pageData.fnSearchLinkedWord()" required/>
                                            <a href="javascript:pageData.fnSearchLinkedWord()" class="btn btn-default">查找</a>
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
                                            <label for="sentenceListPageLimit" style="width: 23%">每页: </label>
                                            <input class="form-control" id="sentenceListPageLimit" type="number" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                            <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <% if ( !bReadonly ){ %>
                                        <a href="javascript:void(0);" class="btn btn-danger" id="sentenceMassDelete" style="border-radius: 0">批量删除</a>
                                        <% } %>
                                        <a href="<%=thisPage.spawnActionQuerySpell("sentenceList")+"&class_id=" + $_GSC.opt( "class_id" )%>" class="btn btn-primary btn-sharp">清除筛选</a>
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
                                        <div class="form-group com-group-control-search">
                                            <label for="sentenceListKeyWord">搜索: </label>
                                            <input class="form-control" id="sentenceListKeyWord" type="text" placeholder="输入句子关键字" maxlength="50" onkeydown="pageData.fnSearchKeyWord()" required/>
                                            <a href="javascript:pageData.fnSearchKeyWord()" class="btn btn-default">查找</a>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
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
                                <script type="text/html" id="tplSentenceWordList">
                                    <# var nEnum = 1;
                                        for( var i in sentenceList ) {
                                            var row           = sentenceList[i];
                                            var note          = row["ph_note"];
                                            var szModifyHref  = "<%=thisPage.spawnActionQuerySpell("sentenceModify")%>&mega_id=" + row['mega_id']
                                                                + "&class_id=" + classId + "&referHref=" + referHref;
                                    #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <# if (!bReadonly) { #> <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px"> <#} #>
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<#=szModifyHref#>"><strong><#=$fnSubstr( row['s_sentence'], 0, 60 )#></strong></a>
                                                        <# if (!bReadonly) { #>
                                                        <a class="btn btn-primary btn-sharp" style="float: right;margin-left: 1%" data-toggle="modal" href="#modalDeleteOne<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                        <#} #>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-6" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def"><#= $fnSubstr( row["s_cn_def"],0,45 )#></p>
                                                        </div>
                                                        <div class="col-sm-4" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <#  var words = row["words"];
                                                                for( var i = 0; i < words.length; i++ ){
                                                                    var szWord = words[i];
                                                            #>
                                                            <a href="<%=szWordQuerySpell%><#=szWord#>" target="_blank" ><#=szWord#></a><#=( i !== words.length-1 ? ';' : '')#>
                                                            <#} if( words.length < 1 ) { #>
                                                            <a href="<#=szModifyHref#>">添加关键词</a>
                                                            <#} #>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <p style="margin-top: -1%">
                                                                <span style="float: right"><i class="fa fa-clock-o"></i> <#=row["s_add_date"]#></span>
                                                            </p>
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
                                                                <div class="modal-body"><h4>您确实要删除该句子 "<#= $fnSubstr( row['s_sentence'], 0, 60 )#>" 吗?</h4></div>
                                                                <div class="modal-footer">
                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteOneSentence")%>&id=<#=row['id']#>"><button class="btn btn-danger">确定</button></a>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%} %>
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

            <div class="col-sm-10" id="makeSentence" style="display:none;">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-magic"></i><span> 新建我的造句</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="makeSentence" method="post" action="<%=thisPage.spawnActionControlSpell( "makeSentence", "makeSentence" )%>" enctype="multipart/form-data">
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <input name="index_of" value="<%=$_GSC.optString( "class_id" )%>" type="hidden" />
                                        <input id="makeSentenceReferHref" name="referHref" type="hidden"/>
                                        <div class="row">
                                            <div class="col-md-10">
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line" style="font-size: 110%">
                                                            <i class="fa fa-magic"></i><span> 造句</span>
                                                        </h4>
                                                    </div>
                                                </div>

                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 180px;width:20%;text-align: center">造句: </label>
                                                    <textarea id="s_sentence" name="s_sentence" class="form-control p-make-sent" style="width: 80%;height: 180px;"></textarea>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="crisp-my-box">
                                                    <div class="row pad-botm">
                                                        <div class="col-md-12">
                                                            <h4 class="header-line" style="font-size: 110%">
                                                                <i class="fa fa-cogs"></i><span> 工具箱</span>
                                                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                    </div>

                                                    <div class="box-content row">
                                                        <div class="col-md-12">
                                                            <a href="javascript:pageData.fnTranslateSent()" class="btn btn-primary btn-sharp" style="width: 100%"><i class="fa fa-language"></i> 自动翻译</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnPlaySentence()" class="btn btn-success btn-sharp" style="width: 100%"><i class="fa fa-play"></i> 朗读造句</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnKeyWordify()" class="btn btn-primary btn-sharp" style="width: 100%"><i class="fa fa-magic"></i> 魔法分析</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnKeyWordify()" class="btn btn-success btn-sharp" style="width: 100%"><i class="fa fa-key"></i> 寻找关键</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="crisp-my-box">
                                                    <div class="row pad-botm">
                                                        <div class="col-md-12">
                                                            <h4 class="header-line" style="font-size: 110%">
                                                                <i class="fa fa-key"></i><span> 关键词</span>
                                                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                    </div>

                                                    <div class="box-content">
                                                        <div id="sentsNewKeyWordListBox" class="row"></div>
                                                        <span>
                                                        <a href="javascript:pageData.$hKeyWordListBox.fnAdd()" class="btn btn-success fa fa-plus"> 添加关键字</a>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="crisp-my-box">
                                            <div class="row pad-botm">
                                                <div class="col-md-12">
                                                    <h4 class="header-line" style="font-size: 110%">
                                                        <i class="fa fa-tag"></i><span>备注</span>
                                                        <a class="box-down" href="javascript:void(0)" style="float: right">
                                                            <i class="fa fa-angle-down"></i>
                                                        </a>
                                                    </h4>
                                                </div>
                                            </div>

                                            <div class="box-content">
                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 150px;width:20%;text-align: center">释义: </label>
                                                    <textarea id="s_cn_def" name="s_cn_def" class="form-control" style="width: 80%;height: 150px;"></textarea>
                                                </div>

                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 150px;width:20%;text-align: center">笔记: </label>
                                                    <textarea id="s_note" name="s_note" class="form-control" style="width: 80%;height: 150px;"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: right">
                                    <button class='btn btn-primary' type='submit'>
                                        <i class='fa fa-magic'></i> 造句
                                    </button>
                                    <a href="<%=thisPage.$_GSC().optString( "referHref" ) %>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-10" id="sentenceModify" style="display:none;">
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%">
                            <i class="fa fa-edit"></i><span> 编辑查看我的造句</span>
                            <a href="javascript:history.back()" style="float: right;">
                                <i class="fa fa-reply"></i>返回
                            </a>
                        </h4>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default" style="border-radius:0">
                            <form name="sentenceModify" method="post" action="<%=thisPage.spawnControlQuerySpell( "sentenceModify" )%>" enctype="multipart/form-data">
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <input id="sentenceModifyReferHref" name="referHref" value="" type="hidden"/>
                                        <input name="index_of" value="<%=$_GSC.optString( "class_id" )%>" type="hidden" />
                                        <input name="mega_id" value="<%=$_GSC.optString( "mega_id" )%>" type="hidden" />
                                        <div class="row">
                                            <div class="col-md-10">
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line" style="font-size: 110%">
                                                            <i class="fa fa-magic"></i><span> 造句</span>
                                                        </h4>
                                                    </div>
                                                </div>

                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 180px;width:20%;text-align: center">造句: </label>
                                                    <textarea id="s_sentenceModify" name="s_sentence" class="form-control p-make-sent" style="width: 80%;height: 180px;" maxlength="1000"></textarea>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="crisp-my-box">
                                                    <div class="row pad-botm">
                                                        <div class="col-md-12">
                                                            <h4 class="header-line" style="font-size: 110%">
                                                                <i class="fa fa-cogs"></i><span> 工具箱</span>
                                                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                    </div>

                                                    <div class="box-content row">
                                                        <div class="col-md-12">
                                                            <a href="javascript:pageData.fnTranslateSent()" class="btn btn-primary btn-sharp" style="width: 100%"><i class="fa fa-language"></i> 自动翻译</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnPlaySentence()" class="btn btn-success btn-sharp" style="width: 100%"><i class="fa fa-play"></i> 朗读造句</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnKeyWordify()" class="btn btn-primary btn-sharp" style="width: 100%"><i class="fa fa-magic"></i> 魔法分析</a>
                                                        </div>
                                                        <div class="col-md-12" style="margin-top: 5px">
                                                            <a href="javascript:pageData.fnKeyWordify()" class="btn btn-success btn-sharp" style="width: 100%"><i class="fa fa-key"></i> 寻找关键</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="crisp-my-box">
                                                    <div class="row pad-botm">
                                                        <div class="col-md-12">
                                                            <h4 class="header-line" style="font-size: 110%">
                                                                <i class="fa fa-key"></i><span> 关键词</span>
                                                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                    <i class="fa fa-angle-down"></i>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                    </div>

                                                    <div class="box-content">
                                                        <div id="sentsNewKeyWordListBoxModify" class="row"></div>
                                                        <span>
                                                        <a href="javascript:pageData.$hKeyWordListBox.fnAdd()" class="btn btn-success fa fa-plus"> 添加关键字</a>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="crisp-my-box">
                                            <div class="row pad-botm">
                                                <div class="col-md-12">
                                                    <h4 class="header-line" style="font-size: 110%">
                                                        <i class="fa fa-tag"></i><span>备注</span>
                                                        <a class="box-down" href="javascript:void(0)" style="float: right">
                                                            <i class="fa fa-angle-down"></i>
                                                        </a>
                                                    </h4>
                                                </div>
                                            </div>

                                            <div class="box-content">
                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 150px;width:20%;text-align: center">释义: </label>
                                                    <textarea id="s_cn_defModify" name="s_cn_def" class="form-control" style="width: 80%;height: 150px;" maxlength="1000"></textarea>
                                                </div>

                                                <div class="form-group com-group-control-relate">
                                                    <label style="height: 150px;width:20%;text-align: center">笔记: </label>
                                                    <textarea id="s_noteModify" name="s_note" class="form-control" style="width: 80%;height: 150px;" maxlength="500"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="panel-footer" style="text-align: right">
                                    <button class='btn btn-primary' type='submit'>
                                        <i class='fa fa-save'></i> 保存
                                    </button>
                                    <a href="<%=thisPage.$_GSC().optString( "referHref" ) %>">
                                        <button class='btn btn-default' type="button"><i class='fa fa-reply'></i>返回</button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-10" id="megaPamphlet" style="display:none;" >
                <div class="row pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line" style="font-size: 110%"><i class="fa fa-flask"></i> <span>我的造句</span></h4>
                    </div>
                </div>

                <div class="crisp-my-box row">
                    <div class="col-md-12 box-content" id="megaPamphletSearcher">

                    </div>

                    <div class="col-sm-12">
                        <div class="crisp-my-box">
                            <div class="predate-sys-rendered">
                                <script type="text/html" id="tplMegaList">
                                    <# var nEnum = 1;
                                    for( var i in sentenceList ) {
                                    var row           = sentenceList[i];
                                    var note          = row["ph_note"];
                                    var classId       = row["index_of"];
                                    var szModifyHref  = "<%=thisPage.spawnActionQuerySpell("sentenceModify")%>&mega_id=" + row['mega_id'] + "&class_id=" + classId;
                                    var szPamHref     = "<%=thisPage.spawnActionQuerySpell("sentenceList")%>&class_id=" + classId;
                                    #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box row">
                                                <div class="col-md-12 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <input type="checkbox" name="massDelete" value="<#=row['id']#>"  style="width: 15px">
                                                        <#=$fnEnumGet().now( nEnum++ )#>.
                                                        <a href="<#=szModifyHref#>"><strong><#=$fnSubstr( row['s_sentence'], 0, 60 )#></strong></a>

                                                        <a class="btn btn-primary btn-sharp" style="float: right;margin-left: 1%" data-toggle="modal" href="#modalDeleteOne<#=row['id']#>"><i class="fa fa-trash-o"></i></a>
                                                        <a class="btn btn-warning btn-sharp" style="float: right;margin-left: 1%" href="" title="标记遗忘"><i class="fa fa-tag"></i></a>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-6" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <p style="margin-top: -1%" class="p-g-w-def">
                                                                <a href="<#=szPamHref#>" target="_blank"><i class="fa fa-map-marker" style="cursor: pointer"></i></a>
                                                                <#= $fnSubstr( row["s_cn_def"],0,45 )#>
                                                            </p>
                                                        </div>
                                                        <div class="col-sm-4" style="border-right: 1px solid #dddddd;margin-bottom: 1%">
                                                            <#  var words = row["words"];
                                                            for( var i = 0; i < words.length; i++ ){
                                                            var szWord = words[i];
                                                            #>
                                                            <a href="<%=szWordQuerySpell%><#=szWord#>" target="_blank" ><#=szWord#></a><#=( i !== words.length-1 ? ';' : '')#>
                                                            <#} if( words.length < 1 ) { #>
                                                            <a href="<#=szModifyHref#>">添加关键词</a>
                                                            <#} #>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <p style="margin-top: -1%">
                                                                <span style="float: right"><i class="fa fa-clock-o"></i> <#=row["s_add_date"]#></span>
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <div class="modal fade crisp-union-win" id="modalDeleteOne<#=row['id']#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title" >是否删除</h4>
                                                                </div>
                                                                <div class="modal-body"><h4>您确实要删除该句子 "<#= $fnSubstr( row['s_sentence'], 0, 60 )#>" 吗?</h4></div>
                                                                <div class="modal-footer">
                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteOneSentence")%>&id=<#=row['id']#>"><button class="btn btn-danger">确定</button></a>
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
<script src="/root/root/System/equipment/KeyWordList.js"></script>
<script src="/root/root/System/elements/pamphlet/pamphlet.js"></script>
<script src="/root/root/System/elements/pamphlet/sentence.js"></script>
<script src="/root/assets/js/plugins/Chart.min.js"></script>
${SingleImgUploader}
<script>
    var pageData = ${szPageData};
    $_Predator( pageData, {
        "init"   : function ( parent ){ },
        "genies" : function( parent ){
            $_CPD({
                "pamphletList"       : {
                    title: "句子列表",
                    fn: function( parent ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                if( !$isTrue( pageData['userPamphletList']  ) ){
                                    return 0;
                                }
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "renderSentenceList":function (self) {
                                self.genieData["userPamphletList"] = pageData["userPamphletList"];
                                self.renderById("tplPamphletTable");
                            },
                            "afterRendered": function ( self ) {
                                pageData.fnSearchGlossaryName = function () {
                                    Predator.searcher.bindSingleSearch( "g_word", "#gNameSearch", true );
                                };
                                pageData.fnSearchGlossaryAuthority = function () {
                                    Predator.searcher.bindSingleSearch( "g_authority", "#glossaryAuthority", true );
                                };
                                if( $_GET["ph_word"] || $_GET["ph_authority"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "pamphletDeviser"    : {
                    title: "新建造句本",
                    fn: function () {
                        $_PINE("#newPamphletCoverField").append("<p style='margin-left: 21%'>推荐大小255*255,图片最大512KB.</p>");
                    }
                },

                "pamphletEditor"     : {
                    title:"修改造句本",
                    fn: function (parent) {
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

                "pamphletCollection" : {
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
                                    Predator.searcher.bindSingleSearch( "g_word", "#gcNameSearch", true );
                                };
                                if( $_GET["g_word"] ){
                                    $_PINE( parent.spawnSubSelector(".box-content")).show();
                                }
                            }
                        })
                    }
                },

                "pamphletClone"      : {
                    title: "造句本克隆",
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

                "sentenceList"       : {
                    title: "造句本内容",
                    fn: function ( wizard ) {
                        var bReadonly   = pageData["bgReadonly"];
                        var szReferHref = encodeURIComponent( "?" + pPine.Http.getQueryString() );
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                Predator.wizard.conjurer.superBtn.summoned( bReadonly ? "pamphletCollection" : wizard.mDefaultChild );
                                self.genieData["bReadonly"      ] = bReadonly;
                            },
                            "renderPamphlet": function (self) {
                                self.genieData["SentenceProfile"] = pageData["SentenceProfile"];
                                self.genieData["nWordSum"       ] = pageData["nPageDataSum"];
                                self.genieData["szMakeSentHref" ] = Predator.spawnActionQuerySpell("makeSentence") + "&class_id=" + $_GET[ "class_id" ] + "&referHref=" + szReferHref;
                                self.renderById("tplSentenceProfile");
                                $EP_Sentence.renderSentenceSearcher();
                                $EP_Pamphlet.renderDailySearch( "#daily_type", "s_add_date" );
                            },
                            "renderSentenceContent": function (self) {
                                var hList = pageData[ "SentenceList" ];
                                if( hList.length > 0 ) {
                                    var sMap = Predator.elements.pamphlet.sentence.multiplSentence2Map( hList );
                                    self.genieData[ "classId"      ]   = $_GET["class_id"];
                                    self.genieData[ "sentenceList" ]   = sMap;
                                    self.genieData[ "$fnEnumGet"   ]   = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"    ]   = Predator.auxiliary.substr;
                                    self.genieData[ "referHref"    ]   = szReferHref;

                                    self.renderById("tplSentenceWordList");
                                }
                                else {
                                    $_PINE("#tplSentenceWordList").parent().html( Predator.tpl.notice.simpleNoData );
                                }
                            },
                            "afterListRendered" : function ( self ) {
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                                Predator.elements.pamphlet.sentence.registerListAction( pageData, self );
                                Predator.smartMassDeleteListener( "sentenceMassDelete" );
                            }
                        });
                    }
                },

                "makeSentence"       : {
                    title: "新建造句",
                    fn: function () {
                        var KeyWordList = Predator.equipment.ui.KeyWordList;
                        pageData.$hKeyWordListBox = KeyWordList.spawn( "#sentsNewKeyWordListBox", "en_word", 8 );
                    }
                },

                "sentenceModify"     : {
                    title: "查看编辑造句",
                    fn: function () {
                        if( $isTrue( pageData['SentenceInfo'] ) ){
                            $_PMVC.formDynamicRenderer( pageData['SentenceInfo'][0], "Modify", null );

                            var keyWordList = Predator.equipment.ui.KeyWordList;
                            pageData.$hKeyWordListBox = keyWordList.spawn( "#sentsNewKeyWordListBoxModify", "en_word", 8 );
                            var hSentenceWordsInfo = pageData[ "SentenceWordsInfo" ];
                            if( $isTrue( hSentenceWordsInfo ) ){
                                for ( var i = 0; i < hSentenceWordsInfo.length; i++ ) {
                                    pageData.$hKeyWordListBox.fnAdd( hSentenceWordsInfo[i][ "en_word" ] );
                                }
                            }
                        }
                    }
                },

                "megaPamphlet"       : {
                    title: "我的超级句库",
                    fn   : function ( wizard ) {
                        Predator.wizard.smartGenieInstance(this, {
                            "init": function (self) {
                                var hSentenceListSearcher = $_PINE( "#sentenceListSearcher" );
                                hSentenceListSearcher.remove();
                                $_PINE( "#megaPamphletSearcher" ).html( hSentenceListSearcher.html() );
                            },
                            "renderSentenceContent": function (self) {
                                var hList = pageData[ "SentenceList" ];
                                if( hList.length > 0 ) {
                                    var sMap = Predator.elements.pamphlet.sentence.multiplSentence2Map( hList );

                                    self.genieData[ "sentenceList" ]   = sMap;
                                    self.genieData[ "$fnEnumGet"]      = Predator.paginate.rowEnumCounter;
                                    self.genieData[ "$fnSubstr"]       = Predator.auxiliary.substr;
                                    self.renderById("tplMegaList");
                                }
                                else {
                                    $_PINE("#tplMegaList").parent().html( Predator.tpl.notice.simpleNoData );
                                }
                            },
                            "afterWordListRendered" : function ( self ) {
                                $EP_Sentence.renderSentenceSearcher();
                                Predator.paginate.smartMount( wizard.spawnSubSelector(".crisp-paginate ul"), pageData );
                                Predator.elements.pamphlet.sentence.registerListAction( pageData, self );
                                Predator.smartMassDeleteListener( "sentenceMassDelete" );
                            }
                        });
                    }
                },

            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );

                        if( who === 'makeSentence' || who === 'sentenceModify' ) {
                            $_PINE( "#" + who + "ReferHref" ).val( $_GET["referHref"] );
                        }

                        if( who === 'megaPamphlet' ){
                            who = "sentenceList";
                        }
                        $_PINE( "#band_type" ).append( Predator.vocabulary.band.assembleSelector() );
                        pageData.fnSearchLinkedWord = function () {
                            Predator.searcher.bindSingleSearch( "linkedWord", "#"+ who +"LinkedWord", true );
                        };
                        pageData.fnSearchKeyWord = function () {
                            Predator.searcher.bindSingleSearch( "keyWord", "#"+ who +"KeyWord", true );
                        };
                        pageData.fnSetPageLimit = function () {
                            Predator.searcher.bindSingleSearch( "pageLimit", "#"+ who +"PageLimit", true );
                        };
                        pageData.fnSiftBand = function(){
                            Predator.searcher.bindSingleSearch( "band_type", "#band_type", true );
                        };
                        pageData.fnPlaySentence = function (){
                            var s = $_PINE( "#" + who + " .p-make-sent" ).val();
                            Predator.vocabulary.phonetic.audioPlay( s, 1 );
                        };
                        pageData.fnKeyWordify = function (){
                            var s = $_PINE( "#" + who + " .p-make-sent" ).val();
                            $.ajax({
                                url:   Predator.spawnActionQuerySpell("getKeyWords"),
                                async:    false,
                                type:     "GET",
                                dataType: "json",
                                data:     { "invoker": Predator.getWizard(), "query": $_GET["query"], "sentence": s },
                                success: function (result) {
                                    var data = result[ "keyWords" ];
                                    if( $isTrue( data ) ){
                                        trace( data );
                                        var nMax = data.length > 8 ? 8 : data.length;
                                        for ( var i = pageData.$hKeyWordListBox.mnCountNum; i < nMax; i++ ) {
                                            var szWord = data[ i ];
                                            pageData.$hKeyWordListBox.fnAdd( szWord );
                                        }
                                    }
                                },
                                error: function (result) {
                                    console.warn( result );
                                }
                            });
                        };
                        pageData.fnTranslateSent = function () {
                            Predator.elements.sentence.translate( $_PINE( "#" + who + " .p-make-sent" ).val(), function ( data ) {
                                if( data.errorCode === 0 ){
                                    $_PINE( "#" + who + " textarea[name='s_cn_def']" ).val( data["translation"] );
                                }
                            } );
                        }
                    }
                };
            }).summon(Predator.getAction());
        },
        "final"  : function( parent ){
            Predator.page.surveyQueryStrAndBind({
                "pageLimit"   : [ "#sentenceListPageLimit","#glossaryListPageLimit", "#wordsRankPageLimit" ],
                "keyWord"     : [ "#sentenceListKeyWord" ],
                "linkedWord"  : [ "#sentenceListLinkedWord" ],
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