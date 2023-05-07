<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<%
    PredatorArchWizardum thisPage = PredatorProto.mySoul(request);
    JSONObject $_GSC = PredatorProto.mySoul(request).$_GSC();
%>
${StaticHead}


<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label id="currentTitle">词汇主页</label> >> <label id="pageNodeTitle"></label>
                    <a class="all-box-down" href="javascript:void(0)" style="float: right">
                        收放 <i class="fa fa-angle-up"></i>
                    </a>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <div class="crisp-union-box">
                    <div class="row pad-botm">
                        <div class="col-md-12">
                            <h4 class="header-line" style="font-size: 110%"><i class="fa fa-list"></i><a href="javascript:void(0)" class="predator-left-super-menu-clip"> 目录</a></h4>
                        </div>
                    </div>
                    <div class="row predator-left-super-menu" >
                        <div class="col-sm-12">
                            <div class="crisp-super-btn fb-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell()%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-map-signs"></i>
                                    </div>
                                    <div class="content" id="wordProfileIndexLabel" style="font-size: 140%">
                                        词汇总览
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn green-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("conjugatedWords")%>&query=<%=$_GSC.optString("query")%>"
                                   title="包含同义词、反义词、屈折变化、词组等相关关联词汇。">
                                    <div class="header">
                                        <i class="fa fa-puzzle-piece"></i>
                                    </div>
                                    <div class="content" id="conjugatedWordsIndexLabel" style="font-size: 140%">词汇关系</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn blue-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("etymologyRoots")%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-eyedropper"></i>
                                    </div>
                                    <div class="content" id="etymologyRootsIndexLabel" style="font-size: 140%">词源词根</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn dark-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("exampleSentence")%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-comment-o"></i>
                                    </div>
                                    <div class="content" id="exampleSentenceIndexLabel" style="font-size: 140%">例句大全</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn orange-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("advanceDefine")%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-cubes"></i>
                                    </div>
                                    <div class="content" id="advanceDefineIndexLabel" style="font-size: 140%">高级词典</div>
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="crisp-super-btn purple-background" style="margin-bottom: 10%">
                                <a href="<%=thisPage.spawnActionQuerySpell("magicReport")%>&query=<%=$_GSC.optString("query")%>">
                                    <div class="header">
                                        <i class="fa fa-magic"></i>
                                    </div>
                                    <div class="content" id="magicReportIndexLabel" style="font-size: 140%">魔法数据</div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-10">
                <div id="searchZone">
                    <div class = "form-group com-group-control-search">
                        <label>单词</label>
                        <input type="text" name="query" class="form-control" id="queryWord" placeholder="请输入单词" onkeydown="pageData.fnSearchKeyWord()" />
                        <a class="btn btn-primary search" style="float:right;border-radius: 0;width: 15%;" href="javascript:pageData.fnSearchKeyWord()">
                            <i class="fa fa-search"></i>
                        </a>
                    </div>
                </div>

                <div id="wordProfile" style="display: none">
                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" >
                            <script type="text/html" id="wordBriefDefine">
                                <div class="crisp-my-profile">
                                    <div class="col-md-3" >
                                        <img id="user-index-avatar" class="img-responsive crisp-limit-avatar" style="min-width: 200px; min-height: 220px" src="<#=wordImgUrl#>" alt="" >
                                    </div>
                                    <div class="col-md-9" >
                                        <h2 style="color: green;">
                                            <span><#=$_GET["query"]#></span>
                                            <span style="float: right;font-size: 80%"><i class="fa fa-plus"></i>&nbsp;单词本</span>
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
                            </script>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-tags"></i><span>我的标签</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>
                        <div class="row box-content">
                            <div class="col-md-12" id="my-tags-field">
                                <script type="text/html" id="myTags" >
                                    <#for( var key in bandLevels ) {#>
                                        <label class="alert-success alert crisp-tiny-tag"><#=bandLevels[key]#></label>
                                    <#}#>
                                    <label class="alert-info alert crisp-tiny-tag" title="This shows grade level based on the word's complexity." ><#=gradeLevels#></label>
                                </script>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-key"></i><span>中文关键字</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>
                        <div class="row box-content" >
                            <div class="col-md-12 col-sm-12">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover crisp-picture-table" >
                                        <script type="text/html" id="cnDictDefinesList">
                                            <tbody>
                                            <# for( var key in cnDDefsMap ){ #>
                                            <tr>
                                                <td><#=key#>. </td>
                                                <td>
                                                    <#for(var i=0;i < cnDDefsMap[key].length ; ++i ) { #>
                                                    <#=cnDDefsMap[key][i]#>
                                                    <#if(i != cnDDefsMap[key].length - 1) { #>, <#}#>
                                                    <#}#>
                                                </td>
                                            </tr>
                                            <#}#>
                                            </tbody>
                                        </script>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-line-chart"></i><span>词频信息</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>
                        <div class="row box-content" >
                            <div class="col-md-12 col-sm-12">
                                <div class="panel panel-default btn-sharp">
                                    <div class="panel-body" id="profileFrequencyGroupBody">
                                        <div class="row pad-botm">
                                            <div class="col-md-12">
                                                <h4 class="header-line" style="font-size: 110%"><i class="fa fa-magic"></i><span>基本词频</span></h4>
                                            </div>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                                <script type="text/html" id="basicFrequencyInfo">
                                                    <tbody>
                                                    <tr>
                                                        <td>基础词频：</td>
                                                        <td>
                                                            <#for( var i=0; i < nf_band_level; ++i ){ #>
                                                            <i class="fa fa-star"></i>
                                                            <#}#>
                                                        </td>
                                                        <td>星级词汇：</td>
                                                        <td>
                                                            <#for( var i=0; i < nband_rank; ++i ){ #>
                                                            <i class="fa fa-star"></i>
                                                            <#}#>
                                                        </td>
                                                        <td>全局排位：</td>
                                                        <td>
                                                            <span id="global_union_freq_rank"></span> / 130K
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </script>
                                            </table>
                                        </div>

                                        <div id="cocaFreqBox">
                                            <div class="row pad-botm" >
                                                <div class="col-md-12" >
                                                    <h4 class="header-line" style="font-size: 110%"><i class="fa fa-university"></i><span>COCA权威词频</span></h4>
                                                </div>
                                            </div>
                                            <div class="table-responsive" style="margin-bottom: -2%" >
                                                <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                                    <tbody>
                                                    <tr>
                                                        <td>频率总计：</td><td id="profile_f_total"></td>
                                                        <td>词频排位：</td><td><span id="profile_coca_rank"></span> / 60K</td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6" style="margin-top: 2%">
                                                    <div id="wordSumFreqPieChart" style="border: 1px solid #428bca;">
                                                        <canvas class="chartjs-render-monitor" width="400" height="400"></canvas>
                                                    </div>
                                                </div>
                                                <div class="col-md-6" style="margin-top: 2%">
                                                    <div class="" style="border: 1px solid #428bca;">
                                                        <canvas id="eachFreqBarChart"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="bandFreqBox">
                                            <div class="row pad-botm" >
                                                <div class="col-md-12" >
                                                    <h4 class="header-line" style="font-size: 110%"><i class="fa fa-university"></i><span>考试词频</span></h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div style="border: 1px solid #428bca;">
                                                        <canvas id="bandWordBarChart"></canvas>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="table-responsive" id="bandWordFreqList" >
                                                        <table class="table table-hover table-bordered">
                                                            <thead>
                                                            <tr>
                                                                <td>考试</td>
                                                                <td>重点频数</td>
                                                                <td>排位</td>
                                                                <td>排位</td>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr>
                                                                <td>高考：</td>
                                                                <td><span id="fBand_NEMT">0</span></td>
                                                                <td>排位：</td>
                                                                <td><span id="rBand_NEMT">0</span> / 6K</td>
                                                            </tr>
                                                            <tr>
                                                                <td>CET4：</td>
                                                                <td><span id="fBand_CET4">0</span></td>
                                                                <td>排位：</td>
                                                                <td><span id="rBand_CET4">0</span> / 7K</td>
                                                            </tr>
                                                            <tr>
                                                                <td>CET6：</td>
                                                                <td><span id="fBand_CET6">0</span></td>
                                                                <td>排位：</td>
                                                                <td><span id="rBand_CET6">0</span> / 8.5K</td>
                                                            </tr>
                                                            <tr>
                                                                <td>考研：</td>
                                                                <td><span id="fBand_PEE">0</span></td>
                                                                <td>排位：</td>
                                                                <td><span id="rBand_PEE">0</span> / 6.5K</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-language"></i><span>英英释义</span>
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
                                        <script type="text/html" id="englishDefinesList">
                                            <# for( var i=0; i < enDefs.length; ++i ){ #>
                                            <div class="panel panel-hr">
                                                <div class="row">
                                                    <div class="col-md-12 predator-def-list-box">
                                                        <div class="head-info">
                                                            <h2>
                                                                <strong><#=enDefs[i]["w_definition"]#></strong>
                                                                <span><#=enDefs[i]["d_property"]#>.</span>
                                                            </h2>
                                                        </div>
                                                        <hr>
                                                        <#var si = 1;#>
                                                        <# for( var j=0; j < enDefsEgSentences.length; ++j ){ #>
                                                        <#if( enDefsEgSentences[j]["classid"] === enDefs[i]["classid"] ){#>
                                                        <#if(enDefsEgSentences[j]["d_sentence"]){#>
                                                        <p><#=si++ + ". " + enDefsEgSentences[j]["d_sentence"]#></p>
                                                        <#} else {#>
                                                        <p>暂无例句</p>
                                                        <#}#>
                                                        <#}#>
                                                        <#}#>
                                                    </div>
                                                </div>
                                            </div>
                                            <# } #>
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-mortar-board"></i><span>行业词典</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>

                        <div class="box-content">
                            <div class="panel panel-default btn-sharp">
                                <div class="panel-body">
                                    <div class="crisp-my-box" >
                                        <script type="text/html" id="tradeDict">
                                            <# for( var k in tradeDictMap ) { #>
                                            <# if(tradeDictMap[k]){#>
                                            <div class="predator-synonym-box">
                                                <i class="fa fa-tag"></i><span class="synonym-box-annotate"><#=k#></span>
                                                <p>
                                                    <# for( var i in tradeDictMap[k] ) { #>
                                                    <label class="psb-text"><#=tradeDictMap[k][i]#></label>
                                                    <#} #>
                                                </p>
                                            </div>
                                            <#} #>
                                            <#} #>
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="conjugatedWords" style="display:none;">
                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" >
                            <div class="crisp-my-profile">
                                <div class="col-md-12" >
                                    <h2 style="color: green;">
                                        <span id="cWords_Word_Label"></span>
                                        <span style="float: right;font-size: 80%"><i class="fa fa-language"></i>&nbsp;English</span>
                                    </h2>
                                </div>
                            </div>
                        </div>
                    </div>

                    <ul class="nav nav-tabs">
                        <li class="" id="cw_basicIndexLabel">
                            <a href="<%=thisPage.spawnActionQuerySpell( "conjugatedWords" ) + "&cwNode=cw_basic"%>&query=<%=$_GSC.optString("query")%>" >
                                <i class="fa fa-puzzle-piece"></i> 基础关系
                            </a>
                        </li>
                        <li class="" id="cw_polyIndexLabel">
                            <a href="<%=thisPage.spawnActionQuerySpell( "conjugatedWords" ) + "&cwNode=cw_poly"%>&query=<%=$_GSC.optString("query")%>" >
                                <i class="fa fa-snowflake-o"></i> 形态关系
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content" style="margin-top: 10px">
                        <div id="cw_basic" style="display: none">
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
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                            <script type="text/html" id="inflectionList">
                                                <tbody>
                                                <#for( var i=0; i < inflections.length; ){ #>
                                                <#if( i + 2 <= inflections.length ){ #>
                                                <tr>
                                                    <td><#=infGSCnMap[ inflections[i]["i_type"] ]#>: </td>
                                                    <td><#=inflections[i]["w_inflection"]#></td>
                                                    <td><#=infGSCnMap[ inflections[i+1]["i_type"] ]#>: </td>
                                                    <td><#=inflections[i+1]["w_inflection"]#></td>
                                                </tr>
                                                <#i+=2; #>
                                                <#}else { #>
                                                <tr>
                                                    <td colspan="2"><#=infGSCnMap[ inflections[i]["i_type"] ]#>: </td>
                                                    <td colspan="2"><#=inflections[i]["w_inflection"]#></td>
                                                </tr>
                                                <#++i; #>
                                                <#} #>
                                                <#} #>
                                                </tbody>
                                            </script>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-random"></i><span>同义词</span>
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
                                                <script type="text/html" id="assocRenderCode">
                                                    <# for( var k in wsAssocMap ) { #>
                                                    <# if(wsAssocMap[k]){
                                                    for( var annotate in wsAssocMap[k] ) {
                                                    #>
                                                    <div class="predator-synonym-box">
                                                        <i><#=k#>.</i><span class="synonym-box-annotate"><#=annotate#></span>
                                                        <p>
                                                            <# for( var i in wsAssocMap[k][annotate] ) { #>
                                                            <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>&query=<#=wsAssocMap[k][annotate][i]#>">
                                                                <#=wsAssocMap[k][annotate][i]#>
                                                            </a>
                                                            <#} #>
                                                        </p>
                                                    </div>
                                                    <#   }
                                                    } #>
                                                    <#} #>
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-random"></i><span>反义词</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body">
                                            <div class="crisp-my-box" id="antonymsList">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-search"></i><span>同义词辨析</span>
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
                                                <script type="text/html" id="synonymAnalysis">
                                                    <# for( var k in synonAnalysis ) { #>
                                                    <# if( synonAnalysis[k] ){ #>
                                                    <div class="predator-synonym-analysis-box">
                                                        <h5><#=k#>.</h5>
                                                        <p class="synonym-analysis-def">[<#=synonAnalysis[k]["cn_def"]#>]</p>
                                                        <div class="synonym-analysis-epitomes">
                                                            <# for( var i in synonAnalysis[k]["epitomes"] ) {
                                                            var row = synonAnalysis[k]["epitomes"][i];
                                                            #>
                                                            <div class="synonym-analysis-epitome">
                                                                <div class="sa-epitome-dictionary-def">
                                                                    <# if( row["epitome"] ){ #>
                                                                    <span class="sa-edd-word"><a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>&query=<#=row['epitome']#>"><#=row["epitome"]#></a></span>
                                                                    <span class="sa-edd-pos"><#=row["pos"]#>.</span>
                                                                    <#} #>
                                                                    <span class="sa-edd-def"><#=row["cn_dict"]#></span>
                                                                </div>
                                                                <div class="sa-epitome-discriminate-def">
                                                                    <span class="sa-ead-title">{辨析}</span>
                                                                    <span class="sa-ead-def"><#=row["def"]#></span>
                                                                </div>
                                                            </div>
                                                            <#} #>
                                                        </div>
                                                    </div>
                                                    <#} #>
                                                    <#} #>
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-sticky-note-o"></i><span>词组搭配</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body">
                                            <script type="text/html" id="tplPhrasesListCode" >
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
                                                                        <span>
                                                                        <a class="box-down" href="javascript:void(0)"><i class="fa fa-angle-down"></i></a>
                                                                    </span>
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
                                            </script>

                                            <div class="crisp-my-box" id="tplPhrasesList" >

                                            </div>

                                            <div class="phrase-more-mask" onclick="pageData.fnRenderMorePhrases(this)">
                                                <div class="show-more-btn">展开全部 <i class="fa fa-angle-down" style="margin-left: 5px"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="cw_poly" style="display: none">
                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-id-card-o"></i><span>基本特征</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="crisp-my-box">
                                        <div class="table-responsive" style="margin-bottom: -2%">
                                            <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                                <tbody>
                                                <tr>
                                                    <td colspan="2">字母集：</td><td id="wordSet_PolyR"></td>
                                                    <td colspan="2">分子式：</td><td id="molecularFormula_PolyR"></td>
                                                </tr>
                                                <tr>
                                                    <td>串长度：</td><td id="wordLength_PolyR"></td>
                                                    <td>字集长：</td><td id="wordSetSize_PolyR"></td>
                                                    <td>镜像特征：</td><td><span id="mirrorTrait_PolyR"></span></td>
                                                </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-asterisk"></i><span>异构体</span>
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
                                                <script type="text/html" id="isomerRenderCode">
                                                    <div class="predator-synonym-box">
                                                        <i>1.</i><span class="synonym-box-annotate">同分异构体</span>
                                                        <p>
                                                            <# for( var i in en_isomers ) { #>
                                                            <a href="<%=thisPage.spawnActionQuerySpell()%>&query=<#=en_isomers[i]['en_isomer']#>" target="_blank">
                                                                <#=en_isomers[i]["en_isomer"]#>
                                                            </a>
                                                            <#} #>
                                                        </p>

                                                        <i>2.</i><span class="synonym-box-annotate">同素异构体</span>
                                                        <p>
                                                            <# for( var i in en_allotropys ) { #>
                                                            <a href="<%=thisPage.spawnActionQuerySpell()%>&query=<#=en_allotropys[i]['en_allotropy']#>" target="_blank">
                                                                <#=en_allotropys[i]["en_allotropy"]#>
                                                            </a>
                                                            <#} #>
                                                        </p>
                                                    </div>
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-asterisk"></i><span>点突变</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body">
                                            <script type="text/html" id="mutantRenderCode">
                                                <# var i = 1;
                                                for( var szExp in en_mutants ) {
                                                    var hTypeEach  = en_mutants[szExp];
                                                    for( var szType in hTypeEach ) {
                                                        var hEach  = hTypeEach[szType]; #>
                                                        <div class="predator-synonym-box">
                                                            <#if( szType.indexOf("PointReplace") !== -1  ) { #>
                                                            <i><#=i++#>.</i><span class="synonym-box-annotate"><#=szExp#>替换</span>
                                                            <# } else if( szType.indexOf("PointInsert") !== -1 ) { #>
                                                            <i><#=i++#>.</i><span class="synonym-box-annotate"><#=szExp#>插入/缺失</span>
                                                            <# } #>
                                                            <p>
                                                                <# for( var j in hEach ) {
                                                                var szWord = hEach[j]["en_mutant"]
                                                                #>
                                                                <a href="<%=thisPage.spawnActionQuerySpell()%>&query=<#=szWord#>" target="_blank">
                                                                    <#=szWord#>
                                                                </a>
                                                                <#} #>
                                                            </p>
                                                        </div>
                                                    <#} #>
                                                <#} #>
                                            </script>

                                            <div class="crisp-my-box">
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line" style="font-size: 110%">
                                                            <i class="fa fa-bug"></i><span>连续突变</span>
                                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                <i class="fa fa-angle-down"></i>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                </div>

                                                <div class="box-content">
                                                    <div class="crisp-my-box">
                                                        <div id="serialMutantRenderAt">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="crisp-my-box">
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line" style="font-size: 110%">
                                                            <i class="fa fa-bug"></i><span>异点突变</span>
                                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                <i class="fa fa-angle-down"></i>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                </div>

                                                <div class="box-content">
                                                    <div class="crisp-my-box">
                                                        <div id="heterMutantRenderAt">

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-asterisk"></i><span>复合突变</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">

                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div id="etymologyRoots" style="display:none;" >
                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" >
                            <div class="crisp-my-profile">
                                <div class="col-md-12" >
                                    <h2 style="color: green;">
                                        <span id="erWords_Word_Label"></span>
                                        <span style="float: right;font-size: 80%"><i class="fa fa-flag"></i>&nbsp;<span id="erEtymology_Label"></span></span>
                                    </h2>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-chain"></i><span>关联语言</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>
                        <div class="row box-content">
                            <div class="col-md-12" >
                                <div class="box">
                                    <script type="text/html" id="tplEtyRelevant" >
                                        <#for( var key in relevantSimple ) {#>
                                        <label class="alert-success alert crisp-tiny-tag"><#=relevantSimple[key]["ety_relevant"]#> (<#=relevantSimple[key]["cn_def"]#>)</label>
                                        <#}#>
                                    </script>
                                </div>
                                <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">只对文献负责，数据来源:《www.etymonline.com》</span>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
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
                                <div class="box">
                                    <script type="text/html" id="tplEtyDefs" >
                                        <#for( var k in etyDefs ) {#>
                                        <div class="panel panel-default btn-sharp">
                                            <div class="panel-body predator-slang-def">
                                                <div class="p-sd-word">
                                                    <#=$_GET["query"]#>
                                                    (<# for( var j in etyDefs[k]["pos"] ) { #>
                                                    <#=etyDefs[k]["pos"][j]#>.
                                                    <#if( j != etyDefs[k]["pos"].length -1 ){ #>
                                                    /
                                                    <#}}#>)
                                                </div>
                                                <div class="p-sd-def"><#=etyDefs[k]["def"]#></div>
                                                <div class="p-sd-source">Lang: <#=etyDefs[k]["lang"]#></div>
                                            </div>
                                        </div>
                                        <#}#>
                                    </script>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-crosshairs"></i><span>历史变化</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>
                        <div class="row box-content">
                            <div class="col-md-12" >
                                <div class="box row">
                                    <div class="col-sm-12" style="text-align: center;margin-bottom: 8px">
                                        <div style="border: 1px solid #428bca;height: 300px">
                                            <canvas id="historyRateChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                                <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">数据来源:《Google Ngram》，存在部分精简</span>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-cogs"></i><span>词干词缀</span>
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
                                                                    <#if( row['rank'] !== undefined ) {#>
                                                                    <label class="alert-danger alert fd-tag" title="该词根组的等级(考察意思)。"><#=row['rank']#>(<#=row['r_cn']#>)</label>
                                                                    <#} #>
                                                                    <#if( row['ety'] !== undefined ) {#>
                                                                    <label class="alert-warning alert fd-tag" title="该词根组的最可能词源。"><#=row['ety']#></label>
                                                                    <#} #>
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

                <div id="exampleSentence" style="display:none;">
                    <div class="panel panel-default btn-sharp">
                        <div class="panel-body" >
                            <div class="crisp-my-profile">
                                <div class="col-md-12" >
                                    <h2 style="color: green;">
                                        <span id="eWords_Word_Label"></span>
                                        <span style="float: right;font-size: 80%"><i class="fa fa-language"></i>&nbsp;English</span>
                                    </h2>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-comment-o"></i><span>经典例句</span>
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
                                        <div class="predator-eg-sentence-box">
                                            <ol>
                                                <script type="text/html" id="classicEgSentence">
                                                    <# for( var i=0, j=1; i < generalEgSent.length; ++i ){
                                                    if( generalEgSent[i]["e_type"] == 'basic' ){
                                                    #>
                                                    <li>
                                                        <label><#=j++#></label>
                                                        <div>
                                                            <p class="p-eg-source" id="generalEgSent<#=i#>" >
                                                                <#=#generalEgSent[i]["en_sentence"]#>
                                                                <a class="fa fa-volume-up" style="margin-right: 5%" href="javascript:pageData.fnAudioPlayByDId( 'generalEgSent<#=i#>' );"></a>
                                                            </p>
                                                            <p class="p-eg-target"><#=#generalEgSent[i]["cn_mean"]#></p>
                                                            <p class="p-eg-resource"><#=generalEgSent[i]["e_from"]#></p>
                                                        </div>
                                                    </li>
                                                    <# } } #>
                                                </script>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-comment-o"></i><span>真题例句</span>
                                    <a class="box-down" href="javascript:void(0)" style="float: right">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                </h4>
                            </div>
                        </div>

                        <div class="box-content">
                            <div class="panel panel-default btn-sharp">
                                <div class="panel-body">
                                    <div class="predator-eg-sentence-box">

                                        <script type="text/html" id="bandEgSentence">
                                            <# for( var k in bandEgSMap ) {  #>
                                            <div class="crisp-my-box">
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line" style="font-size: 110%">
                                                            <i class="fa fa-magic"></i><span><#=k#></span>
                                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                <i class="fa fa-angle-down"></i>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                </div>
                                                <div class="box-content">
                                                    <ol>
                                                        <# for( var i=0, j=1; i < bandEgSMap[k].length; ++i ){#>
                                                        <li>
                                                            <label><#=j++#></label>
                                                            <div>
                                                                <p class="p-eg-source"><#=#bandEgSMap[k][i]["en_sentence"]#></p>
                                                                <p class="p-eg-resource"><#=bandEgSMap[k][i]["e_from"]#></p>
                                                            </div>
                                                        </li>
                                                        <# }  #>
                                                    </ol>
                                                </div>
                                            </div>
                                            <#} #>
                                        </script>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="crisp-my-box">
                        <div class="row pad-botm">
                            <div class="col-md-12">
                                <h4 class="header-line">
                                    <i class="fa fa-comment-o"></i><span>例句大全</span>
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
                                        <div class="predator-eg-sentence-box">
                                            <ol>
                                                <script type="text/html" id="moreEgSentence">
                                                    <# for( var i=0, j=1; i < generalEgSent.length; ++i ){
                                                    if( generalEgSent[i]["e_type"] == 'senior' ){
                                                    #>
                                                    <li>
                                                        <label><#=j++#></label>
                                                        <div>
                                                            <p class="p-eg-source" id="moreEgSent<#=i#>">
                                                                <#=#generalEgSent[i]["en_sentence"]#>
                                                                <a class="fa fa-volume-up" style="margin-right: 5%" href="javascript:pageData.fnAudioPlayByDId( 'moreEgSent<#=i#>' );"></a>
                                                            </p>
                                                            <p class="p-eg-target"><#=#generalEgSent[i]["cn_mean"]#></p>
                                                            <p class="p-eg-resource"><#=generalEgSent[i]["e_from"]#></p>
                                                        </div>
                                                    </li>
                                                    <# } } #>
                                                </script>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="advanceDefine" style="display:none;">
                    <div class="crisp-my-box">
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

                <div id="magicReport" style="display:none;">
                    <ul class="nav nav-tabs">
                        <li class="" id="mr_weightIndexLabel">
                            <a href="<%=thisPage.spawnActionQuerySpell( "magicReport" ) + "&mrNode=mr_weight"%>&query=<%=$_GSC.optString("query")%>" >
                                <i class="fa fa-balance-scale"></i> 魔法价值
                            </a>
                        </li>
                        <li class="" id="mr_relationIndexLabel">
                            <a href="<%=thisPage.spawnActionQuerySpell( "magicReport" ) + "&mrNode=mr_relation"%>&query=<%=$_GSC.optString("query")%>" >
                                <i class="fa fa-random"></i> 魔法关系
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content" style="margin-top: 10px">
                        <div id="mr_weight" style="display: none">
                            <div class="crisp-my-box">
                                <div class="table-responsive" style="margin-bottom: -2%">
                                    <table class="table table-striped table-bordered table-hover crisp-picture-table">
                                        <tbody>
                                        <tr>
                                            <td>单词：</td><td id="mrWords_Word_Label"></td>
                                            <td>基本权重：</td><td><span id="mrBaseWeight">%d</span>/110K</td>
                                        </tr>
                                        <tr>
                                            <td>您考试关注：</td><td id="userFocusBand"></td>
                                            <td>您专业关注：</td><td id="userFocusMajor"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-random"></i><span>价值关系树</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                                <div class="row box-content">
                                    <div class="col-md-12 box-content " >
                                        <div class="panel panel-default btn-sharp">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-1">
                                                        <a href="javascript:void(0);" onclick="pageData.fnRenderWordWeightTree( );" class="btn btn-primary btn-sharp">重画</a>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <div class="form-group">
                                                            <input type="radio" id="r-left" name="orientation" checked="checked" value="left" style="width: 15px;margin-top: 10px" />
                                                            <span> 横向</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <div class="form-group">
                                                            <input type="radio" id="r-top" name="orientation" value="top" style="width: 15px;margin-top: 10px" />
                                                            <span> 纵向</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <div class="form-group">
                                                            <input type="radio" id="r-bottom" name="orientation" value="bottom"  style="width: 15px;margin-top: 10px" />
                                                            <span> 底部</span>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-8">
                                                        <p id="word-tree-log" style="margin-top: 8px"></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12" >
                                        <div id="wordWeightTree" style="border: 1px solid #428bca; height: 800px; margin-bottom: 8px">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-balance-scale"></i><span>性价比解算</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="panel panel-default btn-sharp">
                                        <div class="panel-body" >

                                            <div class="crisp-my-box" >
                                                <div class="row pad-botm">
                                                    <div class="col-md-12">
                                                        <h4 class="header-line">
                                                            <i class="fa fa-cubes"></i><span> 历史拟合</span>
                                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                                <i class="fa fa-angle-down"></i>
                                                            </a>
                                                        </h4>
                                                    </div>
                                                </div>
                                                <div class="row box-content">
                                                    <div class="col-md-6" >
                                                        <div class="box row">
                                                            <div class="col-sm-12" style="text-align: center;margin-bottom: 8px">
                                                                <div style="border: 1px solid #428bca;height: 300px">
                                                                    <canvas id="historyEvaluatorLineChart"></canvas>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">多项式拟合预测曲线(假设相互独立,矩估计值)[变阶: 3x]</span>
                                                    </div>

                                                    <div class="col-md-6" >
                                                        <div class="box row">
                                                            <div class="col-sm-12" style="text-align: center;margin-bottom: 8px">
                                                                <div style="border: 1px solid #428bca;height: 300px">
                                                                    <canvas id="historyEvalDeriLineChart"></canvas>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">多项式导数曲线</span>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="mr_relation" style="display: none">
                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-random"></i><span>近义词关系</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="row box-content">
                                        <div class="col-md-12 box-content " >
                                            <div class="panel panel-default btn-sharp">
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-1">
                                                            <a href="javascript:void(0);" onclick="pageData.fnRenderWordWeightTree( );" class="btn btn-primary btn-sharp">重画</a>
                                                        </div>
                                                        <div class="col-sm-1">
                                                            <div class="form-group">
                                                                <input type="radio" id="ws-r-left" name="orientation" checked="checked" value="left" style="width: 15px;margin-top: 10px" />
                                                                <span> 横向</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-1">
                                                            <div class="form-group">
                                                                <input type="radio" id="ws-r-top" name="orientation" value="top" style="width: 15px;margin-top: 10px" />
                                                                <span> 纵向</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-1">
                                                            <div class="form-group">
                                                                <input type="radio" id="ws-r-bottom" name="orientation" value="bottom"  style="width: 15px;margin-top: 10px" />
                                                                <span> 底部</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-8">
                                                            <p id="word-synonym-tree-log" style="margin-top: 8px"></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12" >
                                            <div id="wordSynonymTree" style="border: 1px solid #428bca; height: 800px; margin-bottom: 8px">
                                            </div>
                                        </div>
                                    </div>
                                    <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">采用概率模型动态分析</span>
                                </div>
                            </div>

                            <div class="crisp-my-box">
                                <div class="row pad-botm">
                                    <div class="col-md-12">
                                        <h4 class="header-line">
                                            <i class="fa fa-code"></i><span>上下文关系</span>
                                            <a class="box-down" href="javascript:void(0)" style="float: right">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                        </h4>
                                    </div>
                                </div>

                                <div class="box-content">
                                    <div class="row box-content">
                                        <div class="col-md-12" >
                                            <div class="panel panel-default btn-sharp">
                                                <div class="panel-body">
                                                    <div class="row">
                                                        <div class="col-sm-1">
                                                            <a href="javascript:void(0);" onclick="pageData.fnRender1GWordMarkovChain();" class="btn btn-primary btn-sharp">应用</a>
                                                        </div>
                                                        <div class="col-sm-5 ">
                                                            <div class="form-group com-group-control-search">
                                                                <label for="markov1gPageLimit" style="width: 23%">条数: </label>
                                                                <input class="form-control" id="markov1gPageLimit" type="text" value="20" placeholder="输入条数限制" maxlength="10" style="width: 75%"  />
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6 ">
                                                            <div class="form-group com-group-control-search">
                                                                <label for="markov1gPoS" style="width: 23%">PoS: </label>
                                                                <input class="form-control" id="markov1gPoS" type="text" value="" placeholder="输入PoS" maxlength="10" style="width: 75%"  />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="table-responsive"  >
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                    <tr>
                                                        <td>前</td>
                                                        <td>当前 PoS</td>
                                                        <td>this</td>
                                                    </tr>
                                                    </thead>
                                                    <script type="text/html" id="tplWordFrontMarkov1g">
                                                        <# for( var i in frontMarkov1g ){
                                                        var row = frontMarkov1g[i];
                                                        #>
                                                        <tr>
                                                            <td>
                                                                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>&query=<#=row['en_word']#>">
                                                                    <#=row["en_word"]#>
                                                                </a>
                                                            </td>
                                                            <td><#=row["mk_pos"]#></td>
                                                            <td><#=row["next_word"]#></td>
                                                        </tr>
                                                        <# } #>
                                                    </script>
                                                    <tbody id="wordFrontMarkov1g">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="col-sm-6">
                                            <div class="table-responsive"  >
                                                <table class="table table-striped table-bordered table-hover">
                                                    <thead>
                                                    <tr>
                                                        <td>this</td>
                                                        <td>当前 PoS</td>
                                                        <td>后</td>
                                                    </tr>
                                                    </thead>
                                                    <script type="text/html" id="tplWordNextMarkov1g">
                                                        <# for( var i in nextMarkov1g ){
                                                        var row = nextMarkov1g[i];
                                                        #>
                                                        <tr>
                                                            <td><#=row["en_word"]#></td>
                                                            <td><#=row["mk_pos"]#></td>
                                                            <td>
                                                                <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>&query=<#=row['next_word']#>">
                                                                    <#=row["next_word"]#>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                        <# } #>
                                                    </script>
                                                    <tbody id="wordNextMarkov1g">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                    </div>

                                    <span style="margin-bottom: 5px; font-size: 12px; color: grey; float: right">
                                        采用马尔科夫链模型分析，表示在当前PoS和单词下最大可能的邻接单词。
                                    </span>
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

<%if( thisPage.getModelCommand().equals( "magicReport" ) ) {%>
<script src="/root/assets/js/plugins/spaceTree/excanvas.js"></script>
<script src="/root/assets/js/plugins/spaceTree/jit_space_tree.js"></script>
<script src="/root/root/System/elements/word/WordLinearTree.js"></script>
<%} %>
<script>
    
    var pageData = ${szPageData};
    $_Predator( pageData, {
        "init": function ( host ) {

        },
        "genies": function ( host ) {
            var szCurrentWord = $_GET["query"];

            $_CPD({
                "wordProfile"     : {
                    title: "词汇总览",
                    fn: function(parent) {
                        var fnRenderLazyFrequency = function(){
                            $_PINE("#profileFrequencyGroupBody").html( "<tbody><tr><td>该单词很懒，暂无词频信息</td></tr></tbody>" );
                        };

                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                var bNotEmpty = ( $isTrue(pageData["WordExplication"]) ) && ( pageData["WordExplication"]["basicInfo"].length > 0 );
                                if( !bNotEmpty ){
                                    fnRenderLazyFrequency();
                                }
                                return bNotEmpty;
                            },
                            "pageRenderer": function ( self ) {
                                var szCWordLow = szCurrentWord.toLowerCase();
                                if( szCWordLow === "undefined" ){
                                    self.genieData["wordImgUrl"] = "/root/assets/img/" + undefined + ".png";
                                }
                                else {
                                    self.genieData["wordImgUrl"] = "https://www.youdict.com/images/words/" + szCWordLow + "1.jpg";
                                }
                                Pinecone.Objects.merge( self.genieData, pageData["WordExplication"] );
                                self.renderById( "wordBriefDefine" );

                                self.genieData["gradeLevels"] = pageData["WordExplication"]["gradeLevel"][0]["w_level"];
                                self.genieData["bandLevels"]  = Predator.vocabulary.band.fetchLevels( pageData["WordExplication"]["basicInfo"][0]["w_level"] );
                                self.renderById( "myTags" );

                                var wordFreq = pageData["WordExplication"]["frequency"];
                                if( wordFreq && wordFreq.length > 0 ){
                                    wordFreq = pageData["WordExplication"]["frequency"][0];
                                    self.genieData["nf_band_level"] = parseInt( wordFreq["f_band_level"] );
                                    self.genieData["nband_rank"   ] = parseInt( wordFreq["band_rank"] );
                                    pPine.DOMHelper.yokeIdText(["f_total", "coca_rank"], wordFreq, "profile_");
                                }
                                else {
                                    self.genieData["nf_band_level"] = 0;
                                    self.genieData["nband_rank"   ] = 0;
                                    $_PINE( "#cocaFreqBox" ).hide();
                                }
                                self.renderById ( "basicFrequencyInfo" );
                                $_PINE( "#global_union_freq_rank" ).text( pageData["WordExplication"]["global_union_frequency"][0][ "w_freq_base" ] );

                                self.renderById( "englishDefinesList" );
                            },
                            "renderFrequencyChart": function ( self ) {
                                var wordFreqs  = pageData["WordExplication"]["frequency"];
                                trace( wordFreqs );
                                var pFreqUtils = Predator.vocabulary.frequencyInfo;
                                if( $isTrue( wordFreqs ) && wordFreqs.length > 0 ){
                                    var fc_SumPieData = [
                                        ["交流",0,"#F7604D"], ["文学",0,"#4ED6B8"], ["杂志",0,"#A8D582"], ["新闻",0,"#f8a326"], ["学术",0,"#00acec"]
                                    ];
                                    var fc_EachBarData = [];

                                    var nSumFrequency = 0;
                                    var nPartLength   = wordFreqs.length;
                                    for ( var i = 0; i < nPartLength; ++i ) {
                                        var row = wordFreqs[i];

                                        nSumFrequency        = parseInt( row["f_total"    ] );
                                        fc_SumPieData[0][1] += parseInt( row["f_spoken"   ] );
                                        fc_SumPieData[1][1] += parseInt( row["f_fiction"  ] );
                                        fc_SumPieData[2][1] += parseInt( row["f_magazine" ] );
                                        fc_SumPieData[3][1] += parseInt( row["f_newspaper"] );
                                        fc_SumPieData[4][1] += parseInt( row["f_academic" ] );
                                        var szPoS = row["w_pos"];
                                        var j = 0;
                                        for( var k in row ) {
                                            if( row.hasOwnProperty( k ) && !pFreqUtils.gsOtherInfoKey [ k ] ){
                                                var cnk = pFreqUtils.tryNameCnify( k );
                                                if( cnk ) {
                                                    fc_EachBarData[ j * nPartLength + i ] = [ szPoS + "." + cnk, parseInt( row[k] ), pPine.Random.nextColor() ];
                                                }
                                                ++j;
                                            }
                                        }
                                    }

                                    trace( fc_EachBarData );

                                    Predator.chart.mountDefaultBar( "#eachFreqBarChart", "各部分词频", 480, fc_EachBarData );
                                    Predator.chart.mountDefaultPie( "#wordSumFreqPieChart",$("#eachFreqBarChart").height() + 2, fc_SumPieData );

                                }

                            },
                            "renderBandFrequnency": function ( self ) {
                                var bandFreqs  = pageData["WordExplication"]["band_frequency"];
                                var pFreqUtils = Predator.vocabulary.frequencyInfo;
                                if( $isTrue( bandFreqs ) && bandFreqs.length > 0 ){
                                    var hColors = [ "#F7604D", "#4ED6B8", "#A8D582", "#f8a326" ];
                                    var data = [ ];

                                    var nPartLength   = bandFreqs.length;
                                    for ( var i = 0; i < nPartLength; ++i ) {
                                        var row = bandFreqs[i];
                                        data.push( [ pFreqUtils.bandNameCnify( row["e_type"] ), row["e_frequency" ], hColors[i] ] );
                                        $_PINE("#fBand_" + row["e_type"] ).text( row["e_frequency"] );
                                        $_PINE("#rBand_" + row["e_type"] ).text( row["f_rank"] );
                                    }
                                    $_PINE("#bandWordBarChart").parent().css("height", $("#bandWordFreqList").height() + "px" );
                                    Predator.chart.mountDefaultBar( "#bandWordBarChart","考试词频信息",false, data );
                                }
                                else {
                                    $_PINE("#bandFreqBox").remove();
                                }
                            },
                            "renderCnDictDefs": function ( self ) {
                                var cnDictDefs = pageData["WordExplication"]["cnDictDefs"];
                                var cnDDefsMap = {};
                                for ( var i = 0; i < cnDictDefs.length; i++ ) {
                                    var row   = cnDictDefs[i];
                                    var szPro = row["m_property"];
                                    if( !cnDDefsMap[ szPro ] ){
                                        cnDDefsMap[ szPro ] = [];
                                    }
                                    cnDDefsMap[ szPro ].push( row["cn_word"] );
                                }
                                self.genieData ["cnDDefsMap"] = cnDDefsMap;
                                self.renderById( "cnDictDefinesList" );
                            },
                            "renderTradeDict": function ( self ){
                                self.genieData["tradeDict"] = pageData["WordExplication"]["tradeDict"];
                                var hTradeDict = self.genieData["tradeDict"];
                                if( hTradeDict.length > 0 ){
                                    var tradeMap = {};
                                    for ( var i = 0; i < hTradeDict.length; i++ ) {
                                        var row     = hTradeDict[i];
                                        var szField = row["cn_field"];
                                        var szCn    = row["cn_means"];
                                        if( !tradeMap[ szField ] ){
                                            tradeMap[ szField ] = [];
                                        }
                                        tradeMap[ szField ].push( szCn );
                                    }
                                    self.genieData["tradeDictMap"] = tradeMap;
                                    self.renderById( "tradeDict" )
                                }
                            }
                        } );

                        pageData.fnPhoneticAudioPlay = function ( t ){
                            Predator.vocabulary.phonetic.audioPlay( szCurrentWord, t );
                        };
                    }
                },

                "conjugatedWords" : {
                    title: "词汇关系",
                    fn: function(parent) {
                        $_CPD({
                            "cw_basic": {
                                title: "基础关系",
                                fn: function (parent) {
                                    Predator.wizard.smartGenieInstance( this, {
                                        "init": function ( self ) {
                                            $_PINE("#cWords_Word_Label").text( $_GET["query"] );
                                            return !!pageData["WordExplication"];
                                        },
                                        "renderInflection": function ( self ) {
                                            self.genieData["inflections"] = pageData["WordExplication"]["inflections"];
                                            self.assertRender(
                                                self.genieData["inflections"].length > 0, "inflectionList",
                                                "<tr><td>该单词很懒，暂无相关数据</td></tr>",
                                                function () {
                                                    self.genieData["infGSCnMap"]  = Predator.vocabulary.inflections.gsCnMap;
                                                }
                                            );
                                        },
                                        "renderSynonymAntonym": function ( self ){
                                            self.genieData["w_s_assoc"] = pageData["WordExplication"]["w_s_assoc"];
                                            var hWAssoc = self.genieData["w_s_assoc"];
                                            if( hWAssoc.length > 0 ){
                                                var assocMap = {};
                                                for ( var i = 0; i < hWAssoc.length; i++ ) {
                                                    var row     = hWAssoc[i];
                                                    var szAssoc = row["s_association"];
                                                    var szPoS   = row["s_property"];
                                                    var szCnAn  = row["cn_annotate"];
                                                    assocMap[ szAssoc ] = pPine.Objects.affirmObject( assocMap[szAssoc] );
                                                    assocMap[ szAssoc ][ szPoS ] = pPine.Objects.affirmObject( assocMap[ szAssoc ][ szPoS ] );
                                                    if( !assocMap[ szAssoc ][ szPoS ][szCnAn] ){
                                                        assocMap[ szAssoc ][ szPoS ][szCnAn] = [];
                                                    }
                                                    assocMap[ szAssoc ][ szPoS ][szCnAn].push( row["en_pair"] );
                                                }
                                                if( assocMap["Synonym"] ){
                                                    self.genieData["wsAssocMap"] = assocMap["Synonym"];
                                                    $_PINE( "#assocRenderCode" ).parent().html( self.render( "assocRenderCode", self.genieData ) );
                                                }
                                                if( assocMap["Antonym"] ){ //Share same tpl code.
                                                    self.genieData["wsAssocMap"] = assocMap["Antonym"];
                                                    $_PINE( "#antonymsList" ).parent().html( self.render( "assocRenderCode", self.genieData ) );
                                                }

                                            }
                                        },
                                        "renderSynonymAnalysis": function ( self ) {
                                            self.genieData["synonAnalysis"] = pageData["WordExplication"][ "synonAnalysis" ];
                                            var hSynonA = self.genieData["synonAnalysis"];
                                            if( hSynonA.length > 0 ) {
                                                var sMap = {};
                                                for ( var i = 0; i < hSynonA.length; i++ ) {
                                                    var row        = hSynonA[i];
                                                    var szClanName = row[ "en_clan_name" ];
                                                    sMap[ szClanName ] = pPine.Objects.affirmObject( sMap[ szClanName ] );
                                                    sMap[ szClanName ][ "cn_def" ] = row["c_basic_def"];
                                                    sMap[ szClanName ][ "epitomes" ] = pPine.Objects.affirmArray( sMap[ szClanName ][ "epitomes" ] );
                                                    var epitome = { "epitome": row["w_epitome"], "def": row["detail_def"], "pos": row["m_property"], "cn_dict": row["cn_means"] };
                                                    sMap[ szClanName ][ "epitomes" ].push( epitome );
                                                }
                                                self.genieData[ "synonAnalysis" ] = sMap;
                                                self.renderById( "synonymAnalysis" );
                                            }
                                        },
                                        "renderPhrases": function ( self, hPL ) {
                                            var hPhrases = hPL ? hPL : pageData["WordExplication"][ "phrasesList" ];
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
                                                var html = self.render( "tplPhrasesListCode", self.genieData );
                                                $_PINE("#tplPhrasesList").html( html );

                                                Predator.page.interact.refresh();

                                                pageData.fnRenderMorePhrases = function ( t ){
                                                    $.ajax({
                                                        url:   Predator.spawnActionQuerySpell("getPhrasesList"),
                                                        async:    false,
                                                        type:     "GET",
                                                        dataType: "json",
                                                        data:     { "invoker": Predator.getWizard(), "query": $_GET["query"] },
                                                        success: function (result) {
                                                            self.genieData.fns[ "renderPhrases" ] ( self, result["WordExplication"][ "phrasesList" ] );
                                                            t.remove();
                                                        },
                                                        error: function (result) {
                                                            console.warn( result );
                                                        }
                                                    });
                                                };
                                            }
                                        }
                                    } );
                                }
                            },
                            "cw_poly": {
                                title: "形态关系",
                                fn: function (parent) {
                                    Predator.wizard.smartGenieInstance( this, {
                                        "init": function ( self ) {
                                            $_PINE("#cWords_Word_Label").text( $_GET["query"] );
                                            return $isTrue( pageData["WordExplication"] );
                                        },
                                        "renderBasicTrait" : function ( self ) {
                                            var hTraits = pageData[ "WordExplication" ][ "basic_form_trait" ];
                                            hTraits[ "wordLength" ] = szCurrentWord.length;
                                            $_PMVC.quickRender( hTraits, false, function ( t ) {
                                                return "#" + t + "_PolyR";
                                            } );
                                        },
                                        "renderIsomer": function ( self ) {
                                            self.genieData["en_isomers"]    = pageData["WordExplication"][ "en_isomers" ];
                                            self.genieData["en_allotropys"] = pageData["WordExplication"][ "en_allotropys" ];
                                            self.renderById( "isomerRenderCode" );
                                        },
                                        "renderMutants": function ( self ) {
                                            var fnMapify = function ( szKey ) {
                                                var hWordExplication = pageData[ "WordExplication" ];
                                                var hEnMutants       = hWordExplication[ szKey ];
                                                var hEnMutantsMap    = {};
                                                for ( var i = 0; i < hEnMutants.length; i++ ) {
                                                    var row    = hEnMutants[i];
                                                    var szExp  = row["mut_exponent" ];
                                                    var szType = row["mut_type"     ];

                                                    hEnMutantsMap[ szExp ] = pPine.Objects.affirmObject( hEnMutantsMap[ szExp ] );
                                                    hEnMutantsMap[ szExp ][ szType ] = pPine.Objects.affirmArray( hEnMutantsMap[ szExp ][ szType ] );
                                                    hEnMutantsMap[ szExp ][ szType ].push( row );
                                                }
                                                trace( hEnMutantsMap );
                                                return hEnMutantsMap;
                                            };


                                            self.genieData["en_mutants"] = fnMapify("en_serial_mutants");
                                            $_PINE( "#serialMutantRenderAt" ).parent().html( self.render( "mutantRenderCode", self.genieData ) );

                                            self.genieData["en_mutants"] = fnMapify("en_heter_mutants");
                                            $_PINE( "#heterMutantRenderAt" ).parent().html( self.render( "mutantRenderCode", self.genieData ) );
                                        }
                                    } );
                                }
                            },
                        }).beforeSummon( function ( cpd ) {
                            cpd.afterGenieSummoned = function ( who ) {
                                if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                                    Predator.wizard.conjurer.tabBtn.summoned( who );
                                }
                            };
                        }).summon( $_GET["cwNode"] );
                    }
                },

                "etymologyRoots"  : {
                    title: "词根词源",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                self.genieData["relevantSimple"] = pageData["WordExplication"]["relevantSimple"];
                                $_PINE("#erWords_Word_Label").text( $_GET["query"] );
                                $_PINE("#erEtymology_Label").text( " " + self.genieData["relevantSimple"][0]["ety_relevant"] );
                                return !!pageData["WordExplication"];
                            },
                            "renderRelevant": function ( self ) {
                                self.renderById( "tplEtyRelevant" );
                            },
                            "renderEtymology": function ( self ) {
                                self.genieData["etymologyDefs"] = pageData["WordExplication"]["etymologyDefs"];
                                var hEtymologyDefs = self.genieData["etymologyDefs"];
                                if( hEtymologyDefs.length > 0 ){
                                    var etyMap = {};
                                    for ( var i = 0; i < hEtymologyDefs.length; ++i ) {
                                        var row = hEtymologyDefs[i];
                                        var szId  = row[ "def_id" ];
                                        if( row["cn_pos"] !== undefined ){
                                            szId = row[ "cn_did" ];
                                        }

                                        etyMap[ szId ] = pPine.Objects.affirmObject( etyMap[ szId ] );
                                        etyMap[ szId ][ "pos" ] = pPine.Objects.affirmArray( etyMap[ szId ][ "pos" ] );
                                        if( row["cn_pos"] !== undefined ){
                                            etyMap[ szId ][ "def" ]  = row["com_def"];
                                            etyMap[ szId ][ "lang" ] = "CN";
                                            etyMap[ szId ][ "pos" ].push( row["cn_pos"] );
                                        }
                                        else if( row["en_pos"] !== undefined ){
                                            etyMap[ szId ][ "def" ]  = row["com_def"];
                                            etyMap[ szId ][ "lang" ] = "EN";
                                            etyMap[ szId ][ "pos" ].push( row["en_pos"] );
                                        }
                                    }

                                    self.genieData["etyDefs"] = etyMap;
                                    self.renderById( "tplEtyDefs" );
                                }
                            },
                            "renderFragment": function  ( self ) {
                                self.genieData["fragmentInfos"] = pageData["WordExplication"]["fragmentInfos"];
                                var hFragInfos = self.genieData["fragmentInfos"];
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

                                    //console.log( hFragInfos );
                                    self.genieData["fragDefs"] = etyMap;
                                    self.genieData["fdKinMap"] = Predator.vocabulary.frag.gsCnMap;
                                    self.renderById( "tplFragmentDefs" );
                                    Predator.page.interact.refresh();
                                }
                            },
                            "renderHistoryRate" : function ( self ) {
                                $.ajax({
                                    url:   Predator.spawnActionQuerySpell("getHistoryRate"),
                                    async:    true,
                                    type:     "GET",
                                    dataType: "json",
                                    data:     { "invoker": Predator.getWizard(), "query": $_GET["query"] },
                                    success: function (result) {
                                        var data = result[ "historyRate" ];
                                        if( $isTrue( data ) ){
                                            var years = [];
                                            var count = [];
                                            for ( var k in data ) {
                                                if( data.hasOwnProperty( k ) ){
                                                    var v = data[ k ];
                                                    years.push( k );
                                                    count.push( v );
                                                }
                                            }
                                            Predator.chart.mountDefaultLine("#historyRateChart",years,
                                                [
                                                    [ szCurrentWord , count,"rgb(75, 192, 192)"],
                                                ], false);
                                        }
                                    },
                                    error: function (result) {
                                        console.warn( result );
                                    }
                                });
                            }
                        } );
                    }
                },

                "exampleSentence" : {
                    title: "例句大全",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                $_PINE("#eWords_Word_Label").text( $_GET["query"] );
                                return !!pageData["WordExplication"];
                            },
                            "renderGeneralEg": function ( self ) {
                                self.genieData[ "generalEgSent" ] = pageData["WordExplication"][ "generalEgSentences" ];
                                self.renderById( "classicEgSentence" );
                                self.renderById( "moreEgSentence" );
                            },
                            "renderBandEg": function ( self ) {
                                var hSBand = pageData["WordExplication"][ "bandEgSentences" ];
                                if( hSBand.length > 0 ) {
                                    var sMap = {};
                                    for ( var i = 0; i < hSBand.length; i++ ) {
                                        var row = hSBand[i];
                                        var szType = row["e_type"];
                                        if( !sMap[ szType ] ) {
                                            sMap[ szType ] = [];
                                        }
                                        sMap[ szType ].push( row );
                                    }
                                }
                                self.genieData[ "bandEgSMap" ] = sMap;
                                self.renderById( "bandEgSentence" );
                                Predator.page.interact.refresh();
                            }
                        } );

                        pageData.fnAudioPlayByDId = function ( szDomId ){
                            var h = document.getElementById( szDomId );
                            Predator.vocabulary.phonetic.audioPlay( (h ? h.innerText : ""), 1 );
                        };
                    }
                },

                "advanceDefine"   : {
                    title: "高级词典",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "renderSlang": function ( self ) {
                                self.genieData[ "slangDefs" ]         = pageData["WordExplication"][ "slangDefs" ];
                                self.assertRender(
                                    self.genieData[ "slangDefs" ].length > 0 , "slangDefs",
                                    "<tr><td>该单词很懒，毛也没有</td></tr>",
                                    function () {
                                        self.genieData[ "slangDEGSentences" ] = pageData["WordExplication"][ "slangDefEgSentences" ];
                                        self.genieData[ "slangGSCnMap" ]      = Predator.vocabulary.slang.gsCnMap;
                                    }
                                );
                            }
                        } );
                    }
                },

                "magicReport"     : {
                    title: "魔法数据",
                    fn: function( mrParent ) {
                        $_CPD({
                            "mr_weight": {
                                title: "魔法数据",
                                fn: function (parent) {
                                    Predator.wizard.smartGenieInstance( this, {
                                        "init": function ( self ) {
                                            $_PINE("#mrWords_Word_Label").text( $_GET["query"] );
                                            $_PINE("#userFocusBand" ).text( pageData["UserFocus"]["band"] );
                                            $_PINE("#userFocusMajor").text(
                                                Predator.auxiliary.substr(
                                                    Predator.jsonWordDatumCoding.humanifyJMeans( pageData["UserFocus"]["major"] ) , 0, 20
                                                )
                                            );
                                            if( $isTrue( pageData[ "wordBasicWeight" ] ) ){
                                                $_PINE("#mrBaseWeight").text( pageData[ "wordBasicWeight" ][0]["w_over_base"] );
                                            }
                                        },
                                        "renderTree": function ( self ) {
                                            $.ajax({
                                                url:   Predator.spawnActionQuerySpell("getWordNexusTree"),
                                                async:    true,
                                                type:     "GET",
                                                dataType: "json",
                                                data:     { "invoker": Predator.getWizard(), "query": $_GET["query"] },
                                                success: function (result) {
                                                    var data = result[ "weightNexusTree" ];
                                                    if( $isTrue( data ) ){
                                                        trace( data );
                                                        pageData.fnRenderWordWeightTree = function () {
                                                            var WordWeightTreeLog = {
                                                                elem: null,
                                                                write: function( text ){
                                                                    if ( !this.elem ){
                                                                        this.elem = $_PINE('#word-tree-log');
                                                                    }
                                                                    this.elem.text( text );
                                                                }
                                                            };
                                                            var szAt = "wordWeightTree";
                                                            $_PINE( "#" + szAt ).html("");
                                                            WordLinearTree.render( szAt, WordWeightTreeLog, data );
                                                        };
                                                        pageData.fnRenderWordWeightTree();
                                                    }
                                                },
                                                error: function (result) {
                                                    console.warn( result );
                                                }
                                            });
                                        },
                                        "renderHistoryLine": function ( self ) {
                                            var para9x     = pageData[ "historyEvaluatorLinePara9x"  ];
                                            var para6x     = pageData[ "historyEvaluatorLinePara6x"  ];
                                            var nFirstYear = pageData[ "historyEvaluatorFirstYear" ];
                                            var nCYear     = pageData[ "nLastYear" ] + 1;

                                            var deri9x     = pageData[ "historyEvaluatorLineDeri9x"  ];
                                            var deri6x     = pageData[ "historyEvaluatorLineDeri6x"  ];
                                            if( $isTrue( para9x ) ){
                                                //trace( para9x );
                                                var years = [];
                                                var count9x = [];
                                                var count6x = [];
                                                var cDeri9x = [];
                                                var cDeri6x = [];
                                                for ( var i = 0; i < nCYear - nFirstYear; i++ ) {
                                                    years.push( nFirstYear + i );
                                                    count9x.push( Predator.math.polynomialEval( para9x, i ) * 100 );
                                                    count6x.push( Predator.math.polynomialEval( para6x, i ) * 100 );
                                                    cDeri9x.push( Predator.math.polynomialEval( deri9x, i ) * 100 );
                                                    cDeri6x.push( Predator.math.polynomialEval( deri6x, i ) * 100 );
                                                }
                                                Predator.chart.mountDefaultLine("#historyEvaluatorLineChart",years,
                                                    [
                                                        [ "9x" , count9x,"rgb(75, 192, 192)" ],
                                                        [ "6x" , count6x,"rgba(255,99,132,1)" ],
                                                    ], false);

                                                Predator.chart.mountDefaultLine("#historyEvalDeriLineChart",years,
                                                    [
                                                        [ "9x" , cDeri9x,"rgb(75, 192, 192)" ],
                                                        [ "6x" , cDeri6x,"rgba(255,99,132,1)" ],
                                                    ], false);
                                            }
                                        }
                                    });
                                }
                            },
                            "mr_relation": {
                                title: "魔法数据",
                                fn: function (parent) {
                                    var bSynTreeLoaded = false;
                                    Predator.wizard.smartGenieInstance( this, {
                                        "init"        : function ( self ) {
                                        },
                                        "renderTree"  : function ( self ) {
                                            $.ajax({
                                                url:   Predator.spawnActionQuerySpell("getWordSynonymTree"),
                                                async:    true,
                                                type:     "GET",
                                                dataType: "json",
                                                data:     { "invoker": Predator.getWizard(), "query": $_GET["query"] },
                                                success: function (result) {
                                                    var data = result[ "synonymTree" ];
                                                    if( $isTrue( data ) ){
                                                        trace( data );
                                                        pageData.fnRenderWordWeightTree = function () {
                                                            var WordWeightTreeLog = {
                                                                elem: null,
                                                                write: function( text ){
                                                                    if ( !this.elem ){
                                                                        this.elem = $_PINE('#word-synonym-tree-log');
                                                                    }
                                                                    this.elem.text( text );
                                                                }
                                                            };
                                                            var szAt = "wordSynonymTree";
                                                            $_PINE( "#" + szAt ).html("");
                                                            WordLinearTree.render( szAt, WordWeightTreeLog, data, "ws-" );
                                                        };
                                                        pageData.fnRenderWordWeightTree();
                                                    }
                                                    bSynTreeLoaded = true;
                                                },
                                                error: function (result) {
                                                    console.warn( result );
                                                    bSynTreeLoaded = true;
                                                }
                                            });
                                        },
                                        "renderMarkov": function ( self ) {
                                            var hWait = setInterval( function(){
                                                bSynTreeLoaded = true;
                                                clearInterval( hWait );
                                            }, 5000 );

                                            var hLoader = setInterval( function(){
                                                if( bSynTreeLoaded ){
                                                    trace( bSynTreeLoaded );
                                                    pageData.fnRender1GWordMarkovChain = function () {
                                                        $.ajax({
                                                            url:   Predator.spawnActionQuerySpell("getWordMarkovChain1g"),
                                                            async:    true,
                                                            type:     "GET",
                                                            dataType: "json",
                                                            data:     { "invoker": Predator.getWizard(), "query": $_GET["query"],
                                                                "limit": $_PINE("#markov1gPageLimit").val(), "pos": $_PINE("#markov1gPoS").val(),
                                                            },
                                                            success: function ( result ) {
                                                                self.genieData[ "frontMarkov1g" ] = result[ "frontWords" ];
                                                                $_PINE("#wordFrontMarkov1g").html( template( "tplWordFrontMarkov1g", self.genieData ) );

                                                                self.genieData[ "nextMarkov1g" ] = result[ "nextWords" ];
                                                                $_PINE("#wordNextMarkov1g").html( template( "tplWordNextMarkov1g", self.genieData ) );
                                                            },
                                                            error: function (result) {
                                                                console.warn( result );
                                                            }
                                                        });
                                                    };
                                                    pageData.fnRender1GWordMarkovChain();
                                                    clearInterval( hLoader );
                                                }
                                            }, 1 );
                                        }
                                    });
                                }
                            },
                        }).beforeSummon( function ( cpd ) {
                            cpd.afterGenieSummoned = function ( who ) {
                                if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                                    Predator.wizard.conjurer.tabBtn.summoned( who );
                                }
                            };
                        }).summon( $_GET["mrNode"] );
                    }
                }
            }).beforeSummon( function ( cpd ) {
                cpd.afterGenieSummoned = function ( who ) {
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );
                    }
                };
            }).summon(Predator.getAction());
        },
        "final": function ( host ) {
            pageData.fnSearchKeyWord = function () {
                Predator.searcher.bindSingleSearch( "query", '#queryWord' );
            };
            $_PINE("#queryWord").val( $_GET[ "query" ] );
        }
    });

</script>
${StaticPageEnd}