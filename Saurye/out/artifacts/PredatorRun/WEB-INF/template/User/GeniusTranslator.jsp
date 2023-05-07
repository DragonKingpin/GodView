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
                                <a href="<%=thisPage.spawnActionQuerySpell()%>">
                                    <div class="header">
                                        <i class="fa fa-magic"></i>
                                    </div>
                                    <div class="content" id="magicTranslatorIndexLabel" style="font-size: 140%">魔法翻译</div>
                                </a>
                            </div>
                        </div>


                    </div>
                </div>
            </div>

            <div class="col-sm-10">
                <div id="translatorZone" >
                    <div class="row" >
                        <div class="col-md-12">
                            <div class="panel panel-default btn-sharp">
                                <div class="panel-body predator-translator-box" >
                                    <em class="close p-t-clear" onclick="pageData.fnClearTransBox(this)" style="display: none">×</em>
                                    <textarea class="p-translate-input" id="main-translate-box"
                                              onpropertychange="pageData.fnTransBoxChanged(this)"
                                              oninput="pageData.fnTransBoxChanged(this)"
                                              style="height: 150px;" maxlength="3000"
                                              placeholder="请输入中/英文"
                                    ></textarea>
                                    <div class="p-translate-toolbar">
                                        <a class="fa fa-volume-up p-t-play" href="javascript:pageData.fnPlayTrans();"></a>
                                        <a href="javascript:pageData.fnSubmitTranslate();" class="btn btn-primary p-t-btn-do" >翻&nbsp;&nbsp;译</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" >
                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-language"></i><span>翻译结果</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body predator-translator-box" >
                                            <textarea class="p-translate-input" id="translate-result-box" style="height: 100px; width: 100%" readonly></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box" id="phraseDefs" style="display: none" >
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-sticky-note-o"></i><span id="phraseDefTitle">短语信息</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body" >
                                            <script type="text/html" id="tplPhraseDefs">
                                                <#if ( p_type === 'word' ) { #>
                                                <div class="crisp-my-profile">
                                                    <div class="col-md-12" >
                                                        <h2 style="color: green;">
                                                            <span><a href="<%=szWordQuerySpell%>"><#=$_GET["query"]#></a></span>
                                                            <a style="float: right;font-size: 80%" href="<%=szWordQuerySpell%>"><i class="fa fa-magic"></i>&nbsp;详细信息</a>
                                                        </h2>
                                                        <hr/>
                                                        <h4><i class="fa fa-tag"></i><label>读音：</label>
                                                            <#if(basicInfo[0].hasOwnProperty("uk_phonetic_symbol")){#>
                                                            <span>英: [<#=basicInfo[0]["uk_phonetic_symbol"]#>] </span><a class="fa fa-volume-up" style="margin-right: 5%" href="javascript:pageData.fnPhoneticAudioPlay(1);"></a>
                                                            <#}#>
                                                            <#if(basicInfo[0].hasOwnProperty("us_phonetic_symbol")){#>
                                                            <span>美: [<#=basicInfo[0]["uk_phonetic_symbol"]#>] </span><a class="fa fa-volume-up" href="javascript:pageData.fnPhoneticAudioPlay(2);"></a>
                                                            <#}#>
                                                        </h4>
                                                        <#for( var key in cnDefs ) {#>
                                                        <h4><i class="fa fa-tag"></i><label><#=cnDefs[key]["m_property"]#>. </label><span><#=cnDefs[key]["cn_means"]#></span></h4>
                                                        <#} #>
                                                    </div>
                                                </div>
                                                <#} else { #>

                                                    <# for ( var type in phrasesList ){
                                                    var row = phrasesList[ type ];
                                                    #>
                                                    <div class="panel panel-hr">
                                                        <div class="row">
                                                            <div class="col-md-12 predator-w-phrase-list">
                                                                <div class="crisp-my-box">
                                                                    <div class="head-info">
                                                                        <h2>
                                                                            <strong><#=plTypeMap[ type ]#></strong>
                                                                        </h2>
                                                                        <hr>
                                                                    </div>

                                                                    <#  var pi = 1;
                                                                    for( var phrase in row ){
                                                                    #>
                                                                    <div class="box-content">
                                                                        <div class="define-info">
                                                                            <h3><#=pi++#>. <#=phrase#></h3>

                                                                            <#  var di = 1;
                                                                            for( var cnDef in row[phrase] ){
                                                                            var def = row[ phrase ][ cnDef ];
                                                                            #>
                                                                            <div class="phrase-define">
                                                                                <h3><#=di++#>. <#=cnDef#><span style="float: right"><#=def["pos"]#>.</span></h3>

                                                                                <# if( def["en_def"] ) { #>
                                                                                <p class="en-def"><#=def["en_def"]#></p>
                                                                                <#} #>

                                                                                <# for( var egi in def["eg_sent"] ){  #>
                                                                                <div class="sentence-info">
                                                                                    <p class="sentence-en"><#=def["eg_sent"][egi]["eg"]#></p>
                                                                                    <p class="sentence-cn"><#=def["eg_sent"][egi]["cn"]#></p>
                                                                                </div>
                                                                                <#} #>
                                                                            </div>
                                                                            <#} #>
                                                                        </div>
                                                                    </div>
                                                                    <#}#>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <#} #>

                                                <#} #>
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box" style="display: none" >
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-cube"></i><span>流行词典</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <script type="text/html" id="slangDefs">
                                        <# for( var i in slangDefs ){ #>
                                        <div class="panel panel-default btn-sharp">
                                            <div class="panel-body predator-slang-def">
                                                <div class="p-sd-word"><#=slangDefs[i].en_slang#></div>
                                                <div class="p-sd-def"><#=slangDefs[i].com_def#></div>
                                                <# for( var j in slangDEGSentences ){
                                                var row = slangDEGSentences[j];
                                                if( row["classid"] === slangDefs[i]["classid"] ){
                                                #>
                                                <div class="p-sd-eg-sentence"><#=row["eg_sentence"]#></div>
                                                <#}} #>
                                                <div class="p-sd-date">
                                                    by <#=slangDefs[i].c_author ? slangDefs[i].c_author : 'undefined'#> | At: <#=slangDefs[i].c_date#>
                                                </div>
                                                <div class="p-sd-source">
                                                    &lt;&lt; <#=slangGSCnMap[ slangDefs[i].s_source ] #> &gt;&gt;
                                                </div>
                                            </div>
                                        </div>
                                        <#} #>
                                    </script>
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
            pageData.fnAssertTranslateInputCloseBtn = function( szText ){
                if( szText.length > 0 ){
                    $_PINE( ".predator-translator-box .p-t-clear" ).show();
                }
                else {
                    $_PINE( ".predator-translator-box .p-t-clear" ).hide();
                }
            };
            pageData.fnTransBoxChanged = function ( that ){
                Predator.page.textarea.resize.auto( that );
                pageData.fnAssertTranslateInputCloseBtn( that.value );
            };
            pageData.fnClearTransBox = function( that ) {
                var hTextA = that.nextElementSibling;
                if( hTextA ){
                    hTextA.value = "";
                    pageData.fnTransBoxChanged( hTextA );
                }
            };
            pageData.fnPlayTrans = function (){
                var s = $_PINE( "#main-translate-box" ).val();
                Predator.vocabulary.phonetic.audioPlay( s, 1 );
            };
        },
        "bindTranslateEvent": function ( parent ) {
            pageData.fnSubmitTranslate = function () {
                Predator.searcher.bindSingleSearch( "query", "#main-translate-box", true );
            };
            var szTranText = $_GET [ "query" ];
            if( szTranText ){
                $_PINE( "#main-translate-box" ).val( szTranText );
                pageData.fnAssertTranslateInputCloseBtn( szTranText );
            }
        },
        "genies": function ( parent ){
            $_CPD({
                "sentenceProfile": {
                    title: "魔法翻译",
                    fn: function(parent) {
                        var szQuery = $_GET[ "query" ];

                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {},
                            "sentenceSubmit": function ( self ) {
                                if( szQuery ){
                                    Predator.elements.sentence.translate( szQuery, function ( data ) {
                                        if( data.errorCode === 0 ){
                                            $_PINE( "#translate-result-box" ).text( data["translation"] );
                                        }
                                    } );
                                }
                            },
                            "renderPhrase": function ( self ) {
                                var hPhraseInfo = pageData["phraseInfo"];
                                if( !$isTrue( hPhraseInfo ) ){
                                    return;
                                }

                                self.genieData[ "p_type" ] = hPhraseInfo[ "type" ];
                                self.genieData[ "$_GET" ] = $_GET;
                                if( hPhraseInfo[ "type" ] === "word" ){
                                    if( !$isTrue( hPhraseInfo[ "basicInfo" ] ) ){
                                        return;
                                    }

                                    $_PINE( "#phraseDefTitle" ).text( "单词信息" );
                                    self.genieData[ "basicInfo" ] = hPhraseInfo[ "basicInfo" ];
                                    self.genieData[ "cnDefs" ]    = hPhraseInfo[ "cnDefs" ];
                                    self.renderById( "tplPhraseDefs" );
                                    pageData.fnPhoneticAudioPlay = function ( t ){
                                        Predator.vocabulary.phonetic.audioPlay( szQuery, t );
                                    };
                                }
                                else {
                                    var hPhrases = hPhraseInfo[ "phrasesList" ];
                                    if( !$isTrue( hPhrases ) ){
                                        return;
                                    }

                                    if( hPhrases.length > 0 ) {
                                        var sMap = {};
                                        for ( var i = 0; i < hPhrases.length; i++ ) {
                                            var row        = hPhrases[i];
                                            var szPhType   = row[ "ph_type" ];
                                            var szEnPhr    = row[ "en_phrase" ];
                                            var szCnDef    = row[ "ph_cn_def" ];
                                            sMap[ szPhType ] = pPine.Objects.affirmObject( sMap[ szPhType ] );
                                            sMap[ szPhType ][ szEnPhr ] = pPine.Objects.affirmObject( sMap[ szPhType ][ szEnPhr ] );
                                            sMap[ szPhType ][ szEnPhr ][ szCnDef ] = pPine.Objects.affirmObject( sMap[ szPhType ][ szEnPhr ][ szCnDef ] );
                                            var eachDef = sMap[ szPhType ][ szEnPhr ][ szCnDef ];

                                            eachDef[ "en_def"  ] = row[ "ph_en_def" ];
                                            eachDef[ "pos"     ] = row[ "ph_property" ];
                                            eachDef[ "eg_sent" ] = pPine.Objects.affirmArray( eachDef[ "eg_sent" ] );
                                            if( row["eg_sentence"] ){
                                                var sent = {
                                                    "eg": row["eg_sentence"], "cn": row["eg_cn_def"]
                                                };
                                                eachDef[ "eg_sent" ].push( sent );
                                            }
                                        }
                                        self.genieData[ "phrasesList" ] = sMap;
                                        self.genieData[ "plTypeMap" ]   = Predator.vocabulary.phrase.gsTypeCnMap;
                                        self.renderById( "tplPhraseDefs" ) ;
                                    }
                                }

                                $_PINE( "#phraseDefs" ).show();
                            },
                            "renderSlang": function ( self ) {
                                var hSlangInfo = pageData["slangInfo"];
                                if( !$isTrue( hSlangInfo ) || !$isTrue( hSlangInfo[ "slangDefs" ] ) ){
                                    return;
                                }
                                $( "#slangDefs" ).parents( ".crisp-my-box" ).show();

                                self.genieData[ "slangDefs" ]         = pageData["slangInfo"][ "slangDefs" ];
                                self.assertRender(
                                    self.genieData[ "slangDefs" ].length > 0 , "slangDefs",
                                    "",
                                    function () {
                                        self.genieData[ "slangDEGSentences" ] = pageData["slangInfo"][ "slangDefEgSentences" ];
                                        self.genieData[ "slangGSCnMap" ]      = Predator.vocabulary.slang.gsCnMap;
                                    }
                                );
                            }
                        } );
                    }
                }
            }).beforeSummon( function ( cpd ) {
                cpd.afterGenieSummoned = function ( who ) {
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        $_PINE( "#magicTranslatorIndexLabel" ).css({"text-decoration":"underline","font-weight":"bold"});
                    }
                };
            }).summon(Predator.getAction());
        }
    });


</script>
${StaticPageEnd}