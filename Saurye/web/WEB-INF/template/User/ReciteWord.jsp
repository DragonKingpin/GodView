<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONArray" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<%
    PredatorArchWizardum thisPage =  PredatorProto.mySoul(request);
    JSONObject $_GSC = PredatorProto.mySoul(request).$_GSC();
    String  szClassId = $_GSC.optString("class_id");
    boolean bIsReciting      = thisPage.getPageData().optBoolean( "IsRecite");
%>
${StaticHead}
<style>
    .vocabtest-body {
        min-height: 600px;
    }
    .vocabtest-body .body-area {
        position: relative;
        min-height: 100%;
    }
    .vocabtest-body .header {
        height: 80px;
        padding-left: 50px;
        padding-top: 27px;
        font-size: 18px;
        color: #333;
        background: #32d4ab;
        box-shadow: 0 4px 10px #eee;
    }
    .current-number {
        position: absolute;
        right: 30px;
        top: 27px;
        z-index: 10;
        font-size: 20px;
    }
    .green-text {
        color: #209e85;
    }
    .current-number {
        position: absolute;
        right: 30px;
        top: 10px;
        z-index: 10;
        font-size: 16px;
        font-weight: 600;
    }
    .word-content {
        width: 45%;
        font-size: 50px;
        margin-top: 210px;
        text-align: center;
    }
    .green-text {
        color: #209e85;
    }
    .pull-left {
        float: left;
    }
    .answer-content {
        margin-top: 70px;
        margin-right: 5%;
        width: 50%;
    }
    .pull-right {
        float: right;
    }
    .answer-content .answer-list {
        overflow: hidden;
    }
    .answer-content .answer-item:first-child {
        border-top: none;
    }
    .answer-content .answer-item {
        position: relative;
        display: block;
        min-height: 30px;
        padding: 15px;
        line-height: 2;
        border-top: 1px solid #c9f4ec;
        font-size: 16px;
        color: #333;
    }
    .answer-content .answer-item:after, .answer-content .answer-item:before {
        display: inline-block;
        vertical-align: middle;
        width: 30px;
        height: 30px;
        line-height: 30px;
    }
    .answer-content .answer-item.wrong-answer:after {
        content: "";
        background: url(../../../root/root/User/img/recite/wrong.png) 50% no-repeat;
        background-size: contain;
    }
    .answer-content .answer-item.wrong-answer {
        background: #fcc;
    }
    .answer-content .answer-item:after {
        position: absolute;
        top: 50%;
        right: 15px;
        height: 20px;
        width: 20px;
        transform: translateY(-50%);
    }
    .answer-content .answer-item.right-answer {
        background: #c9f4ec;
    }
    .answer-content .answer-item.right-answer:after {
        content: "";
        background: url(../../../root/root/User/img/recite/right.png) 50% no-repeat;
        background-size: contain;
    }
    .answer-content .answer-item:after {
        position: absolute;
        top: 50%;
        right: 15px;
        height: 20px;
        width: 20px;
        transform: translateY(-50%);
    }

    .Layout_page__2Wedt .Layout_main__2_zw8 {
        width: 1320px;
        margin-left: auto;
        margin-right: auto;
        background-color: #fff;
        overflow: hidden;
    }
    .StudyDone_page__14PjG {
        padding-bottom: 50px;
    }
    .StudyDone_page__14PjG .StudyDone_header__3fbzi {
        padding-top: 50px;
        margin-bottom: 144px;
        text-align: center;
        height: 404px;
        background-image: -webkit-linear-gradient(top,#ffefc6,rgba(255,241,201,0));
        background-image: linear-gradient(
                180deg
                ,#ffefc6,rgba(255,241,201,0));
    }
    .StudyDone_page__14PjG .StudyDone_header__3fbzi .StudyDone_checkinAward__3_ZNZ {
        max-width: 1021px;
    }
    .StudyDone_page__14PjG .StudyDone_header__3fbzi .StudyDone_checkinSuccess__QF_2f {
        width: 195px;
        height: 50px;
    }
    .StudyDone_page__14PjG .StudyDone_main__1Q5ti {
        display: flex;
        margin: 68px 131px 0;
        padding: 30px 35px;
        border-radius: 12px;
        box-shadow: 0 0 6px 0 #d8d8d8;
        background-color: #fff;
    }
    .StudyDone_page__14PjG .StudyDone_main__1Q5ti .StudyDone_left__3ds89, .StudyDone_page__14PjG .StudyDone_main__1Q5ti .StudyDone_right__3b2ep {
        flex: 1 0;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_good__IIyzL {
        font-size: 20px;
        font-weight: 500;
        color: #030303;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_msg__8nZ0b {
        margin-top: 13px;
        margin-bottom: 46px;
        font-size: 15px;
        color: #333;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_studyAchieves__3NDPY {
        margin-bottom: 16px;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_studyAchieves__3NDPY .StudyDone_label__1NSNm, .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_studyAchieves__3NDPY .StudyDone_value__2W2Zr {
        vertical-align: middle;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_studyAchieves__3NDPY .StudyDone_label__1NSNm {
        display: inline-block;
        width: 47.4px;
        height: 24.3px;
        margin-right: 10px;
        border-radius: 12.2px;
        background-color: #faa21b;
        font-size: 15px;
        font-weight: 500;
        text-align: center;
        color: #fff;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_studyAchieves__3NDPY .StudyDone_value__2W2Zr {
        font-size: 20px;
        font-weight: 500;
        color: #333;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_learningTime__3DaVq {
        font-size: 15px;
        color: #333;
    }
    .StudyDone_page__14PjG .StudyDone_studyInfo__2WENQ .StudyDone_learningTime__3DaVq>span {
        font-weight: 600;
    }
    .StudyDone_page__14PjG .StudyDone_main__1Q5ti .StudyDone_divider__2odO7 {
        width: 2px;
        height: 217px;
        background-color: #d8dbe4;
    }
    .StudyDone_page__14PjG .StudyDone_main__1Q5ti .StudyDone_nextDo__2F4An {
        padding-left: 60px;
    }
    .StudyDone_page__14PjG .StudyDone_nextDo__2F4An .StudyDone_title__2ppdm {
        font-size: 20px;
        font-weight: 500;
        color: #030303;
        margin-bottom: 24px;
    }
    .StudyDone_page__14PjG .StudyDone_nextDo__2F4An .StudyDone_nextDoCollect__Pmccb {
        display: flex;
        list-style: none;
    }
    .StudyDone_page__14PjG .StudyDone_nextDo__2F4An .StudyDone_nextDoItem__1AGPq {
        cursor: pointer;
        text-align: center;
    }
    .StudyDone_page__14PjG .StudyDone_nextDo__2F4An .StudyDone_nextDoItem__1AGPq>img {
        width: 86px;
        height: 86px;
        margin-bottom: 23px;
    }

</style>

<div class="content-wrapper">
    <div class="container" style="width:60%">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label id="currentTitle">个人中心</label> >> <label id="pageNodeTitle"></label>
                </h4>
            </div>
        </div>

        <div class="row" id="doJob">
            <div class="col-md-12">
                <script id="tplA"></script>
                <div id="renderedA"></div>
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body" style="padding: 0px" id="reciteWordList">
                        <div id="vocabtest-container">
                            <div class="vocabtest-body">
                                <div class="body-area">
                                    <script type="text/html" id="tplReciteTable">
                                        <div class="header"><a href="?do=ReciteCenter" class="fa fa-home" style="font-size: 25px"></a></div>
                                        <div class="current-number">
                                                <p class="green-text">需复习:<#=sum_recall#></p>
                                                <p class="green-text">需新学:<#=study_index#></p>
                                        </div>
                                        <div class="content clearfix test-content">
                                            <div class="pull-right answer-content">
                                                <div class="answer-list">
                                                    <# for(var i in massChinese) {
                                                    var button = ['A','B','C','D'];
                                                    #>
                                                    <a href="javascript:;" class="answer-item" onclick="pageData.fnNext(this)" id="cn_means<#=i#>">
                                                        <span><#=button[i]#>:&nbsp;&nbsp;&nbsp;<#=massChinese[i][0]#>. </span><span><#=massChinese[i][1]#></span>
                                                    </a>
                                                    <#}#>
                                                    <a href="javascript:;" class="answer-item" onclick="pageData.fnIKnow(this)">
                                                        <span>E:&nbsp;&nbsp;&nbsp;我认识</span>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="pull-left word-content green-text" id="en_word">
                                                <#=word#>
                                                <div style="font-size: 20px;">
                                                    <span>英: [<#=phonetic#>] </span>
                                                    <a class="fa fa-volume-up" style="margin-right: 5%;" href="javascript:pageData.fnPhoneticAudioPlay(1);"></a>
                                                </div>
                                            </div>
                                        </div>
                                    </script>
                                    <div id="reciteTable"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="padding: 0px;display: none" id="reciteResult">
                        <div id="vocabtest-container2">
                            <div class="vocabtest-body">
                                <div class="body-area">
                                    <div class="header">
                                        <a href="?do=ReciteCenter" class="fa fa-home" style="font-size: 25px"></a>
                                        <span style="margin-left: 42%;font-weight: 600;"> 背诵评估 </span>
                                        <a href="<%=thisPage.spawnActionQuerySpell("goodJob")%>&class_id=<%=szClassId%>" class="fa fa-hand-o-right" style="font-size: 25px;float: right;margin-right: 5%"></a>
                                    </div>
                                    <script type="text/html" id="tplReciteResultTable">
                                    </script>
                                    <div id="learnIndex">
                                        <div class="row pad-botm">
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
                                                            <td>我知道单词数：</td>
                                                            <td><span id="gwPoS_Iknow">0</span></td>
                                                        </tr>
                                                        <tr>
                                                            <td>新单词正确数：</td>
                                                            <td><span id="gwPoS_RNew">0</span></td>
                                                            <td>新单词错误数 v.：</td>
                                                            <td><span id="gwPoS_WNew">0</span></td>
                                                        </tr>
                                                        <tr>
                                                            <td>复习单词正确数：</td>
                                                            <td><span id="gwPoS_ROld">0</span></td>
                                                            <td>复习单词错误数：</td>
                                                            <td><span id="gwPoS_WOld">0</span></td>
                                                        </tr>
                                                        <tr>
                                                            <td>新单词正确率：</td>
                                                            <td><span id="gwPoS_PNew">0</span></td>
                                                            <td>复习单词正确率：</td>
                                                            <td><span id="gwPoS_POld">0</span></td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="col-sm-12" style="text-align: center">
                                                <span>单词学习曲线</span>
                                                <div style="border: 1px solid #428bca;">
                                                    <canvas id="StudyRate"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-md-12"  style="text-align: center" id="wrongWord">
                                                <span>常错单词</span>
                                                <div class="" style="border: 1px solid #428bca; text-align: center" >
                                                    <canvas id="chartWrongWordRank"></canvas>
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
        </div >
        <div class="Layout_main__2_zw8" id="goodJob" style="display: none">
            <script type="text/html" id="tplGoodJob">
                <div class="StudyDone_page__14PjG">
                    <header class="StudyDone_header__3fbzi">
                        <div>
                            <img class="StudyDone_checkinAward__3_ZNZ" src="../../../root/root/User/img/recite/goodjob.png" alt="">
                        </div>
                        <div>
                            <img class="StudyDone_checkinSuccess__QF_2f" src="../../../root/root/User/img/recite/Sign_in.png" alt="">
                        </div>
                    </header>
                    <div class="StudyDone_main__1Q5ti">
                        <div class="StudyDone_left__3ds89">
                            <div class="StudyDone_studyInfo__2WENQ">
                                <div>
                                    <span class="StudyDone_good__IIyzL">非常棒</span>
                                </div>
                                <div class="StudyDone_msg__8nZ0b">天下无难事，唯坚持二字，为成功之要诀</div>
                                <ul class="StudyDone_studyAchieves__3NDPY">
                                    <li><span class="StudyDone_label__1NSNm">新词</span><span class="StudyDone_value__2W2Zr">10/10</span></li>
                                </ul>
                                <div class="StudyDone_learningTime__3DaVq">坚持学习了
                                    <span><#=sum_days#></span>天
                                </div>
                            </div>
                        </div>
                        <div class="StudyDone_divider__2odO7">

                        </div>
                        <div class="StudyDone_right__3b2ep">
                            <div class="StudyDone_nextDo__2F4An">
                                <div class="inner">
                                    <div class="StudyDone_title__2ppdm">接下来你可以</div>
                                    <ul class="StudyDone_nextDoCollect__Pmccb">
                                        <li class="StudyDone_nextDoItem__1AGPq">
                                            <img src="../../../root/root/User/img/recite/home.svg" alt="">
                                            <div class="item-name"> <a href="?do=ReciteCenter">回到首页</a></div>
                                        </li>
                                        <li class="StudyDone_nextDoItem__1AGPq">
                                            <img src="../../../root/root/User/img/recite/glossary.svg" alt="">
                                            <div class="item-name"><a href="?do=PersonalGlossary">生词本</a></div>
                                        </li>
                                        <li class="StudyDone_nextDoItem__1AGPq">
                                            <img src="../../../root/root/User/img/recite/wordtest.svg" alt="">
                                            <div class="item-name">单词测试</div>
                                        </li>
                                        <li class="StudyDone_nextDoItem__1AGPq">
                                            <img src="../../../root/root/User/img/recite/again.png" alt="">
                                            <div class="item-name"><a href="?do=ReciteWord&action=reciteWordList&class_id=<%=szClassId%>">再来一组</a></div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </script>
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
                "reciteWordList": {
                    title: "单词背记",
                    study_index:0,
                    recall_index:0,
                    wrong_times:new Map(),
                    wordData:[],
                    wordTotal:new Map(),
                    bSkip:false,
                    bJuge:false,
                    reciteModel:[1,2],
                    szCurrentWord:null,
                    fn:function(parent){
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                for(var i=0 ;i<pageData["recallWordList"].length;i++){
                                    pageData["reciteWordList"].push(pageData["recallWordList"][i]);
                                }
                                pageData.fnPhoneticAudioPlay = function ( t ){
                                    Predator.vocabulary.phonetic.audioPlay( self.szCurrentWord, t );
                                };
                                function shuffle(arr) {
                                    var len = arr.length;
                                    for (var i = 0; i < len - 1; i++) {
                                        var index = parseInt(Math.random() * (len - i));
                                        var temp = arr[index];
                                        arr[index] = arr[len - i - 1];
                                        arr[len - i - 1] = temp;
                                    }
                                    return arr;
                                }
                                pageData.fnIKnow = function () {
                                    self.wrong_times.set(self.szCurrentWord,-1);
                                    //trace(self.wrong_times);
                                    self.bSkip = true;
                                    pageData.fnNext();
                                };
                                function analysisWord(){
                                    var szMap = {
                                        szEnWord:self.szCurrentWord,
                                        szProperty:pageData["reciteWordList"][0]["m_property"],
                                        nWrongTimes:self.wrong_times.get(self.szCurrentWord),
                                        nDegree:pageData["reciteWordList"][0]["p_recite_degree"]
                                    };
                                  self.wordData.push(szMap);
                                }
                                pageData.jugeChineseMean = function (szButtonId) {
                                    if(self.bSkip){
                                        return self.bSkip;
                                    }
                                    if($(szButtonId).find('span').eq(1).text() == pageData["reciteWordList"][0]["cn_means"]){
                                        $(szButtonId).addClass("right-answer");
                                        return true;
                                    }
                                    else{
                                        $(szButtonId).addClass("wrong-answer");
                                        var times = self.wrong_times.get(self.szCurrentWord);
                                        times++;
                                        if(times>=2){
                                            window.open("?do=WordExplicater&query="+self.szCurrentWord);
                                        }
                                        self.wrong_times.set(self.szCurrentWord,times);
                                        return false;
                                    }
                                 };
                                pageData.fnNext = function (szButtonId) {
                                    //trace(pageData["reciteWordList"]);
                                    if(pageData.jugeChineseMean(szButtonId)){
                                        if( !self.bJuge || pageData["reciteWordList"].length === 1 ){
                                            analysisWord();
                                        }
                                        self.bJuge = false;
                                        self.bSkip = false;
                                        pageData["reciteWordList"][0]["p_recite_degree"] === 0 ? self.study_index++:self.recall_index++;
                                        pageData["reciteWordList"].shift();
                                        if( pageData["reciteWordList"].length !== 0 ){
                                            setTimeout(function () {
                                                self.genieData.fns.renderPlanInfo(self)
                                            },200);
                                        }
                                        else{
                                            //trace(self.wordData);
                                            $.ajax({
                                                url: "?do=ReciteWord&action=reciteResult&class_id="+pageData["classid"],
                                                async: false,
                                                type: "POST",
                                                dataType:"json",
                                                data: {'wordData':JSON.stringify(self.wordData),},
                                                success: function (result) {
                                                   self.genieData.fns[ "renderResult" ] ( self, result );
                                                },
                                                error: function (result) {
                                                    console.warn( result );
                                                }
                                            });
                                        }
                                    }
                                    else{
                                        if(!self.bJuge){
                                            pageData["reciteWordList"][0]["p_recite_degree"] === 0 ? self.study_index-- : self.recall_index--;
                                            pageData["reciteWordList"].push(pageData["reciteWordList"][0]);
                                            self.bJuge = true;
                                        }
                                    }
                                };
                                pageData.massChinese = function () {
                                    var massArray =[];
                                    var szRealCnMean = pageData["reciteWordList"][0]["cn_means"];
                                    massArray[0] = [pageData["reciteWordList"][0]["m_property"],szRealCnMean];
                                    var index = parseInt(Math.random() * (pageData["massWordList"].length -4));
                                    for(var i = 0 ;i<3;i++){
                                        index += i;
                                        massArray[i+1]=[pageData["massWordList"][index]["m_property"],pageData["massWordList"][index]["cn_means"]]
                                    }
                                    shuffle(massArray);
                                    self.genieData["massChinese"] = massArray;
                                }
                            },
                            "renderPlanInfo":function (self) {
                                pageData.massChinese();
                                self.szCurrentWord =  pageData["reciteWordList"][0]["en_word"];
                                if(self.wrong_times.get(self.szCurrentWord)==null){
                                    self.wrong_times.set(self.szCurrentWord,0);
                                }
                                self.genieData["word"] = self.szCurrentWord;
                                self.genieData["phonetic"] = pageData["reciteWordList"][0]["phonetic"];
                                self.genieData["sum_word"] = pageData["sum_word"]+pageData["recall_sum"];
                                self.genieData["study_index"] = pageData["sum_word"]-self.study_index;
                                self.genieData["sum_recall"] = pageData["recall_sum"]-self.recall_index;
                                template("tplReciteTable",self.genieData);
                                $_PINE("#reciteTable").html( template("tplReciteTable",self.genieData));
                            },
                            "renderResult":function ( self, hRL) {
                                var hResult = hRL;
                                trace(hResult);
                                if(hResult!=null){
                                    $_PINE("#reciteResult").css('display','block');
                                    $_PINE("#reciteWordList").css('display','none');
                                    {
                                        var hWordPoS = hResult[ "WordPropertyList" ];
                                        var hWordData = hResult["WordTestData"];
                                        var hColors  = {
                                            "n"    : "#A8D582", "adj" : "#F7604D", "adv" : "#00ACEC", "v"   : "#DB9C3F", "vt"   : "#77ecd5",
                                            "vi"   : "#f8f8a7", "pron": "#3889FC", "prep": "#a898d7", "conj": "#9D66CC", "int"  : "#ec4e6c",
                                            "abbr" : "#D7D768", "aux" : "#4ED6B8", "art" : "#f8a326", "num" : "#d66122", "other": "#ec5618",
                                        };
                                        var commonPos = ["n","adj","adv","v","vt","vi","pron","conj","int","abbr","aux","art","num","other"];
                                            var hRender = [];
                                            var nOther  = 0;
                                            for ( var i = 0; i < commonPos.length; i++ ) {
                                                var szPoS  = commonPos[i];
                                                var nPoS   = hWordPoS[ szPoS ];
                                                hRender[ i ] = [ szPoS, nPoS, hColors[ szPoS ] ];
                                            }
                                            Predator.chart.mountDefaultPie("#pieChartContainerWordSum", $("#glossaryWordPoSList").height(), hRender );
                                            var sumWord = hWordData["RightRecallWord"]+hWordData["RightReciteWord"]+hWordData["WrongRecallWord"]+hWordData["WrongReciteWord"];
                                            $_PINE( "#GlossaryWordSum" ).text( sumWord );
                                            $_PINE( "#gwPoS_Iknow").text(hWordData["ReciteSkipWord"]+hWordData["RecallSkipWord"]);
                                            $_PINE( "#gwPoS_RNew").text(hWordData["RightReciteWord"]);
                                            $_PINE( "#gwPoS_ROld").text(hWordData["RightRecallWord"]);
                                            $_PINE( "#gwPoS_WOld").text(hWordData["WrongRecallWord"]);
                                            $_PINE( "#gwPoS_WNew").text(hWordData["WrongReciteWord"]);
                                            var sumReciteWord = hWordData["WrongReciteWord"]+hWordData["RightReciteWord"];
                                            var sumRecallWord = hWordData["WrongRecallWord"]+hWordData["RightRecallWord"];
                                            if(sumReciteWord==0){
                                                sumReciteWord = 1;
                                            }
                                            if(sumRecallWord==0){
                                                sumRecallWord = 1;
                                            }
                                            var pNew = Math.ceil(hWordData["RightReciteWord"]*1.0/sumReciteWord*1.0*100)+"%";
                                            var pOld = Math.ceil(hWordData["RightRecallWord"]*1.0/sumRecallWord*1.0*100)+"%";
                                            $_PINE( "#gwPoS_PNew").text(pNew);
                                            $_PINE( "#gwPoS_POld").text(pOld);
                                    }
                                    {
                                        var hEachWordsWrongTime  = hResult[ 'WordWrongTimeRank' ];
                                        var hEachWordsRender = [];
                                        if (hEachWordsWrongTime.length==0){
                                            $_PINE("#wrongWord").css("display","none");
                                        }
                                        else{
                                            for( var i = 0; i < hEachWordsWrongTime.length; i++ ){
                                                hEachWordsRender[i] = [ hEachWordsWrongTime[i]['szEnWord'], hEachWordsWrongTime[i]['nWrongTimes'], Pinecone.Random.nextColor() ];
                                            }
                                            Predator.chart.mountDefaultBar( "#chartWrongWordRank","常错单词", 480, hEachWordsRender );
                                        }
                                    }
                                    {
                                        var DateArray = [];
                                        var studyWordArray = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
                                        var StringArray = ["AllReciteDate","RecallDate","ForgetDate"];

                                        var DateMap = new Map();
                                        for(var i=4;i>=0;i--){
                                            var szDate = getNextDate(new Date(),-i)
                                            DateArray.push(szDate);
                                            DateMap.set(szDate,4-i);
                                        }

                                          for(var j=0;j<StringArray.length;j++){
                                              for(var i=0;i<5;i++) {
                                                  if (hRL[StringArray[j]].length > i) {
                                                      trace(DateMap.get(hRL[StringArray[j]][i]["p_recite_date"]));
                                                    studyWordArray[j][DateMap.get(hRL[StringArray[j]][i]["p_recite_date"])] =hRL[StringArray[j]][i]["daily_word"];
                                                  }
                                              }
                                          }

                                        Predator.chart.mountDefaultLine("#StudyRate",DateArray,
                                            [["学习单词",studyWordArray[0],"rgb(75, 192, 192)"],
                                                ["复习单词",studyWordArray[1],"rgba(255,99,132,1)"],
                                                ["遗忘单词",studyWordArray[2],"#3889FC"]]);
                                    }
                                }
                                function getNextDate(date, day) {
                                    var dd = new Date(date);
                                    dd.setDate(dd.getDate() + Number(day));
                                    var y = dd.getFullYear();
                                    var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
                                    var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
                                    return y + "-" + m + "-" + d;
                                };
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
                                self.genieData["PlanInfo"] = pageData["PlanInfo"]
                                self.genieData["planList"] = pageData["planList"];
                                self.genieData["planCount"] = pageData["planCount"][0];
                                self.genieData.Math=Math;
                                trace(self.genieData);
                            },
                            "renderPlanList":function (self) {
                                self.renderById("tplPlanList");
                            }
                        } );
                    }
                },
                "goodJob":{
                    title: "背诵结果",
                    fn: function (parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                              $_PINE("#doJob").css("display","none");
                              self.genieData["sum_days"] = pageData["sum_days"];
                            },
                            "renderPlanList":function (self) {
                              self.renderById("tplGoodJob");
                            }
                        } );
                    }
                }

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