<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <title id="staticTitle"></title>
    <link rel="icon" href="/root/assets/img/jsu.png">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="keywords" content="" />
    <link rel="stylesheet" href="/root/assets/css/font-awesome.css">
</head>
<style>
    body{
        margin: 0;
        padding: 0;
    }
    .success{
        background-color: #49bf67 !important;
        color:white;
    }
    .fail{
        background-color:#f34541 !important;
        color:white;
    }
    .Message{
        margin: auto;
        width: 30%;
        height: 100%;
        margin-top: 12%;
        text-align: center;
    }
    @media (max-width: 1600px) {
        .Message{
            margin: auto;
            width: 40%;
            height: 100%;
            margin-top: 12%;
            text-align: center;
        }
    }

    .Message:after{
        content: '';
        clear: both;
    }
    .msg{
        margin-bottom: 100px;
    }
    #msg-title{
        margin-top: 80px;
        font-size: 78px;
        letter-spacing: 20px;
    }
    #msg-content{
        margin-top: 10px;
        font-size: 24px;
        width:100%;
        text-align: center;
        letter-spacing: 10px;
    }

    .back{
        color:#f5f5f5 !important;
        text-align: center;
        margin-top: 15%;
        background: #f5f5f5 ;
        border: 4px solid #f5f5f5;
    }
    .back:hover,.back:active{
        background-color: #e6e6e6;
        color: #f34541;
        cursor: pointer;
    }
    .back a{
        width: 100%;
        color: black;
        text-decoration:none
    }
</style>
<body class = "success">
    <div class = "Message ">
        <div class = "msg">
            <div id = "msg-title">
                <i class = "fa-exclamation-circle fa"></i>
                <span>DONE</span>
            </div>
            <div id = "msg-content">
            </div>
            <div class = "back">
                <a id="pageUrl" href="">
                    <div style="width:100%;height:100%">
                        <i class = "fa fa-arrow-left"></i>
                        退回上级页面
                    </div>
                </a>
            </div>
        </div>
    </div>

<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script>
    var pageData = ${szPageData};

    if($_GET['title'] !== undefined) {
        pageData = {
            'title': decodeURIComponent($_GET['title']),
            "url": decodeURIComponent($_GET['url']),
            "state": $_GET['state']
        }
    }

    $(function(){
        action(parseInt(pageData['state']));
        changeSize();
    });
    // 成功
    var title2 = $('#msg-content');
    var title1 = $('#msg-title span');
    var pageUrl = $('#pageUrl');
    function action(flag){
        $('#staticTitle').text('' + pageData['title']);
        if(flag){
            $('body').addClass('success').removeClass('fail');
            title1.text("DONE");
            $('#msg-title i').addClass('fa-smile-o').removeClass('fa-exclamation-circle');
        }
        else{
            $('body').removeClass('success').addClass('fail');
            title1.text("ERROR");
            $('#msg-title i').removeClass('fa-smile-o').addClass('fa-exclamation-circle');
        }
        title2.text(pageData['title']);
        if(pageData['url'] === -1 || pageData['url'] === '-1'){
            pageUrl.attr("href","#");
            pageUrl.attr("onclick","javascript:Pinecone.Navigate.back()");
        }
        else {
            pageUrl.attr("href",pageData['url']);
        }
    }
    var flags = 1;
    $(window).resize(function(){
        changeSize();
    });
    function changeSize(){
        var msgTitle = $('#msg-title');
        var width = document.body.offsetWidth;
        console.log(width);
        if(width >= 990){
            msgTitle.css({
                'font-size':'78px',
                'letter-spacing':'20px'
            });
        }
        else if(width <= 990 && width >= 630){
            msgTitle.css({
                'font-size':'54px',
                'letter-spacing':'10px'
            });
        }
        else {
            msgTitle.css({
                'font-size':'48px',
                'letter-spacing':'0'
            });
        }
    }
</script>
${StaticPageEnd}