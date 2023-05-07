<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>魔法阅读</title>
    <link href="/root/assets/css/bootstrap.css" rel="stylesheet">
    <link href="/root/assets/css/font-awesome.css" rel="stylesheet">
    <link href="/root/assets/css/Predator.css" rel="stylesheet">
    <style type="text/css">/* Chart.js */
    @-webkit-keyframes chartjs-render-animation{from{opacity:0.99}to{opacity:1}}@keyframes chartjs-render-animation{from{opacity:0.99}to{opacity:1}}.chartjs-render-monitor{-webkit-animation:chartjs-render-animation 0.001s;animation:chartjs-render-animation 0.001s;}</style>
</head>
<style>
    body {
        background-color: #51514F;
        color: #3E433E;
        margin: 0;
        font-family: arial,sans-serif;
        font-size: 14px;
    }
    #novel-en-reader {
        font-family: Georgia,Garamond,Times New Roman,Times,serif;
    }
    .content-justify {
        text-align: justify;
    }
    .container {
        width: 100%;
        max-width: 1000px;
        padding-right: 10px;
        padding-left: 10px;
        margin-right: auto;
        margin-left: auto;
        box-sizing: border-box;
    }
    .novel-content {
        background-color: #E9FAFF;
        color: #333;
        font-size: 21px;
        padding: 10px 45px 20px;
        margin-top: 30px;
        margin-bottom: 40px;
        line-height: 1.5;
    }
    .chapter-title {
        padding-top: 30px;
        font-size: 28px;
        color: #900;
        text-align: center;
        font-family: arial,sans-serif;
    }
    .strong-alpha p::first-letter {
        font-size: 200%;
        color: #000;
    }
    h1 {
        display: block;
        font-size: 2em;
        margin-block-start: 0.67em;
        margin-block-end: 0.67em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
        font-weight: bold;
    }
    .textinfo {
        text-align: center;
        font-size: 13px;
        color: #999;
    }
    .gray3 {
        color: #999;
    }
    a {
        cursor: pointer;
        text-decoration: none;
        color: #06C;
    }
    a, input, textarea, select, button {
        outline: none;
    }
    .popup_wrap {
        position: absolute;
        left: -50px;
        top: 20px;
        background-color: #899893;
        z-index: 20;
        width: 200px;
        margin: 0;
        padding: 10px;
    }
    .popup_wrap a {
        display: block;
        border-radius: 5px;
        width: 30px;
        height: 30px;
        margin-right: 10px;
        margin-bottom: 8px;
        float: left;
    }
    .config-tip {
        color: #fff;
        text-align: left;
        margin: 5px 0;
        clear: both;
    }
    p {
        display: block;
        margin-block-start: 1em;
        margin-block-end: 1em;
        margin-inline-start: 0px;
        margin-inline-end: 0px;
    }
    .chapter-nav {
        text-align: center;
        margin: 20px auto;
    }
    .letter-setting, .txt-justify {
        background-color: #fff;
        color: #555;
        font-weight: bold;
        font-size: 18px;
    }

</style>
<body>
<div class="container" id="novel-en-reader">
    <script type="text/html" id="tplNovelChapter">
        <div class="novel-content strong-alpha" id="novel-content">
            <h1 class="chapter-title"><#=chapterInfo["chapterName"]#></h1>
            <div class="textinfo">
                <span>小说：</span><a class="gray3" target="_blank" href="/novel/2"><#=novelInfo[0]["en_title"]#></a> ( <#=novelInfo[0]["cn_title"]#> )&nbsp;&nbsp;&nbsp;&nbsp;
                <span>作者：</span><a class="gray3" target="_blank" href="/novel/search?keyword=Charles+Dickens"><#=novelInfo[0]["n_author"]#></a> ( <#=novelInfo[0]["cn_name"]#> )        <br>
                <span style="position:relative;">
            <a class="gray3" id="config-reader">[ 阅读设置与语言切换 ]</a>
            <div class="popup_wrap" style="display: none;" id="reader-setting">
                <div class="config-tip">设置背景颜色：</div>
                <a class="color-option" title="淡蓝" style="background-color:#E9FAFF;"></a>
                <a class="color-option" title="淡黄" style="background-color:#FFFFED;"></a>
                <a class="color-option" title="淡绿" style="background-color:#EEFAEE;"></a>
                <a class="color-option" title="淡紫" style="background-color:#FCEFFF;"></a>
                <a class="color-option" title="白色" style="background-color:#FFF;"></a>
                <a class="color-option" title="浅灰" style="background-color:#EFEFEF;"></a>
                <a class="color-option" title="羊皮纸" style="background-color:#EDE9E0;"></a>
                <div class="config-tip">段落首字母是否突出显示：</div>
                <a class="letter-setting" title="yes">是</a>
                <a class="letter-setting" title="no">否</a>
                <div class="config-tip">段落文本是否两端对齐：</div>
                <a class="txt-justify" title="yes">是</a>
                <a class="txt-justify" title="no">否</a>
                <div class="config-tip">翻页快捷键：<br>上一章（左箭头：←）<br>下一章（右箭头：→）</div>
            </div>
            </span>
            </div>
            <# for (var i in chapterContent){
               var row         = chapterContent[i];
               var class_style = row["s_e_class"];#>
            <<#=row["s_element"]#> class="<#=class_style#>"><#=#row["s_content"]#></<#=row["s_element"]#>>
             <#}#>
            <#var novel = novelInfo[0]["en_title"];#>
            <div class="chapter-nav">
                <a id="prev-chapter" style="margin-right: 20px;" href="?do=NovelExhibitor&novel=<#=novel#>&chapter=<#=chapterPreIndex#>">Previous Chapter</a>
                <a id="next-chapter" href="?do=NovelExhibitor&novel=<#=novel#>&chapter=<#=chapterNextIndex#>">Next Chapter</a>
            </div>
        </div>
    </script>
</div>
</body>
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
        },
        "genies":function( parent ){
            $_CPD({
                "showNovelChapterContent":{
                    title: "小说阅读",
                    fn: function(parent){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
                                self.genieData["novelInfo"]      = pageData["novelInfo"];
                                self.genieData["chapterContent"] = pageData["chapterContent"];
                                self.genieData["chapterInfo"]    = pageData["chapterInfo"];

                                var chapterNextIndex = parseInt(pageData["chapterInfo"]["chapter"])+1;
                                var chapterPreIndex  = pageData["chapterInfo"]["chapter"];
                                if(chapterPreIndex !=0){
                                    chapterPreIndex = parseInt(chapterPreIndex)-1;
                                }
                                self.genieData["chapterNextIndex"] = chapterNextIndex;
                                self.genieData["chapterPreIndex"]  = chapterPreIndex;

                            },
                            "renderBuildList":function (self) {
                                self.renderById("tplNovelChapter");
                            }

                        })
                    }
                },
            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                        Predator.wizard.conjurer.superBtn.summoned( who );
                    }
                };
            }).summon(Predator.getAction());
        },
        "final":function( parent ){
        }
    });
</script>
<script>
    var elem_novel_content = document.getElementById('novel-content');

    function set_class_name(elem, is_add_name, class_name) {
        var class_list = elem.className.split(' ');
        var class_name_pos = class_list.indexOf(class_name);

        if (is_add_name) {
            if (class_name_pos == -1) {
                class_list.push(class_name);
            }
        } else {
            if (class_name_pos != -1) {
                class_list.splice(class_name_pos, 1);
            }
        }

        elem.className = class_list.join(' ');
    }

    document.body.onclick = function (e) {
        var elem_config = document.getElementById('config-reader');
        var elem_setting = document.getElementById('reader-setting');
        var elem_target = e.target;

        if (elem_target == elem_config) {
            if (elem_setting.style.display == 'block') {
                elem_setting.style.display = 'none';
            } else {
                elem_setting.style.display = 'block';
            }
        } else if (elem_target.parentNode == elem_setting) {
            var str_target_class = elem_target.className;

            if (str_target_class == 'color-option') {
                var str_color = elem_target.style.backgroundColor;
                elem_novel_content.style.backgroundColor = str_color;
                if (window.localStorage) {
                    window.localStorage.setItem('reader_bg', str_color);
                }
            } else if (str_target_class == 'letter-setting') {
                if (elem_target.title == 'yes') {
                    set_class_name(elem_novel_content, 1, 'strong-alpha');
                } else {
                    set_class_name(elem_novel_content, 0, 'strong-alpha');
                }

                if (window.localStorage) {
                    window.localStorage.setItem('em_alpha', elem_target.title);
                }
            } else if (str_target_class == 'txt-justify') {
                if (elem_target.title == 'yes') {
                    set_class_name(elem_novel_content, 1, 'content-justify');
                } else {
                    set_class_name(elem_novel_content, 0, 'content-justify');
                }

                if (window.localStorage) {
                    window.localStorage.setItem('txt_align', elem_target.title);
                }
            }
        } else if (elem_target != elem_setting) {
            elem_setting.style.display = 'none';
        }
    };

    if (window.localStorage) {
        var reader_bg = window.localStorage.getItem('reader_bg');
        var em_alpha = window.localStorage.getItem('em_alpha');
        var txt_align = window.localStorage.getItem('txt_align');

        if (reader_bg) {
            elem_novel_content.style.backgroundColor = reader_bg;
        }

        if (em_alpha == 'yes') {
            set_class_name(elem_novel_content, 1, 'strong-alpha');
        } else if (em_alpha == 'no') {
            set_class_name(elem_novel_content, 0, 'strong-alpha');
        }

        if (txt_align == 'yes') {
            set_class_name(elem_novel_content, 1, 'content-justify');
        } else if (txt_align == 'no') {
            set_class_name(elem_novel_content, 0, 'content-justify');
        }
    }
    function jumpPage() {
        var event = document.all ? window.event : arguments[0];
        if (event.keyCode == 37) document.location = document.getElementById('prev-chapter').href;
        if (event.keyCode == 39) document.location = document.getElementById('next-chapter').href;
    }
    document.onkeydown=jumpPage;
</script>
</html>
