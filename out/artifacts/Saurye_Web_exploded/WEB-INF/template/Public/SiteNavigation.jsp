<%@ page contentType="text/html;" pageEncoding="utf-8"%>

${StaticHead}

<div class="content-wrapper">
    <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">
                    <a href="/"><i class="fa fa-home"></i> 首页</a> >> <label id="pageNodeTitle"></label>
                </h4>
            </div>
        </div>


        <div class="row" id="userNavigation" >
            <div>
                <div class="pad-botm" style="margin-bottom: -2%;">
                    <div class="col-md-12">
                        <h4 class="header-line">
                            <i class="fa fa-cube"></i>
                            <span>常用功能</span>
                        </h4>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="crisp-super-btn fb-background crisp-navigation-btn">
                        <a href="?do=GeniusExplorer">
                            <div class="header">
                                <i class="fa fa-search"></i>
                            </div>
                            <div class="btn-Label" style="font-size: 140%">魔法搜索</div>
                        </a>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="crisp-super-btn green-background crisp-navigation-btn">
                        <a href="?do=UserIndex">
                            <div class="header">
                                <i class="fa fa-user-circle-o"></i>
                            </div>
                            <div class="btn-Label" style="font-size: 140%">个人中心</div>
                        </a>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="crisp-super-btn orange-background crisp-navigation-btn">
                        <a href="#">
                            <div class="header">
                                <i class="fa fa-info-circle"></i>
                            </div>
                            <div class="btn-Label" style="font-size: 140%">通知中心</div>
                        </a>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="crisp-super-btn red-background crisp-navigation-btn">
                        <a href="?do=ReciteCenter">
                            <div class="header">
                                <i class="fa fa-book"></i>
                            </div>
                            <div class="btn-Label" style="font-size: 140%">魔法背单词</div>
                        </a>
                    </div>
                </div>
            </div>

            <div>
                <div class="pad-botm" style="margin-bottom: -2%;">
                    <div class="col-md-12">
                        <h4 class="header-line">
                            <i class="fa fa-podcast"></i>
                            <span>私人英语频道</span>
                        </h4>
                    </div>
                </div>
                <div class="col-md-3">
                    <a href="?do=PersonalGlossary" class="btn btn-success btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-sticky-note-o fa-2x"></i></div><div class="inlineSpan">
                        <span>魔法单词本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=PersonalFragments" class="btn btn-info btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-sticky-note-o fa-2x"></i></div><div class="inlineSpan">
                        <span>魔法词根本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=PersonalArticles" class="btn btn-warning btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-edit fa-2x"></i></div><div class="inlineSpan">
                        <span>魔法作文本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=PersonalSentences" class="btn btn-danger btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-edit fa-2x"></i></div><div class="inlineSpan">
                        <span>魔法造句本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="javascript:void(0)" class="btn btn-info btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-lightbulb-o fa-2x"></i></div><div class="inlineSpan">
                        <span>私人字典</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="javascript:void(0)" class="btn btn-success btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-calendar fa-2x"></i></div><div class="inlineSpan">
                        <span>每日推荐</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="javascript:void(0)" class="btn btn-danger btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-smile-o fa-2x"></i></div><div class="inlineSpan">
                        <span>我不知道</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="javascript:void(0)" class="btn btn-warning btn-lg crisp-btn-info" style="margin-bottom: 3%">
                        <div style="float: left"><i class="fa fa-smile-o fa-2x"></i></div><div class="inlineSpan">
                        <span>我不知道</span>
                    </div>
                    </a>
                </div>
            </div>


            <div>
                <div class="pad-botm">
                    <div class="col-md-12">
                        <h4 class="header-line">
                            <i class="fa fa-group"></i>
                            <span>资源社区</span>
                        </h4>
                    </div>
                </div>
                <div class="col-md-3">
                    <a href="?do=MutualGlossary" class="btn fb-background btn-lg crisp-btn-info" style="margin-bottom: 3%;color: white">
                        <div style="float: left"><i class="fa fa-sticky-note-o fa-2x"></i></div><div class="inlineSpan">
                        <span>社区单词本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=MutualFragments" class="btn blue-background btn-lg crisp-btn-info" style="margin-bottom: 3%;color: white">
                        <div style="float: left"><i class="fa fa-sticky-note-o fa-2x"></i></div><div class="inlineSpan">
                        <span>社区词根本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=MutualArticles" class="btn btn-success btn-lg crisp-btn-info" style="margin-bottom: 3%;color: white">
                        <div style="float: left"><i class="fa fa-edit fa-2x"></i></div><div class="inlineSpan">
                        <span>社区作文本</span>
                    </div>
                    </a>
                </div>
                <div class="col-md-3">
                    <a href="?do=MutualSentences" class="btn red-background btn-lg crisp-btn-info" style="margin-bottom: 3%;color: white">
                        <div style="float: left"><i class="fa fa-edit fa-2x"></i></div><div class="inlineSpan">
                        <span>社区造句本</span>
                    </div>
                    </a>
                </div>
            </div>
        </div>


    </div>
</div>

${StaticFooter}
<script src="/root/assets/js/jquery.js"></script>
<script src="/root/assets/js/bootstrap.js"></script>
<script src="/root/assets/js/art-template.js"></script>
<script src="/root/assets/js/pinecone.js"></script>
<script src="/root/assets/js/Predator.js"></script>
<script>

    var pageData = ${szPageData};

    $_Predator( pageData, {
        "init": function ( parent ){

        },
        "genies": function( parent ){
            $_CPD({

                "userNavigation": {
                    title: "网站导航",
                    fn: function( wizard ){
                        Predator.wizard.smartGenieInstance( this , {
                            "init": function ( self ){
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