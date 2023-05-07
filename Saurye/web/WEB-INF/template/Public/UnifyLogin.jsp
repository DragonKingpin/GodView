<%@ page contentType="text/html;" pageEncoding="utf-8"%>

<!doctype html>
<html>
<head>
    <title>Sauron Eyes Unify Login</title>
    <link rel="icon" href="<?php echo CrispInfrastructureModel::getIconTiny();?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="keywords" content=""/>
    <script type="application/x-javascript">
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        } </script>
    <!-- css files -->
    <link href="/root/assets/css/unifyLogin.css" rel='stylesheet' type='text/css' media="all"/>
</head>
<body>

<div class="head">
    <a href="/" class="logo-version">
        <img src="/root/assets/img/logo.png" class="logo">
    </a>
</div>

<div class="log">

    <div id="unifyLogin">
        <h1>Sauron Eyes</h1>
        <div class="LogoField">
            <img src="/root/assets/img/banner.png" alt="logo" style="position:relative; margin-bottom: -1.8%; width: 45%">
            <h2 style="font-size: 180%">Sauron insights omniscience</h2>
        </div>
        <div class="InputField">
            <h2>Salve !</h2>
            <form id="checkFrom" name="checkFrom" method="POST" action="?do=UnifyLogin&control=loginCheck" onsubmit="return pageData.checkLoginFrom()">
                <input name="username" type="text" class="ipt" id="username" placeholder="Input UserName" value="" required="required">
                <input name="password" type="password" class="ipt" id="password" placeholder="Input PassWord" value="" required="required">
                <%--        <?php if(@$_COOKIE['PwErrorTime'] && @$_COOKIE['PwErrorTime'] > 4){?>
                        <div style="margin-top: 25px">
                            <input type="text" name="vcode" value="" maxlength="5" placeholder="输入验证码" style="width: 48%;margin-top: 0" required>
                            <img style="width: 20%;float: right;margin-right: 10%;margin-left: -10%" id="verifyCode" src="?pine=vcode" onclick="this.src='?pine=vcode&t='+Math.random()" title="看不清，换一张"  height="42">
                        </div>
                        <?php } else { ?>--%>
                <div class="verify-wrap" id="verify-wrap">
                    <div class="drag-progress dragProgress"></div>
                    <span class="drag-btn dragBtn" style="left: -1px;"></span>
                    <span class="fix-tips fixTips">Young dragon! Drag this to the right.</span>
                    <span class="verify-msg sucMsg">Verified</span>
                </div>
                <?php } ?>
                <div class="button-row">
                    <input type="submit" class="sign-in" value="Login">
                    <input type="button" class="reset" value="Clear" onclick="(function() {
                    document.getElementById('username').value = '';
                    document.getElementById('password').value = '';
                })();">
                    <div class="clear"></div>
                </div>
                <label style="color: red;font-size:110%;float: left;margin-left: 11%" id="warningInfo"></label>
                <label style="float: right;margin-right: 11%"><a href="javascript:alert('吃屎吧，没这玩意，Then eating shit！')">Forget?</a></label>
            </form>
        </div>
        <div class="clear"></div>
    </div>

</div>

<div class="footer" style="margin-top: 4%;padding: 15px;text-align: center;">
    <p>Ave <a href="http://www.rednest.cn/" target="_blank">undefinitus</a>, omnipotens est !  | Copyright © 2008 - 2028 JHW (undefined) All rights reserved.</p>
    <p>Powered by : <a href="http://www.nutgit.com/" target="_blank">Bean Nuts Digit Foundation</a> | With Pinecone and Ulfheðinn</p>
</div>


<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script src="/root/assets/js/jq-slideVerify.js" type="text/javascript" charset="utf-8"></script>
<script>

    var pageData = ${szPageData};

    $_Predator( pageData, {
        "init": function ( parent ){
        },
        "genies": function( parent ){
            $_CPD({

                "unifyLogin": {
                    title: "网站导航",
                    fn: function( wizard ){
                        var $_POST = pageData[ "S_POST" ];

                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ) {
                                pPine.renderer.quickRender( $_POST, "", function ( t ) {
                                    return "#" + t;
                                } );

                                if( $_GET[ "referHref" ] ) {
                                    $_PINE("#checkFrom").attr( "action",
                                        Predator.spawnControlQuerySpell( "loginCheck" ) + "&referHref=" + encodeURIComponent( $_GET[ "referHref" ] )
                                    );
                                }
                            },

                            "initSlideCheck": function ( self ) {
                                pageData["PwErrorTime"] = null;

                                var slideVerify = undefined;
                                var isVerify = false;

                                function createNewSlide(widthNum) {
                                    var SlideVerifyPlug = window.slideVerifyPlug;
                                    return new SlideVerifyPlug('#verify-wrap', {
                                        wrapWidth: widthNum,
                                        initText: 'Young dragon! Drag this to the right.',
                                        sucessText: 'Verified',
                                        getSucessState: function (res) {
                                            isVerify = true;
                                        }
                                    });
                                }

                                $(function () {
                                    slideVerify = createNewSlide($('#password').width() + 50);
                                    isVerify = slideVerify.slideFinishState;
                                });

                                $(window).resize(function () {
                                    var indexWidth = $('#password').width() + 50;
                                    slideVerify.setNewWidth(indexWidth);
                                });

                                pageData.checkLoginFrom = function() {
                                    if( pageData['PwErrorTime'] && pageData['PwErrorTime'] >= 5 ){
                                        return true;
                                    }
                                    console.log( pageData['PwErrorTime'] );
                                    if ( !isVerify ) {
                                        $_PINE('#warningInfo').text("请拖动滑块完成验证");
                                        return false;
                                    }
                                    return true;
                                }
                            }
                        })
                    }
                }

            }).beforeSummon(function ( cpd ) {
                cpd.afterGenieSummoned = function( who ){
                    if( pPine.PrototypeTraits.isObject( cpd.dom[ who ] ) ){
                        $_PINE("#pageNodeTitle").text( cpd.dom[ who ]["title"] );
                    }
                };
            }).summon( Predator.getAction() );
        },
        "final":function( parent ){
            Predator.page.surveyQueryStrAndBind({

            });
        }
    });

</script>
${StaticPageEnd}