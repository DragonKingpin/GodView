<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
${StaticHead}

<div class="content-wrapper">
    <div class="container">
        <div class="row">
            <div class="pad-botm" style="margin-bottom: -2%;">
                <div class="col-md-12">
                    <div class="header-line warning" style="text-align: center; color: red">
                        <h1>Bean Nuts Digital Foundation</h1>
                        <h1>Hazelnut Sauron Demon Eyes</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="pad-botm" style="margin-bottom: -2%;">
                <div class="col-md-12">
                    <h4 class="header-line">
                        <i class="fa fa-cube"></i>
                        <span>Common Utility</span>
                    </h4>
                </div>
            </div>
            <a href="?do=UserIndex">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-success back-widget-set text-center btn-sharp">
                        <i class="fa fa-user-circle-o fa-5x"></i>
                        <h3>Personal Space</h3>
                    </div>
                </div>
            </a>
            <a href="?do=GeniusExplorer">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-info back-widget-set text-center btn-sharp">
                        <i class="fa fa-search fa-5x"></i>
                        <h3>Exhaustum Search</h3>
                    </div>
                </div>
            </a>
            <a href="?do=PersonalGlossary">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-danger back-widget-set text-center btn-sharp">
                        <i class="fa fa-sticky-note-o fa-5x"></i>
                        <h3>Archivum</h3>
                    </div>
                </div>
            </a>
            <a href="?do=PersonalSentences">
                <div class="col-md-3 col-sm-3 col-xs-6">
                    <div class="alert alert-warning back-widget-set text-center btn-sharp">
                        <i class="fa fa-edit fa-5x"></i>
                        <h3>魔法造句本</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="row">
            <div class="pad-botm" style="margin-bottom: -2%;">
                <div class="col-md-12">
                    <div class="header-line warning" style="text-align: center; color: red">
                        <p>警告：该平台作为Bean Nuts Digital Foundation (数字坚果数据中心) 项目测试使用</p>
                        <p>目前未以任何形式开放使用，任何未经授权任何时间、任何形式的数据采集（包括爬虫、下载等任何形式）、渗透、逆向工程等</p>
                        <p>将面临法律允许范围的尽可能的起诉！</p>
                    </div>

                    <div class="header-line warning" style="text-align: center; color: red">
                        <p>Warning：Copyright (C) Bean Nuts Digital Foundation All rights reserved.</p>
                        <p>NO ANY OFFICIAL OPEN ACCESSED ! NO ANY FORMATTED DATA ACCESSED、 NO SPIDER、 NO DOWNLOAD !</p>
                        <p>FUCK YOU SO SUPPER HARD IF YOU STOLEN MY FUCKING DATASET !!!!!!</p>
                    </div>

                    <div class="header-line warning" style="text-align: center; color: red">
                        <p>Data fures est murem similem</p>
                    </div>
                </div>
            </div>
            <div class="pad-botm" style="margin-bottom: -2%;">
                <div class="col-md-12">
                    <h4 class="header-line">
                        <i class="fa fa-newspaper-o"></i>
                        <span>平台新闻</span>
                    </h4>
                </div>
            </div>
            <div class="crisp-my-box" id = "news" style="margin-top: 6%">
            </div>
            <ul class="pagination" id = "newsPageList"></ul>
        </div>


    </div>
</div>
${StaticFooter}
<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/bootstrap.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script>
    var pageData = ${szPageData};

    (function showNewsList() {
        var dataStream = pageData['tableData'];
        var tableZone = '';

        for (var i = 0; i < dataStream.length; i++) {
            tableZone += '<div class="panel panel-hr">\n' +
                '                        <div class="panel-body">\n' +
                '                        <div class="crisp-news-box">\n' +
                '                        <div class="col-md-2">\n' +
                '                        <a href="/lambdaPageView'+'?classid='+dataStream[i]['classid']+'&classname='+pageData['SelfClassName']+'">' +
                '                        <img class="img-responsive" src="' + dataStream[i]['mainimage'] + '" alt="" onerror="this.src=system; this.title=\'图片未找到 !\'"></a>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-10 crisp-my-profile">\n' +
                '                        <p style="margin-left: 0;font-size: 22px;margin-bottom: -1%"><a href="/lambdaPageView'+'?classid='+dataStream[i]['classid']+'&classname='+pageData['SelfClassName']+'"><strong>' + dataStream[i]['title'] + '</strong></a></p>\n' +
                '                    <hr/>\n' +
                '                    <p style="margin-top: -1%"><strong> 发布日期：</strong><span >' + dataStream[i]['posttime'] + '</span></p>\n' +
                '                    <p style="margin-top: -1%">' + pPine.String.hypertext2Text(dataStream[i]['content'],true,true).substr(0,150)  + '...</p>\n' +
                '                    </div>\n' +
                '                    </div>\n' +
                '                    </div>\n' +
                '                    </div> ';
        }
        $_PINE('#news').append(tableZone);
    })();
    trace( $_COOKIE )
    Predator.paginate.smartMount( '#newsPageList', pageData  );

</script>
${StaticPageEnd}