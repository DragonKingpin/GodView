<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
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
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <%=proto.optString("cnName")%> >> <label id="pageNodeTitle">%s</label>
                </h4>
            </div>
        </div>

        <div class="row">

            <div class="col-sm-2">
                <div id="ButtonsControl" class="crisp-union-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%"><i class="fa fa-list"></i><a href="javascript:void(0)" class="predator-left-super-menu-clip"> 传送门</a></h4>
                        </div>
                    </div>
                    <div class="row predator-left-super-menu" >
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                    <div class="header">
                                        <i class="fa fa-book"></i>
                                    </div>
                                    <div class="content" id="wordSearchIndexLabel" style="font-size: 140%">词汇检索</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn green-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("fragmentSearch")%>">
                                    <div class="header">
                                        <i class="fa fa-cogs"></i>
                                    </div>
                                    <div class="content" id="fragmentSearchIndexLabel" style="font-size: 140%">词根检索</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnWizardActionSpell( "EtymologyExplorer", null )%>">
                                    <div class="header">
                                        <i class="fa fa-eyedropper"></i>
                                    </div>
                                    <div class="content" style="font-size: 140%">词源检索</div>
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
                <div class="crisp-my-box" id="wordSearch" style="display: none">
                    <div class="row">
                        <div class="col-md-12">
                            <div class = "form-group com-group-control-search">
                                <label>关键字</label>
                                <input type="text" name="kw" class="form-control" id="wordSearchKeyWord" placeholder="请输入关键字，带'%'为模糊查找" onkeydown="pageData.fnSearchKeyWord()" />
                                <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWord()">
                                    <i class="fa fa-search"></i>
                                </a>
                            </div>
                            <div class="col-sm-12" style="border-bottom: 1px solid #E4E4E4;margin-top: 0;margin-bottom: 1%"></div>
                        </div>
                    </div>

                    <div class="panel panel-default boxUncertain" style="border-radius: 0;margin-bottom: 0;text-align: center" >
                        <div class="panel-body">
                            <h1 id="info">What do you want?</h1>
                        </div>
                    </div>

                    <div class="crisp-my-box" id="wordSearchBox" style="display: none">
                        <div class="crisp-my-box" >

                            <script type="text/html" id="tplWordSearchList" >
                                <# var nEnum = 1;
                                   for( var szWord in wordList ){
                                        var wordInfo = wordList[ szWord ];
                                #>
                                <div class="panel panel-hr">
                                    <div class="panel-body" style="padding: 0">
                                        <div class="crisp-news-box">
                                            <div class="col-md-12 crisp-my-profile">
                                                <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                    <input type="checkbox" name="massSelected" value="<#=szWord#>"  style="width: 15px">
                                                    <#=$fnEnumGet().now( nEnum++ )#>.
                                                    <a href="<%=szWordQuerySpell%><#=szWord#>" target="_blank"><strong><#=szWord#></strong></a>
                                                    <span style="float: right"><i class="fa fa-plus"></i>&nbsp;单词本</span>
                                                </p>
                                                <hr>

                                                <div class="row">
                                                    <div class="col-sm-6" style="border-right: 1px solid #dddddd;margin-bottom: 3%">
                                                        <p style="margin-top: -1%"><i class="fa fa-tag"></i>
                                                            读音：
                                                            <#if(wordInfo.hasOwnProperty("uk_phonetic")){#>
                                                            <span>英: [<#=wordInfo["uk_phonetic"]#>] </span><a class="fa fa-volume-up" style="margin-right: 5%" href="javascript:pageData.fnPhoneticAudioPlay('<#=szWord#>',1);"></a>
                                                            <#}#>
                                                            <#if(wordInfo.hasOwnProperty("us_phonetic")){#>
                                                            <span>美: [<#=wordInfo["uk_phonetic"]#>] </span><a class="fa fa-volume-up" href="javascript:pageData.fnPhoneticAudioPlay('<#=szWord#>',2);"></a>
                                                            <#}#>
                                                        </p>
                                                        <#for( var cn_def in wordInfo["defs"] ) {#>
                                                        <p style="margin-top: -1%"><i class="fa fa-tag"></i> <#=wordInfo["defs"][cn_def]["pos"]#>. <#=cn_def#></p>
                                                        <#} #>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <p style="margin-top: -1%"><i class="fa fa-bookmark"></i> <#=wordInfo["band"]?wordInfo["band"]:"So profound that has no band "#></p>
                                                        <p style="margin-top: -1%"><i class="fa fa-bookmark"></i> 词频排位：<#=wordInfo["freq"]#> / 130K</p>
                                                        <p style="margin-top: -1%"><i class="fa fa-bookmark"></i> 其他关键字：
                                                            <#  var ikw = 0, lkw = $fnSizeof( wordInfo["keyWord"] );
                                                                for( var okw in wordInfo["keyWord"] ) {#>
                                                                <#=okw#>
                                                                <#if( ++ikw != lkw ){ #> , <#}#>
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
                                    <label for="wordSearchPageLimit" style="width: 23%">每页: </label>
                                    <input class="form-control" id="wordSearchPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
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

                <div class="crisp-my-box" id="fragmentSearch" style="display:none;">
                    <div class="row">
                        <div class="col-md-12">
                            <div class = "form-group com-group-control-search">
                                <label>词根</label>
                                <input type="text" id="fragmentSearchKeyWord" name="kw" class="form-control" placeholder="请输入关键字，带'%'为模糊查找" onkeydown="pageData.fnSearchKeyWord()" />
                                <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWord()" >
                                    <i class = "fa fa-search"></i>
                                </a>
                            </div>
                            <div class="col-sm-12" style="border-bottom: 1px solid #E4E4E4;margin-top: 0;margin-bottom: 1%"></div>
                        </div>
                    </div>

                    <div class="panel panel-default boxUncertain" style="border-radius: 0;margin-bottom: 0;text-align: center" >
                        <div class="panel-body">
                            <h1 id="fragmentInfo">What do you want?</h1>
                        </div>
                    </div>

                    <div class="crisp-my-box" id="fragmentSearchBox" style="display: none">
                        <div class="crisp-my-box">
                            <script type="text/html" id = "tplFragmentList">
                                <#
                                var nEnum = 1;
                                for(var key in searchFragmentList) {
                                var f_en = searchFragmentList[key][ "f_en" ];
                                #>
                                    <div class="panel panel-hr">
                                        <div class="panel-body" style="padding: 0">
                                            <div class="crisp-news-box">
                                                <div class="col-sm-1" style="text-align: center">
                                                    <h1 style="margin-left: 10px"><#=$fnEnumGet().now( nEnum++ )#></h1>
                                                </div>
                                                <div class="col-md-11 crisp-my-profile">
                                                    <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%">
                                                        <a href="?do=FragmentExplicater&query=<#=f_en#>"><strong><#=f_en#></strong></a>
                                                        <span style="float: right"><i class="fa fa-plus"></i>&nbsp;词根本</span>
                                                    </p>
                                                    <hr/>
                                                    <p style="margin-top: -1%"><strong>中文简译:</strong>
                                                        <#if( searchFragmentList[key]["f_cn"]!==undefined){#>
                                                            <span><#=searchFragmentList[key]["f_cn"]#></span>
                                                        <#}else{#>
                                                            <span>无</span>
                                                        <#}#>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <#}#>
                            </script>
                        </div>

                        <div class="row crisp-my-box">
                            <div class="col-sm-4 ">
                                <div class="form-group com-group-control-search">
                                    <label for="fragmentSearchPageLimit" style="width: 23%">每页: </label>
                                    <input class="form-control" id="fragmentSearchPageLimit" type="text" value="30" placeholder="输入条数限制" maxlength="10" style="width: 50%" onkeydown="pageData.fnSetPageLimit();">
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
            Predator.page.surveyQueryStrAndBind( {"pageLimit": [ "#wordSearchPageLimit", "#fragmentSearchPageLimit" ] } );
        },
        "genies": function ( parent ){
            $_CPD({
                "wordSearch": {
                    title: "词汇检索",
                    fn: function(parent) {
                        var szKey = $_GET[ "kw" ];

                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {},
                            "rendererEach": function ( self ) {
                                if( szKey ){
                                    var hList = pageData[ "WordsList" ];
                                    if( hList.length > 0 ) {
                                        var sMap = {};
                                        for ( var i = 0; i < hList.length; i++ ) {
                                            var row = hList[i];
                                            var szType = row["en_word"];
                                            var szCnD  = row["cn_means"];
                                            var szCnW  = row["cn_word"];
                                            var nFreq  = row["w_freq_base"] ? row["w_freq_base"] : 1e8;
                                            sMap[ szType ] = pPine.Objects.affirmObject( sMap[ szType ] );
                                            if( sMap[ szType ][ "freq" ] === undefined ){
                                                sMap[ szType ][ "freq" ] = nFreq;
                                            }
                                            else {
                                                sMap[ szType ][ "freq" ] = Math.min( sMap[ szType ][ "freq" ], nFreq );
                                            }
                                            sMap[ szType ][ "keyWord" ]   = pPine.Objects.affirmObject( sMap[ szType ][ "keyWord" ]  );
                                            sMap[ szType ][ "keyWord" ][szCnW] = true;
                                            sMap[ szType ][ "uk_phonetic" ] = row[ "uk_phonetic_symbol" ];
                                            sMap[ szType ][ "us_phonetic" ] = row[ "us_phonetic_symbol" ];
                                            sMap[ szType ][ "band"        ] = Predator.jsonWordDatumCoding.bandWordDecode( row["w_level"], ',' );

                                            sMap[ szType ][ "defs" ]          = pPine.Objects.affirmObject( sMap[ szType ][ "defs" ]  );
                                            sMap[ szType ][ "defs" ][ szCnD ] = pPine.Objects.affirmObject( sMap[ szType ][ "defs" ][ szCnD ] );
                                            sMap[ szType ][ "defs" ][ szCnD ][ "pos"  ]  = row[ "m_property" ];
                                            sMap[ szType ][ "defs" ][ szCnD ][ "defs" ]  = pPine.Objects.affirmArray( sMap[ szType ][ "defs" ][ szCnD ][ "defs" ] );
                                            sMap[ szType ][ "defs" ][ szCnD ][ "defs" ].push( row );
                                        }

                                        //console.log( sMap );
                                        self.genieData[ "$fnSizeof" ] = sizeof;
                                        self.genieData[ "$fnEnumGet"] = Predator.paginate.rowEnumCounter;
                                        self.genieData[ "wordList" ]  = sMap;
                                        self.renderById( "tplWordSearchList" );
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
                "fragmentSearch":{
                    title:"词根查询",
                    fn: function (parent) {
                        var szKey = $_GET[ "kw" ];
                        Predator.wizard.smartGenieInstance(this,{
                            "init": function ( self ) {},
                            "renderFragmentList": function ( self ) {
                                self.genieData["searchFragmentList"] = pageData["searchFragmentList"];
                                self.genieData[ "$fnEnumGet"] = Predator.paginate.rowEnumCounter;
                                Predator.paginate.smartMount( parent.spawnSubSelector(".crisp-paginate ul"), pageData );
                                self.renderById("tplFragmentList");
                            }
                        })
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