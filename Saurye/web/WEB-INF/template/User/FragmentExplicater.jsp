<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page isELIgnored="false" %>
<%
    JSONObject $_GSC = PredatorProto.mySoul(request).$_GSC();
%>
${StaticHead}
<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label id="currentTitle">语言学习</label> >> <label id="pageNodeTitle">词根主页</label>
                    <a class="all-box-down" href="javascript:void(0)" style="float: right">
                        收放 <i class="fa fa-angle-up"></i>
                    </a>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div id="ButtonsControl" class="crisp-union-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%"><i class="fa fa-list"></i><span> 目录</span></h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background super-btn-add-gap">
                                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-map-signs"></i>
                                    </div>
                                    <div class="content" id="fragmentProfileIndexLabel" style="font-size: 140%">
                                        词根总览
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background super-btn-add-gap">
                                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("fragmentEtymology")%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-eyedropper"></i>
                                    </div>
                                    <div class="content" id="fragmentEtymologyIndexLabel" style="font-size: 140%">
                                        词根词源
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-10">
                <div id="profileZone">
                    <div class = "form-group com-group-control-search">
                        <label>词根</label>
                        <input type="text" name="query" class="form-control" id="queryWord" placeholder="请输入词根关键字，带'%'为模糊查找" onkeydown="pageData.fnSearchKeyWord()" />
                        <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWord()">
                            <i class="fa fa-search"></i>
                        </a>
                    </div>

                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" >
                            <script type="text/html" id="tplFragmentExplicater">
                                <div class="crisp-my-profile">
                                    <div class="col-md-12" >
                                        <h2 style="color: green;">
                                            <span><#=$_GET["query"]#></span>
                                            <span style="float: right;font-size: 80%"><a href="#"><i class="fa fa-plus"></i>&nbsp;词根本</a></span>
                                        </h2>
                                        <hr/>
                                        <h4><i class="fa fa-tag"></i><label>同族词根: &nbsp; </label><span><#=fragmentInfo[0]["f_clan"]#></span></h4>
                                        <# if(fragmentInfo[0]["f_cn_def"]!==undefined){#>
                                        <h4><i class="fa fa-tag"></i><label>基本释义: &nbsp; </label><span><#=fragmentInfo[0]["f_cn_def"]#></span></h4>
                                        <#}#>
                                        <# if(fragmentInfo[0]["f_rank"]!==undefined){#>
                                        <h4><i class="fa fa-tag"></i><label>词根等级: &nbsp; </label><span><#=fragmentInfo[0]["f_rank"]#></span></h4>
                                        <#}#>
                                    </div>
                                </div>
                            </script>
                        </div>
                    </div>
                </div>

                <div id="fragmentProfile" style="display:none;" >
                    <div class="crisp-my-box" >
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-cogs"></i><span>词根释义</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>

                        <div class="box-content">
                            <div class="panel panel-default btn-sharp">
                                <div class="panel-body">
                                    <div class="crisp-my-box">

                                        <script type="text/html" id="tplFragmentDefs" >
                                            <# for( var k in fragDefs ){
                                            var row = fragDefs[k];
                                            #>
                                            <div class="panel panel-hr">
                                                <div class="row">
                                                    <div class="col-md-12 predator-frag-def-list">
                                                        <div class="crisp-my-box">

                                                            <div class="head-info">
                                                                <h2>
                                                                    <strong><label class="alert-info alert fd-tag"><#=fdKinMap[ row['kin'] ]#></label><#=k#></strong>
                                                                    <span>
                                                                    <a class="box-down" href="javascript:void(0)"><i class="fa fa-angle-down"></i></a>
                                                                </span>
                                                                </h2>
                                                                <hr>
                                                            </div>
                                                            <div class="box-content">
                                                                <# for( var kDef in row["defs"] ) {
                                                                var def = row["defs"][ kDef ];
                                                                #>
                                                                <div class="define-info">
                                                                    <h3><#=kDef#></h3>
                                                                    <# for( var j in def["arch"] ) {
                                                                    var epitome = def["arch"][j];
                                                                    #>
                                                                    <div class="epitome-info">
                                                                        <p><#=epitome["w_epitome"]#><span class="def-dict"><#=epitome["m_property"]#>. <#=epitome["cn_means"]#></span></p>
                                                                        <p class="def-infer"><#=epitome["cn_infer"]#></p>
                                                                    </div>
                                                                    <#}#>
                                                                </div>
                                                                <#} #>
                                                            </div>

                                                        </div>
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

                <div id="fragmentEtymology" style="display: none">
                    <div class="crisp-my-box" >
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-eyedropper"></i><span>词源信息</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>

                        <div class="row box-content">
                            <div class="col-md-12" >
                                <script type="text/html" id="tplFragEtymon" >
                                    <#for( var k in etyDefs ) {#>
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body predator-slang-def">
                                            <div class="p-sd-word">
                                                <#=etyDefs[k]["f_clan"]#>
                                            </div>
                                            <div class="p-sd-def"><p class="p-sd-eg-sentence">词源释义：<#=etyDefs[k]["f_simple_def"]#></p>
                                                <hr/><p><#=etyDefs[k]["etymon"]#></p>
                                            </div>
                                            <div class="p-sd-source"><i class="fa fa-flag"></i>&nbsp; <#=etyDefs[k]['relevant']#></div>
                                            <div class="p-sd-source" style="float: left">eg.&nbsp;
                                                <# for( var epitome in etyDefs[k]['w_epitome'] ){ if( etyDefs[k]['w_epitome'].hasOwnProperty( epitome ) ) { #>
                                                    <a href="<#=fnHrefWordExplicater( epitome )#>"><#=epitome#></a>
                                                <#}}#>
                                            </div>
                                        </div>
                                    </div>
                                    <#}#>
                                </script>
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
        },
        "genies": function ( parent ){
            $_CPD({
                "fragmentProfile":{
                    title: "词根总览",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                self.genieData["fragmentInfo"] = pageData["FragmentExplication"]["fragmentInfo"];
                                return self.genieData["fragmentInfo"].length > 0;
                            },
                            "renderFragment":function (self) {
                                self.renderById( "tplFragmentExplicater" );
                            },
                            "renderEpitome": function  ( self ) {
                                self.genieData["fragmentEpitome"] = pageData["FragmentExplication"]["fragmentEpitome"];
                                var hFragInfos = self.genieData["fragmentEpitome"];

                                if( hFragInfos.length > 0 ){
                                    var etyMap = {};
                                    for ( var i = 0; i < hFragInfos.length; ++i ) {
                                        var row = hFragInfos[i];
                                        var szId     = row[ "f_clan_name" ];
                                        var szCnDef  = row[ "cn_def" ];
                                        if( !etyMap[ szId ] ){
                                            etyMap[ szId ] = {};
                                            etyMap[ szId ][ "kin"  ] = row["c_form_kin"];
                                            etyMap[ szId ][ "ety"  ] = row["ety_relevant"];
                                            etyMap[ szId ][ "rank" ] = row["f_rank"];
                                            etyMap[ szId ][ "r_cn" ] = row["cn_rank_def"];
                                        }

                                        etyMap[ szId ]["defs"] = pPine.Objects.affirmObject( etyMap[ szId ]["defs"] );
                                        if( !etyMap[ szId ]["defs"][ szCnDef ] ){
                                            etyMap[ szId ]["defs"][ szCnDef ] = { "arch" : [] };
                                        }

                                        etyMap[ szId ]["defs"][ szCnDef ][ 'arch' ].push ( row );
                                    }

                                    //console.log( etyMap );
                                    self.genieData["fragDefs"] = etyMap;
                                    self.genieData["fdKinMap"] = Predator.vocabulary.frag.gsCnMap;
                                    self.renderById( "tplFragmentDefs" );
                                    Predator.page.interact.refresh();
                                }
                            }
                        } );
                    }
                },
                "fragmentEtymology":{
                    title: "词根词源",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                self.genieData["fragmentInfo"] = pageData["FragmentExplication"]["fragmentInfo"];
                                return self.genieData["fragmentInfo"].length > 0;
                            },
                            "renderFragment":function (self) {
                                self.renderById( "tplFragmentExplicater" );
                            },
                            "renderEtymology": function ( self ) {
                                self.genieData["fragmentEtymology"] = pageData["FragmentExplication"]["fragmentEtymology"];
                                var hFragmentEtymology = self.genieData["fragmentEtymology"];

                                if( hFragmentEtymology.length > 0 ){
                                    var etyMap = {};
                                    for ( var i = 0; i < hFragmentEtymology.length; ++i ) {
                                        var row = hFragmentEtymology[i];
                                        var szClan = row["f_clan"];
                                        etyMap[ szClan ] = pPine.Objects.affirmObject( etyMap[ szClan ] );
                                        etyMap[ szClan ][ "relevant" ]  = row["f_relevant"];
                                        etyMap[ szClan ][ "etymon" ]    = row["f_etymon"] ;
                                        etyMap[ szClan ]["f_clan"]       = szClan;
                                        etyMap[ szClan ]["f_simple_def"] = row["f_simple_def"];
                                        etyMap[ szClan ]["w_epitome"] = pPine.Objects.affirmObject( etyMap[ szClan ]["w_epitome"] );
                                        etyMap[ szClan ]["w_epitome"][ row["w_epitome"] ] = true;
                                    }

                                    self.genieData["etyDefs"] = etyMap;
                                    self.genieData[ "fnHrefWordExplicater" ] = Predator.wizard.address.syndicate.WordExplicater;
                                    self.renderById( "tplFragEtymon" );
                                }
                                else {
                                    $_PINE( "#tplFragEtymon" ).parent().html( "<tr><td>该词根很懒，暂无相关数据</td></tr>" );
                                }
                            },
                        } );
                    }
                },
            }).beforeSummon( function ( cpd ) {
                cpd.afterGenieSummoned = function ( who ) {
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );
                    }
                };
            }).summon(Predator.getAction());
        },
        "final": function ( parent ) {
            pageData.fnSearchKeyWord = function () {
                Predator.logicControl.bindRedirector(
                    '#queryWord',
                    Predator.wizard.address.syndicate.GeniusExplorer( "fragmentSearch" ) + "&kw="
                );
            };
            $_PINE("#queryWord").val( $_GET[ "query" ] );
        }
    });



</script>
${StaticPageEnd}