<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC = thisPage.$_GSC();
%>
${StaticHead}

<style>
    .predator-novel-info-box {
        min-height: 250px
    }.predator-novel-info-box .p-avatar-field {
         text-align: center;
     }.predator-novel-info-box .p-sign-introduce {
          margin-left: 12px; font-size: 21px; white-space: nowrap;
      }.predator-novel-info-box img{
           border: 3px solid #ccc;display: inline;height: 170px;
       }.predator-novel-info-box h2{
            margin-top: 0; margin-bottom: 14px; font-size: 24px;
        }.predator-novel-info-box h3{
             margin-top: 0;
         }.predator-novel-info-box h4{
              font-size: 13px;  margin-top: 0; margin-bottom: 9px; font-weight: 500;
          }.predator-novel-info-box i{
               margin-right: 12px; color: grey; min-width: 20px;
           }.predator-novel-info-box .p-more-info{
                color: #8590a6; margin-top: 12px;
            }

</style>

<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label>魔法小说</label> >> <label id="pageNodeTitle"></label>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class = "form-group com-group-control-search">
                    <label>关键字</label>
                    <input type="text"  class="form-control" id="keyWord" placeholder="请输入小说名或作者关键字" onkeydown="pageData.fnSearchKeyWordMain()" />
                    <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWordMain()">
                        <i class="fa fa-search"></i>
                    </a>
                </div>
                <div class="col-sm-12" style="border-bottom: 1px solid #E4E4E4;margin-top: 0;margin-bottom: 1%"></div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-12" id="novelList" style="display:none;" >
                <div class="crisp-my-box">
                    <div class="row">
                        <script type="text/html" id="tplNovelGrimoireList">
                            <#for ( var k in NovelList ){
                            var row      = NovelList[k]   ;
                            var en_title = row["en_title"];
                            var index    = row["id"];
                            var imgurl   = row["n_img"];
                            #>
                            <div class="col-md-6">
                                <div class="panel panel-default btn-sharp">
                                    <div class="panel-body" style="height: 200px">
                                        <div class="predator-novel-info-box" >
                                            <div class="col-md-4 p-avatar-field" >
                                                <img id="user-index-avatar" class="img-responsive" src="<#=imgurl#>" alt="" onerror="this.src='/root/root/System/img/noimg.jpg'">
                                            </div>
                                            <div class="col-md-8">
                                                <h3 style="font-size: 20px">
                                                    <span><a href="<%=thisPage.spawnActionQuerySpell("novelProfile")%>&en_title=<#=en_title#>&index=<#=index#>"><#=en_title#></a></span>
                                                </h3>
                                                <h4>中文名: <#=row["cn_title"]#></h4>
                                                <h4>作者: <a href="<%=thisPage.spawnActionQuerySpell()%>&keyWord=<#=row['n_author']#>"><#=row["n_author"]#></a>
                                                    <#if( row["cn_name"] !=='' ){#>
                                                    (<#=row["cn_name"]#>)</h4>
                                                    <#} #>
                                                </h4>

                                                <h4>简介:<#=row["note"]#><#if(row["note"].length > 99){ #>...<#} #></h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <#}#>
                        </script>
                    </div>
                </div>

                <div class="col-sm-12 crisp-margin-ui-fault-tolerant-2">
                    <div class="crisp-paginate">
                        <ul class="pagination"></ul>
                    </div>
                </div>
            </div>

            <div class="col-sm-12" id="novelProfile" style="display: none;" >
                <script type="text/html" id="tplNovelChapters">
                    <# var img_url = NovelInfo[0]["img_url"];
                    var en_title= NovelInfo[0]["en_title"];#>
                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" style="height: 200px">
                            <div class="predator-novel-info-box">
                                <div class="col-md-2 p-avatar-field">
                                    <img id="book_img" class="img-responsive" src="<#=img_url#>"  onerror="this.src='/root/root/System/img/noimg.jpg'">
                                </div>
                                <div class="col-md-10">
                                    <h3 style="font-size: 25px">
                                        <span><a><#=NovelInfo[0]["en_title"]#></a></span>
                                    </h3>
                                    <h4>中文名: <#=NovelInfo[0]["cn_title"]#></h4>
                                    <#if( NovelInfo[0]["cn_name"] !=='' ){#>
                                    <h4>作者: <a><#=NovelInfo[0]["n_author"]#></a>(<#=NovelInfo[0]["cn_name"]#>)</h4>
                                    <#}else{#>
                                    <h4>作者: <a><#=NovelInfo[0]["n_author"]#></a></h4>
                                    <#}#>
                                    <h4>简介: <#=NovelInfo[0]["note"]#></h4>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h2>书籍目录</h2>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover predator-fat-table-simple">
                            <tbody>
                            <# var i = 1;
                            for (var k in NovelChapters) {
                            var row = NovelChapters[k];
                            var chapter = row["chapters"];
                            #>
                            <tr><td>
                                <#=i++#>. <a href="<%=thisPage.spawnWizardQuerySpell("NovelExhibitor")%>&novel=<#=en_title#>&chapter=<#=k#>" target="_blank"><#=chapter#></a>
                            </td></tr>
                            <#}#>
                            </tbody>
                        </table>
                    </div>

                </script>
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
<script src="/root/assets/js/plugins/Chart.min.js"></script>
<script>
     var pageData = ${szPageData};

    $_Predator( pageData, {
        "init":function ( parent ){
            Predator.page.surveyQueryStrAndBind({
                "keyWord"   : [ "#keyWord" ]
            });
        },
        "genies":function( parent ){
            $_CPD({
                "novelList":{
                    title: "小说列表",
                    fn: function(parent){
                        Predator.wizard.smartGenieInstance( this , {
                            "init" : function ( self ){
                                self.genieData["NovelList"] = pageData["NovelList"];
                            },
                            "renderNovelList" :function (self) {
                                self.renderById("tplNovelGrimoireList");
                            },
                            "afterRender":function (self) {
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            }
                        })
                    }
                },

                "novelProfile":{
                    title: "章节列表",
                    fn: function(parent){
                        Predator.wizard.smartGenieInstance( this , {
                            "init" : function ( self ){
                                trace( pageData["NovelChapters"] );
                                self.genieData["NovelChapters"] = pageData["NovelChapters"];
                                self.genieData["NovelInfo"]     = pageData["NovelInfo"];
                            },
                            "renderBuildList" : function (self) {
                                self.renderById("tplNovelChapters");
                            }
                        })
                    }
                },
            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        pageData.fnSearchKeyWordMain = function () {
                            Predator.logicControl.bindRedirector(
                                '#keyWord',
                                Predator.spawnActionQuerySpell() + "&keyWord="
                            );
                        };
                    }
                };
            }).summon(Predator.getAction());
        },
        "final":function( parent ){
        }
    });

</script>
${StaticPageEnd}