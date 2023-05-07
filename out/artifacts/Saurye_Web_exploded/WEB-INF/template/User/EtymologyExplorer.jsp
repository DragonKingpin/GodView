<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    String szGeniusExplorerName       = "GeniusExplorer";
    JSONObject $_GSC = thisPage.$_GSC();
    JSONObject proto = thisPage.getModularConfig();
    String szWordQuerySpell = thisPage.querySpell().queryWord( $_GSC.optString( "query" ) );
%>
${StaticHead}

<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <%=proto.optString("cnName")%> >> <label id="pageNodeTitle">%s</label>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-2">
                <div id="ButtonsControl" class="crisp-union-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%"><i class="fa fa-list"></i><span> 传送门</span></h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnWizardActionSpell( szGeniusExplorerName, null )%>">
                                    <div class="header">
                                        <i class="fa fa-book"></i>
                                    </div>
                                    <div class="content" style="font-size: 140%">词汇检索</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn green-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnWizardActionSpell( szGeniusExplorerName, "fragmentSearch" )%>">
                                    <div class="header">
                                        <i class="fa fa-cogs"></i>
                                    </div>
                                    <div class="content" style="font-size: 140%">词根检索</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                    <div class="header">
                                        <i class="fa fa-eyedropper"></i>
                                    </div>
                                    <div class="content" id="wordEtymologySearchIndexLabel" style="font-size: 140%">词源检索</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn dark-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnWizardActionSpell( "GeniusTranslator", null )%>">
                                    <div class="header">
                                        <i class="fa fa-magic"></i>
                                    </div>
                                    <div class="content" style="font-size: 140%">魔法翻译</div>
                                </a>
                            </div>
                        </div>


                    </div>
                </div>
            </div>

            <div class="col-sm-10">
                <div class="crisp-my-box" id="wordEtymologySearch" style="display: none">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="tab-pane fade active in" id="crewMega">
                                <div class="table-responsive" style="color: black;">
                                    <div class="crisp-my-box">
                                        <div class="row pad-botm">
                                            <div class="col-md-12">
                                                <h4 class="header-line">
                                                    <i class="fa fa-random"></i><span>词态变化</span>
                                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                                        <i class="fa fa-angle-down"></i>
                                                    </a>
                                                </h4>
                                            </div>
                                        </div>

                                        <div class="box-content">
                                            <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                                <tbody style="text-align: center">
                                                <script type="text/html" id="tplEtymologyGradeList">
                                                    <# for( var weight in etymologyGrade) {
                                                    GradeList = etymologyGrade[weight]["cn_def"];
                                                    DerivedList = etymologyGrade[weight]["en_derived"];
                                                    #>
                                                    <tr>
                                                        <td><#=weight#></td>
                                                        <td>
                                                            <# for( var cn in GradeList ){
                                                            var en_derived = GradeList[cn];
                                                            #>
                                                            <span style="margin-right: 40px"><a onclick="pageData.fnSetGrade( '<#=en_derived#>')"><#=cn#></a></span>
                                                            <%--<span style="margin-right: 40px">技术人才</span>--%>
                                                            <%--<span style="margin-right: 40px">创意型人才</span>--%>
                                                            <%--<span style="margin-right: 40px">管理型人才</span>--%>
                                                            <%--<span style="margin-right: 40px">执行型人才</span>--%>
                                                            <%--<span style="margin-right: 40px">综合人才</span>--%>
                                                            <%--<a class="box-down" href="javascript:void(0)" style="float: right">--%>
                                                            <%--<i class="fa fa-angle-down"></i> 更多--%>
                                                            <%--</a>--%>
                                                            <#}#>
                                                        </td>
                                                    </tr>
                                                    <#}#>
                                                </script>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class = "form-group com-group-control-search">
                                        <label>单词</label>
                                        <input type="text" name="kw" class="form-control" id="wordEtymologySearchKeyWord" placeholder="请输入单词，带'%'为模糊查找" onkeydown="pageData.fnSearchKeyWord()" />
                                        <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWord()">
                                            <i class="fa fa-search"></i>
                                        </a>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12" id="mainSearchZone">
                                            <div class = "form-group com-group-control-search">
                                                <label>关联语言标签</label>
                                                <div class="row" style="text-align: center">
                                                    <div class="col-sm-2">
                                                        <div class="alert alert-success" style="margin-bottom:0;padding: 5px;">
                                                            <a class="close" data-dismiss="alert" href="#">×</a>
                                                            <strong>综合人才</strong>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <div class="alert alert-success" style="margin-bottom:0;padding: 5px;">
                                                            <a class="close" data-dismiss="alert" href="#">×</a>
                                                            <strong>三资企业</strong>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <div class="alert alert-success" style="margin-bottom:0;padding: 5px;">
                                                            <a class="close" data-dismiss="alert" href="#">×</a>
                                                            <strong>交际</strong>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <div class="alert alert-success" style="margin-bottom:0;padding: 5px;">
                                                            <a class="close" data-dismiss="alert" href="#">×</a>
                                                            <strong>才艺</strong>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-12" style="border-bottom: 1px solid #E4E4E4;margin-top: 0;margin-bottom: 1%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="panel panel-default boxUncertain" style="border-radius: 0;margin-bottom: 0;text-align: center" >
                            <div class="panel-body">
                                <h1 id="info">What do you want?</h1>
                            </div>
                        </div>

                        <div class="crisp-my-box" id="wordEtymologySearchBox" style="display: none">
                            <div class="crisp-my-box" >

                                <script type="text/html" id="tplWordEtymonSearchList" >
                                    <# var nEnum = 1;
                                    for( var szWord in etymologyDefs ){
                                    var wordEtymonInfo = wordEtymonList[ szWord ];
                                    #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box">
                                                <div class="col-sm-1" style="text-align: center">
                                                    <h1 style="margin-left: 10px"><#=$fnEnumGet().now( nEnum++ )#></h1>
                                                </div>
                                                <div class="col-md-11 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <a href="?do=WordExplicater&action=etymologyRoots&query=<#=szWord#>"><strong><#=szWord#></strong></a>
                                                    </p>
                                                    <hr>

                                                    <div class="row">
                                                        <div class="col-sm-12" style="margin-bottom: 3%">
                                                            <p style="margin-top: -1%"><i class="fa fa-tag"></i>
                                                                <#=etymologyDefs[szWord]["com_defs"]#>
                                                            </p>
                                                            <p style="margin-top: -1%"><i class="fa fa-bookmark"></i> 关联语言：
                                                                <#  var ikw = 0, lkw = $fnSizeof( wordEtymonInfo["keyWord"] );
                                                                for( var okw in wordEtymonInfo["keyWord"] ) {#>
                                                                <label class="alert-success alert crisp-tiny-tag" style="padding:3px 10px;"><#=okw#></label>
                                                                <#} #>
                                                            </p>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <#} #>
                                </script>

                            </div>

                            <div class="row crisp-my-box">
                                <div class="col-sm-4 ">
                                    <div class="form-group com-group-control-search">
                                        <label for="wordEtymologySearchPageLimit" style="width: 23%">每页: </label>
                                        <input class="form-control" id="wordEtymologySearchPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
                                        <a href="javascript:pageData.fnSetPageLimit()" class="btn btn-default" style="width: 25%">设置</a>
                                    </div>
                                </div>
                                <div class="col-sm-8 crisp-margin-ui-fault-tolerant-2">
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
</div>

${StaticFooter}
<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/bootstrap.js"></script>
<script src="/root/assets/js/art-template.js"></script>
<script src="/root/assets/js/plugins/Chart.min.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script>

    var pageData = ${szPageData};
    $_Predator( pageData, {
        "init": function ( parent ) {
            Predator.page.surveyQueryStrAndBind( {"pageLimit": [ "#wwordEtymologySearchPageLimit"] } );
        },
        "genies": function ( parent ){
            $_CPD({
                "wordEtymologySearch": {
                    title: "魔法词源",
                    fn: function(parent) {
                        var szKey = $_GET[ "kw" ];

                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {},
                            "rendererEtymonGrade":function (self) {
                              var hEtmonList = pageData["EtymonGrade"];
                              if(hEtmonList.length  > 0){
                                  var sMap = {};
                                  for( var i = 0;i<hEtmonList.length; i++){
                                    var row = hEtmonList[i];
                                    var szType = row["en_weight"];
                                    var szEn   = row["en_derived"];
                                    var szCn   = row["cn_def"];
                                    sMap[ szType ] = pPine.Objects.affirmObject( sMap[szType] );
                                    sMap[ szType ]["cn_def"] = pPine.Objects.affirmObject( sMap[szType]["cn_def"]);
                                    sMap[ szType ]["cn_def"][szCn] = szEn;
                                  }
                                  self.genieData["etymologyGrade"] = sMap;
                                  trace(sMap);
                                  self.genieData[ "$fnSizeof" ] = sizeof;
                                  self.genieData[ "$fnEnumGet"] = Predator.paginate.rowEnumCounter;
                                  self.renderById( "tplEtymologyGradeList" );
                              }

                            },
                            "rendererEach": function ( self ) {
                                if( szKey ){
                                    var hList = pageData["WordExplication"][ "relevantSimple" ];
                                    var hList2 = pageData["WordExplication"][ "etymologyDefs" ];
                                    if( hList.length > 0 ) {
                                        var sMap = {};
                                        for ( var i = 0; i < hList.length; i++ ) {
                                            var row = hList[i];
                                            var szType = row["en_word"];
                                            var szCnW  = row["ety_relevant"];
                                            sMap[ szType ] = pPine.Objects.affirmObject( sMap[ szType ] );
                                            sMap[ szType ][ "keyWord" ]   = pPine.Objects.affirmObject( sMap[ szType ][ "keyWord" ]  );
                                            sMap[ szType ][ "keyWord" ][szCnW] = true;
                                        }
                                        var sMap1 = {};
                                        for( var i =0; i< hList2.length; i++){
                                            var row = hList2[i];
                                            var szType = row["en_word"];
                                            sMap1[ szType ] = pPine.Objects.affirmObject( sMap1[ szType ] );
                                            sMap1[ szType ]["com_defs"] = row["com_def"];
                                        }
                                        trace(sMap);
                                        self.genieData[ "$fnSizeof" ] = sizeof;
                                        self.genieData[ "$fnEnumGet"] = Predator.paginate.rowEnumCounter;
                                        self.genieData["etymologyDefs"] = sMap1;
                                        self.genieData[ "wordEtymonList" ]  = sMap;
                                        self.renderById( "tplWordEtymonSearchList" );
                                    }
                                }
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                            },
                            "afterListRendered": function ( self ) {
                                pageData.fnPhoneticAudioPlay = function ( w, t ){
                                    Predator.vocabulary.phonetic.audioPlay( w, t );
                                };
                            }
                        } );
                    }
                },
            }).beforeSummon( function ( cpd ) {
                cpd.afterGenieSummoned = function ( who ) {
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );
                    }

                    var szKey = $_GET[ "kw" ];
                    $_PINE( "#"+ who +"KeyWord" ).val( szKey );
                    pageData.fnSearchKeyWord = function () {
                        Predator.searcher.bindSingleSearch( "kw", "#"+ who +"KeyWord", true );
                    };
                    pageData.fnSetPageLimit = function () {
                        Predator.searcher.bindSingleSearch( "pageLimit", "#"+ who +"PageLimit", true );
                    };
                    pageData.fnSetGrade = function (szDBName) {
                        this.mszDBName = szDBName;
                        this.mhURLs    = {};
                        this.mhURLs[ szDBName ] = szDBName;
                        window.location = Pinecone.Navigate.urlAutoMerge( this.mhURLs, $_GET );
                    };
                    ( function afterKeyWordGiven ( frag ) {
                        if( szKey ){
                            $_PINE("#" + frag + " .boxUncertain").hide();
                            $_PINE("#" + frag + "Box" ).show();
                        }
                    })( who );
                };
            }).summon(Predator.getAction());
        }
    });

</script>
${StaticPageEnd}