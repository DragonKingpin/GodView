<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONArray" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<%
    PredatorArchWizardum thisPage =  PredatorProto.mySoul(request);
    JSONObject $_GSC = PredatorProto.mySoul(request).$_GSC();
    boolean bIsReciting      = thisPage.getPageData().optBoolean( "IsRecite");
%>
${StaticHead}

<style>
    .index_title__nQoBd {
        padding: 10px 0;
        width: 100%;
        margin: 0 auto;
        font-size: 18px;
        color: #333;
        font-weight: 700;
    }
    .index_title__nQoBd .index_bold__1Enh7 {
        font-size: 40px;
        margin: 0 10px;
    }
    .index_status__15KG5 {
        position: relative;
        width: 100%;
        height: 268px;
        border-radius: 20px;
        background-color: #fafafa;
        margin: 0 auto;
        display: flex;
        align-items: center;
        padding: 0 30px;
    }
    .index_status__15KG5 .index_vocabularyLink__1c7FY {
        position: absolute;
        background-color: #28bea0;
        padding: 5px 10px;
        border-top-left-radius: 22.5px;
        border-bottom-left-radius: 22.5px;
        right: 0;
        top: 40px;
        display: flex;
        align-items: center;
        color: #fff;
        text-decoration: none;
        font-size: 16px;
    }
    .index_status__15KG5 .index_left__2l8QX {
        flex: 1 1;
        cursor: pointer;
    }
    .index_status__15KG5 .index_right__54_cL {
        flex: 1 1;
    }
    .Book_book__2zLyg {
        display: flex;
        position: relative;
    }
    .Book_book__2zLyg .Book_img__3bglg {
        width: 205px;
        height: 205px;
        border-radius: 20px;
    }
    .Book_book__2zLyg .Book_right__1bR8n {
        width: 360px;
        margin-left: 28px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        position: relative;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_title__32iYk {
        display: flex;
        align-items: center;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_timeWrapper__1RYvh {
        margin-top: 10px;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_title__32iYk .Book_name__1-4Q1 {
        display: inline-block;
        max-width: 100%;
        _width: 100%;
        vertical-align: middle;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        word-wrap: normal;
        font-size: 20px;
        color: #333;
        font-weight: 700;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_timeWrapper__1RYvh {
        margin-top: 10px;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_timeWrapper__1RYvh .Book_tag__3dJ-F {
        background-color: #28bea0;
        margin-right: 10px;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_timeWrapper__1RYvh .Book_time__1RNcG {
        font-size: 17px;
        color: #333;
        font-weight: 600;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_progText__3qseZ {
        font-size: 16px;
        color: #666;
        width: 100%;
        display: flex;
        justify-content: space-between;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_prog__2AVmh {
        margin-top: 10px;
        position: relative;
        height: 5px;
        background-color: #edeff3;
        border-radius: 3.5px;
    }
    .index_status__15KG5 .index_right__54_cL {
        flex: 1 1;
    }
    .DailyTask_title__30qax {
        font-size: 15px;
        color: #999;
        text-align: center;
        margin-bottom: 20px;
    }
    .DailyTask_itemsWrapper__10XO7 {
        display: flex;
        align-items: center;
        justify-content: space-between;
        text-align: center;
        margin: 0 80px;
    }
    .DailyTask_item__3qF5E .DailyTask_num__1GeJP {
        font-size: 40px;
        color: #333;
        font-weight: 700;
    }
    .DailyTask_item__3qF5E .DailyTask_name__1spOK {
        font-size: 16px;
    }
    .index_button__9uno8 {
        position: relative;
        width: 300px;
        height: 56px;
        margin: 40px auto;
        cursor: pointer;
    }
    .index_quoteContainer__rLSCs {
        border-top: 1px solid #d8dbe4;
        width: 100%;
        margin: 0 auto;
        padding: 25px 0;
    }
    .index_author__125n7, .index_content__2necR, .index_translation__2qOVy {
        font-size: 15px;
        color: #333;
    }
    .index_author__125n7 {
        text-align: right;
    }
    .index_content__2necR {
        font-weight: 700;
    }
    .index_button__9uno8 span {
        color: #fff;
        position: absolute;
        z-index: 2;
        left: 50%;
        top: 50%;
        -webkit-transform: translate(-50%,-50%);
        transform: translate(-50%,-50%);
        font-size: 20px;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_title__32iYk .Book_switchBtn__29Njy {
        width: 24px;
        height: 21px;
        margin-left: 10px;
    }
    .Book_tag__3dJ-F {
        color: #fff;
        border-radius: 4px;
        padding: 2px 5px;
        font-size: 16px;
    }


    .index_container__2E1XM {
        padding: 30px;
        background-color: #fff;
    }
    .index_container__YmQjX .index_header__XwdPA {
        display: flex;
        justify-content: space-between;
        margin-bottom: 25px;
    }
    .index_container__YmQjX .index_header__XwdPA .index_title__2zluf {
        font-size: 16px;
        letter-spacing: 1px;
        font-weight: 600;
    }
    .index_container__YmQjX .index_header__XwdPA .index_entrance__3IZoL {
        font-size: 13px;
        padding: 2px 10px;
        border-radius: 22px;
        color: #fff;
        background-color: #28bea0;
        cursor: pointer;
    }
    .index_container__YmQjX .index_header__XwdPA .index_entrance__3IZoL .index_icon__1P1w8 {
        height: 15px;
        vertical-align: middle;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea {
        margin-top: 20px;
        background-color: #fafafa;
        padding: 20px;
        display: flex;
        border-radius: 15px;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_img__16fFs {
        border-radius: 12.5px;
        width: 200px;
        min-height: 200px;
        height: 200px;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 {
        flex-grow: 1;
        padding-left: 15px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_title__2zluf {
        display: flex;
        justify-content: space-between;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_title__2zluf .index_book__1x5TY {
        font-size: 15px;
        font-weight: 500;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_title__2zluf .index_entrance__3IZoL {
        font-size: 13px;
        color: #28bea0;
        cursor: pointer;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_text__1Hc4c {
        margin-top: 10px;
        font-size: 12px;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_complete__2x6Ox {
        font-size: 12px;
        color: #666;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_progress__1A1NU {
        margin-top: 5px;
        height: 5px;
    }
    .index_progress__3dDPY {
        position: relative;
        width: 100%;
        height: 100%;
        background-color: #f2f3f6;
    }
    .index_progress__3dDPY .index_green__2qjxI {
        position: absolute;
        z-index: 2;
        left: 0;
        width: 45%;
        height: 100%;
        background-color: #28bea0;
        border-radius: 0 30px 30px 0;
    }
    .index_progress__3dDPY .index_lightGreen__3uRir {
        position: absolute;
        z-index: 1;
        left: 0;
        width: 60%;
        height: 100%;
        background-color: #c9e8e4;
        border-radius: 0 30px 30px 0;
    }
    .index_container__2u7Lc {
        margin-top: 50px;
    }
    .index_container__2u7Lc .index_flexBox__NEhPV {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: -8px;
    }
    .index_container__2u7Lc .index_flexBox__NEhPV .index_entrance__2-G2s {
        font-size: 13px;
        padding: 2px 10px;
        border-radius: 22px;
        color: #28bea0;
        border: 1px solid #28bea0;
        cursor: pointer;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y {
        display: flex;
        flex-wrap: wrap;
        align-content: flex-start;
        justify-content: space-between;
        padding-top: 25px;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd {
        flex: 0 0 48%;
        background-color: #fafafa;
        border-radius: 10px;
        margin-bottom: 25px;
        display: flex;
        padding: 25px;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_coinsWrap__3m_2_ {
        position: relative;
        border-radius: 8px;
        overflow: hidden;
        flex: none;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_coinsWrap__3m_2_ .index_img__OSF9- {
        position: relative;
        width: 200px;
        min-height: 200px;
        height: 200px;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 {
        margin-left: 15px;
        display: flex;
        flex-grow: 1;
        flex-direction: column;
        justify-content: space-between;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 .index_name__sO81W {
        font-size: 15px;
        font-weight: 500;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 .index_bookLabel__2fR4x {
        line-height: 20px;
        display: inline-block;
        background-color: #ff593c;
        font-weight: 400;
        border-radius: 3px;
        font-size: 12px;
        color: #fff;
        padding: 0 5px;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 .index_complete__S0Y_E {
        font-size: 13px;
        margin-top: 10px;
        color: #666;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 .index_handleBox__6gJAw {
        display: flex;
        justify-content: space-between;
    }
    .index_container__2u7Lc .index_listBox__3Xp7y .index_bookBox__2iInd .index_content__2fjn3 .index_handleBox__6gJAw .index_handle__1c1p9 {
        font-size: 14px;
        padding: 2px 10px;
        border-radius: 22px;
        background-color: #e3f6f2;
        color: #28bea0;
        cursor: pointer;
    }
    .index_container__2u7Lc .index_flexBox__NEhPV .index_title__V7IqC {
        font-size: 22px;
        letter-spacing: 1px;
        font-weight: 600;
    }
    .index_container__2u7Lc .desk-info {
        display: inline-block;
        margin-left: 10px;
        font-size: 19px;
        font-weight: 500;
        color: #999;
    }
    .Book_book__2zLyg .Book_right__1bR8n .Book_prog__2AVmh>div {
        border-radius: 3.5px;
        height: 100%;
        background-color: #28bea0;
    }
    .index_container__YmQjX .index_bookBox__Pb-ea .index_content__2S6N2 .index_text__1Hc4c>span:first-child {
        font-size: 13px;
        padding: 2px 3px;
        border-radius: 5px;
        background-color: #28bea0;
        color: #fff;
        margin-right: 5px;
    }

</style>

<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label id="currentTitle">个人中心</label> >> <label id="pageNodeTitle"></label>
                </h4>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="row box-content" style="margin-top: -2%">
                            <div class="panel-body">
                                <ul class="nav nav-tabs">
                                    <li class="" id="profileIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" ><i class="fa fa-map-signs"></i> 单词背记</a>
                                    </li>
                                    <li class="" id="myTagsIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("planList")%>" ><i class="fa fa-tag"></i> 我的计划</a>
                                    </li>
                                    <li class="" id="footprintIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("footprint")%>" ><i class="fa fa-paw"></i> 足迹</a>
                                    </li>
                                    <li class="" id="collectionsIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("collections")%>" ><i class="fa fa-bookmark-o"></i> 收藏</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div id="planCenter" style="display: none">
                                        <script type="text/html" id="tplPlanInfo">
                                            <div class="col-md-12">
                                                <% if( bIsReciting ) {%>
                                                <# g_img_href = GlossaryInfo["g_img_href"];
                                                g_name = GlossaryInfo['g_name'];
                                                classid = GlossaryInfo["classid"];
                                                finish_percent = PlanInfo["finish_percent"]+"%;"
                                                #>
                                                <div class="index_title__nQoBd">我在Predator学习<span class="index_bold__1Enh7"><#=PlanInfo["sum_days"]#></span>天</div>
                                                <% }else{%>
                                                <div class="index_title__nQoBd">我在Predator学习<span class="index_bold__1Enh7">0</span>天</div>
                                                <% }%>
                                                <div class="index_status__15KG5">
                                                    <% if( bIsReciting ){%>
                                                    <a class="index_vocabularyLink__1c7FY" href="?do=PersonalGlossary&action=wordList&class_id=<#=GlossaryInfo['classid']#>">
                                                        <i class="fa fa-file-text-o"></i>&nbsp;词表 &gt;
                                                    </a>
                                                    <% }%>
                                                    <div class="index_left__2l8QX">
                                                        <div class="Book_book__2zLyg">
                                                            <% if( bIsReciting ){%>
                                                            <img class="Book_img__3bglg" src="<#=g_img_href#>" alt="<#=g_name#>">
                                                            <%} else {%>
                                                            <img class="Book_img__3bglg" src="../../../root/root/User/img/recite/noImg.jpg" alt="暂无学习计划">
                                                            <%}%>
                                                            <div class="Book_right__1bR8n">
                                                                <div>
                                                                    <div class="Book_title__32iYk">
                                                                        <% if( bIsReciting ){%>
                                                                        <span class="Book_name__1-4Q1"><#=g_name#> </span>
                                                                        <img class="Book_switchBtn__29Njy" src="../../../root/root/User/img/recite/switch.svg" alt="切换单词书">
                                                                        <%} else {%>
                                                                        <span class="Book_name__1-4Q1">暂无学习计划 </span>
                                                                        <img class="Book_switchBtn__29Njy" src="../../../root/root/User/img/recite/switch.svg" alt="切换单词书">
                                                                        <%}%>
                                                                    </div>
                                                                    <div class="Book_timeWrapper__1RYvh">
                                                                        <span class="Book_tag__3dJ-F">预计完成时间</span>
                                                                        <% if( bIsReciting ){%>
                                                                        <span class="Book_time__1RNcG"><#=PlanInfo["need_days"]#> 天</span>
                                                                        <%} else {%>
                                                                        <span class="Book_time__1RNcG">∞ 天</span>
                                                                        <%}%>
                                                                    </div>
                                                                </div>
                                                                <div>
                                                                    <% if( bIsReciting ){%>
                                                                    <div class="Book_progText__3qseZ">
                                                                        <span>已完成<#=PlanInfo["finish_percent"]#>%</span>
                                                                        <span><#=PlanInfo["recited_word"]#>/<#=PlanInfo["sum_words"]#>词</span>
                                                                    </div>
                                                                    <div class="Book_prog__2AVmh">
                                                                        <div style="width: <#=finish_percent#>;">

                                                                        </div>
                                                                    </div>
                                                                    <%} else {%>
                                                                    <div class="Book_progText__3qseZ">
                                                                        <span>已完成 N/A%</span>
                                                                        <span>N/A 词</span>
                                                                    </div>
                                                                    <div class="Book_prog__2AVmh">
                                                                        <div style="width: 0%;">

                                                                        </div>
                                                                    </div>
                                                                    <%}%>
                                                                </div></div>
                                                        </div>
                                                    </div>
                                                    <div class="index_right__54_cL">
                                                        <div>
                                                            <div class="DailyTask_title__30qax">— 今日任务 —</div>
                                                            <div class="DailyTask_itemsWrapper__10XO7">
                                                                <div class="DailyTask_item__3qF5E">
                                                                    <% if( bIsReciting ){%>
                                                                    <div class="DailyTask_num__1GeJP"><#=PlanInfo["plan_glossary_info"]["p_word"]#></div>
                                                                    <%}else{%>
                                                                    <div class="DailyTask_num__1GeJP">无</div>
                                                                    <%}%>
                                                                    <div class="DailyTask_name__1spOK">新词数</div></div>
                                                                <div class="DailyTask_item__3qF5E">
                                                                    <% if( bIsReciting ){%>
                                                                    <div class="DailyTask_num__1GeJP"><#=PlanInfo["recall_word"]#></div>
                                                                    <%}else{%>
                                                                    <div class="DailyTask_num__1GeJP">无</div>
                                                                    <%}%>
                                                                    <div class="DailyTask_name__1spOK">复习单词</div>
                                                                </div>
                                                                <div class="DailyTask_item__3qF5E">
                                                                    <% if( bIsReciting ){%>
                                                                    <div class="DailyTask_num__1GeJP"><#=PlanInfo["today_recited_word"]#></div>
                                                                    <%}else{%>
                                                                    <div class="DailyTask_num__1GeJP">无</div>
                                                                    <%}%>
                                                                    <div class="DailyTask_name__1spOK">已学单词</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="index_button__9uno8">
                                                    <a href="?do=ReciteWord&action=reciteWordList&class_id=<#=classid#>"><span>开始学习</span></a>
                                                    <img src="../../../root/root/User/img/recite/button.svg" alt="开始学习">
                                                </div>
                                                <div class="index_quoteContainer__rLSCs">
                                                    <div>
                                                        <div class="index_content__2necR">A person who never made a mistake never tried anything new.</div>
                                                        <div class="index_translation__2qOVy">一个从不犯错误的人，一定从来没有尝试过任何新鲜事物。</div>
                                                        <div class="index_author__125n7">————Albert Einstein</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </script>
                                    </div>
                                    <div id="planList" style="display: none">
                                        <div class="col-md-12">
                                            <script type="text/html" id="tplPlanList">
                                                <div class="index_container__2E1XM">
                                                    <div>
                                                        <div>
                                                            <# var g_img_href = GlossaryInfo["g_img_href"];
                                                            var g_name = GlossaryInfo['g_name'];
                                                            var finish_percent = PlanInfo["finish_percent"]+"%;"
                                                            var PlanClassid = PlanInfo["plan_glossary_info"]["classid"];
                                                            #>
                                                            <div class="index_container__YmQjX">
                                                                <div class="index_header__XwdPA">
                                                                    <p class="index_title__2zluf">正在学习的单词书</p>
                                                                    <p class="index_entrance__3IZoL">
                                                                        <i class="fa fa-newspaper-o"></i>
                                                                        <a href="?do=PersonalGlossary&action=wordList&class_id=<#=PlanClassid#>" style="color: #f8fcfc"><span> 词表</span></a>
                                                                        <i class="fa fa-angle-right"></i></p>
                                                                </div><div class="index_bookBox__Pb-ea">
                                                                <div>
                                                                    <img class="index_img__16fFs" src="<#=g_img_href#>" alt="<#=g_name#>"></div>
                                                                <div class="index_content__2S6N2">
                                                                    <div>
                                                                        <div class="index_title__2zluf">
                                                                            <p class="index_book__1x5TY"><#=g_name#></p>
                                                                            <p class="index_entrance__3IZoL">
                                                                                <a class="fa fa-cog" data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell("planList")%>#BookPlan<#=PlanClassid#>" style="color: #28bea0">&nbsp;设置任务量</a>
                                                                            </p>
                                                                        </div>
                                                                        <p class="index_text__1Hc4c"><span>预计完成时间</span> <#=PlanInfo["need_days"]#> 天</p>
                                                                    </div>
                                                                    <div>
                                                                        <div>

                                                                        </div>
                                                                        <p class="index_complete__2x6Ox">已完成：<span><#=PlanInfo["recited_word"]#>/<#=PlanInfo["sum_words"]#>词</span></p>
                                                                        <div class="index_progress__1A1NU">
                                                                            <div class="index_progress__3dDPY">
                                                                                <div class="index_green__2qjxI" style="width: <#= finish_percent#>;"></div>
                                                                                <div class="index_lightGreen__3uRir" style="width:<#= finish_percent#>;"></div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <div class="index_container__2u7Lc">
                                                                <div class="index_flexBox__NEhPV">
                                                                    <div><span class="index_title__V7IqC">我的书桌</span><div class="desk-info">
                                                                        <span>(<#=planCount["planCount"]#>/10)</span></div>
                                                                    </div>
                                                                    <p class="index_entrance__2-G2s">
                                                                        <i class="fa fa-calendar-plus-o"></i>
                                                                        <a href="?do=PersonalGlossary" style="color: #28bea0"><span>添加新书</span></a>
                                                                    </p>
                                                                </div>
                                                                <div class="index_listBox__3Xp7y">
                                                                    <# for( var i in planList ){
                                                                    var glossary = planList[i];
                                                                    var classid = glossary["classid"];
                                                                    var g_img_href = glossary['g_img_href'];
                                                                    #>
                                                                    <div class="index_bookBox__2iInd">
                                                                        <div class="index_coinsWrap__3m_2_">
                                                                            <img class="index_img__OSF9-" src="<#=g_img_href#>" alt="">
                                                                        </div>
                                                                        <div class="index_content__2fjn3">
                                                                            <div>
                                                                                <p class="index_name__sO81W"><#=glossary["g_name"]#></p>
                                                                                <div>
                                                                                    <span class="index_bookLabel__2fR4x">真题例句</span>
                                                                                </div><p class="index_complete__S0Y_E">已完成：<span>0/<#=glossary["sum_words"]#></span></p>
                                                                            </div>
                                                                            <div class="index_handleBox__6gJAw">
                                                                            <a  data-toggle="modal" href="<%=thisPage.spawnActionQuerySpell("planList")%>#modalDeleteOne<#=classid#>"><i class="fa fa-trash"></i></a>
                                                                            <a href=<%=thisPage.spawnControlQuerySpell("studyThisBook")%>&class_id=<#=classid#>> <span class="index_handle__1c1p9">学习此书</span></a>
                                                                        </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal fade crisp-union-win" id="modalDeleteOne<#=classid#>" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">
                                                                        <div class="modal-dialog">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                                    <h4 class="modal-title" >是否删除</h4>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    <h4>您确实要删除该计划吗 "<#=glossary["g_name"]#>" 吗?</h4>
                                                                                    <h5>注:您的所有背诵记录都将会删除!!</h5>
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <a href="<%=thisPage.spawnControlQuerySpell("deleteStudyPlan")%>&class_id=<#=classid#>"><button class="btn btn-danger">确定</button></a>
                                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <#}#>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal fade" id="BookPlan<#=PlanClassid#>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                <h4 class="modal-title" id="myModalLabel">计划制定</h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <h3 style="font-weight: lighter"><i class="fa fa-book"></i>词汇书总词量：<strong> <#=PlanInfo["sum_words"]#></strong></h3>
                                                                <form method="POST" name="BookStudyPlan" action="<%=thisPage.spawnControlQuerySpell("setRecitedPlan")%>&class_id=<#=PlanClassid#>" onsubmit="return PineconeInputValueCheck.checkResult()">
                                                                    <label>选择每日任务</label>
                                                                        <select multiple class="form-control" name="p_word" id="p_word" onblur="PineconeInputValueCheck.checkInputValue(this)">
                                                                            <# var nWordSum = PlanInfo["sum_words"]; #>
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
                                    <div id="footprint" style="display: none">
                                        <h4>Fuck yjy fuck java fuck js</h4>
                                    </div>
                                    <div id="infoMaintain" style="display:none;">
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
${SingleImgUploader}
<script>

    var pageData = ${szPageData};
    $_Predator( pageData, {
        "init": function ( parent ) {
        },
        "genies": function ( parent ) {

            $_CPD({
                "planCenter": {
                    title: "单词背记",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                self.genieData["GlossaryInfo"] = pageData["ReciteGlossaryInfo"][0];
                                self.genieData["PlanInfo"] = pageData["PlanInfo"];
                            },
                            "renderPlanInfo":function (self) {
                                self.renderById("tplPlanInfo");
                            }
                        } );
                    }
                },
                "planList": {
                    title: "我的计划",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                self.genieData["GlossaryInfo"] = pageData["ReciteGlossaryInfo"][0];
                                self.genieData["PlanInfo"]     = pageData["PlanInfo"];
                                self.genieData["planList"]     = pageData["planList"];
                                self.genieData["planCount"]    = pageData["planCount"][0];
                                self.genieData.Math            = Math;
                                trace(self.genieData);
                            },
                            "renderPlanList":function (self) {
                                self.renderById("tplPlanList");
                            }
                        } );
                    }
                },

            }).beforeSummon( function ( cpd ) {
                cpd.afterGenieSummoned = function ( who ) {
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.tabBtn.summoned( who );
                    }
                };
            }).summon(Predator.getAction());
        },
        "final": function ( parent ) {
        }
    });

</script>
${StaticPageEnd}
