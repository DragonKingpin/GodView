<%@ page import="Saurye.System.Prototype.PredatorProto" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONObject" %>
<%@ page import="Pinecone.Framework.Util.JSON.JSONArray" %>
<%@ page import="Saurye.System.PredatorArchWizardum" %>
<%@ page contentType="text/html;" pageEncoding="utf-8"%>
<%
    PredatorArchWizardum thisPage =  PredatorProto.mySoul(request);
    JSONObject $_GSC = PredatorProto.mySoul(request).$_GSC();
%>
${StaticHead}

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

                        <div class="predator-user-profile-header">
                            <script type="text/html" id="tplUserBaseInfo" >
                                <div class="col-md-2 p-avatar-field" >
                                    <img id="user-index-avatar" class="img-responsive"  src="<#=avatar#>" alt="" onerror="this.src='/root/assets/img/userImg.jpg'">
                                </div>
                                <div class="col-md-10" >
                                    <h2>
                                        <span><#=username#></span>
                                        <span class="p-sign-introduce"><#=u_sign_introduce#></span>
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("infoMaintain")%>" style="float: right;font-size: 60%"><i class="fa fa-edit"></i>&nbsp;编辑资料</a>
                                    </h2>
                                    <h4><i class="fa fa-briefcase"></i>假的</h4>
                                    <h4><i class="fa fa-graduation-cap"></i>fuck university</h4>
                                    <h4><i class="fa fa-venus-mars"></i><#=u_gender#></h4>
                                    <p class="p-more-info"><i class="fa fa-angle-down"></i>查看详细资料</p>
                                </div>
                            </script>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-9">
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">
                        <div class="row box-content" style="margin-top: -2%">
                            <div class="panel-body">
                                <ul class="nav nav-tabs">
                                    <li class="" id="profileIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell()%>" ><i class="fa fa-map-signs"></i> 信息总览</a>
                                    </li>
                                    <li class="" id="myTagsIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("myTags")%>" ><i class="fa fa-tag"></i> 我的标签</a>
                                    </li>
                                    <li class="" id="footprintIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("footprint")%>" ><i class="fa fa-paw"></i> 足迹</a>
                                    </li>
                                    <li class="" id="collectionsIndexLabel">
                                        <a href="<%=PredatorProto.mySoul(request).spawnActionQuerySpell("collections")%>" ><i class="fa fa-bookmark-o"></i> 收藏</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div id="profile" style="display: none">
                                        <div class="pad-botm">
                                            <h4 class="header-line">
                                                <i class="fa fa-dashboard"></i><span>词汇量</span>
                                                <a class="box-down" href="javascript:void(0)" style="float: right">
                                                    <i class="fa fa-angle-down"></i>
                                                </a>
                                            </h4>
                                        </div>


                                    </div>
                                    <div id="myTags" style="display: none">
                                        <h4>Fuck yjy fuck java</h4>
                                    </div>
                                    <div id="footprint" style="display: none">
                                        <h4>Fuck yjy fuck java fuck js</h4>
                                    </div>
                                    <div id="infoMaintain" style="display:none;">
                                        <div class="pad-botm">
                                            <h4 class="header-line" style="font-size: 110%;">
                                                <span><i class="fa fa-lock"></i> 账号基本信息维护</span>
                                            </h4>
                                        </div>

                                        <div class="row box-content" style="margin-top: -2%">
                                            <div class="panel-body">
                                                <ul class="nav nav-tabs">
                                                    <li class="active"><a href="#fundamental-info" data-toggle="tab">基本信息</a>
                                                    </li>
                                                    <li class=""><a href="#password-info" data-toggle="tab">密码管理</a>
                                                    </li>
                                                </ul>

                                                <div class="tab-content">
                                                    <div class="tab-pane fade active in" id="fundamental-info" style="margin-top: 1%">
                                                        <form name="baseInfoModifyForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnActionControlSpell( "infoMaintain", "modifyBase" )%>" enctype="multipart/form-data">
                                                            <div class="form-group com-group-control">
                                                                <label for="usernameModify">用户名: </label>
                                                                <input class="form-control" name="username" id="usernameModify" type="text"  maxlength="15" readonly/>
                                                            </div>
                                                            <div class="form-group com-group-control">
                                                                <label for="emailModify">邮件: </label>
                                                                <input class="form-control" name="email" id="emailModify" type="text" placeholder="请输入邮件" maxlength="30" />
                                                                <span>该信息用于找回密码，请认真填写！</span>
                                                            </div>
                                                            <div class="form-group com-group-control" id="avatarField">
                                                                <label for="avatarModify" style="margin-right: 1%">头像: </label>
                                                            </div>
                                                            <div class="panel-footer" style="text-align: right;border-radius: 0;">
                                                                <button type="submit" class="btn btn-info" style="width:100px;"><i class="fa fa-save"></i> 保存信息</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div class="tab-pane fade" id="password-info">
                                                        <div class="tab-pane fade active in" style="margin-top: 1%">
                                                            <form name="baseInfoModifyForm" method="POST" action="<%=PredatorProto.mySoul(request).spawnActionControlSpell( "infoMaintain", "modifyBase" )%>" onsubmit="return pageData.fnCheckPw()">
                                                                <div class="form-group com-group-control">
                                                                    <label for="usernameModify-pw">学号: </label>
                                                                    <input class="form-control" name="username" id="usernameModify-pw" type="text"  maxlength="15" readonly/>
                                                                </div>
                                                                <div class="form-group com-group-control">
                                                                    <label for="oldPassword">旧密码: </label>
                                                                    <input class="form-control" name="oldPassword" id="oldPassword" type="password"  maxlength="15" required/>
                                                                </div>
                                                                <div class="form-group com-group-control">
                                                                    <label for="newPassword">新密码: </label>
                                                                    <input class="form-control" name="newPassword" id="newPassword" type="password"  placeholder="应包含数字和字母，不要低于6位！" maxlength="15" required/>
                                                                </div>
                                                                <div class="form-group com-group-control">
                                                                    <label for="confirmPassword">再一次: </label>
                                                                    <input class="form-control"  id="confirmPassword" type="password"  maxlength="15" required/>
                                                                </div>
                                                                <div class="panel-footer" style="text-align: right;border-radius: 0;">
                                                                    <button type="submit" class="btn btn-info" style="width:100px;"><i class="fa fa-save"></i> 保存信息</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="pad-botm">
                                            <h4 class="header-line" style="font-size: 110%;">
                                                <span><i class="fa fa-lock"></i> 个人资料维护</span>
                                            </h4>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-4">
                                                <a href="<?php echo $thisModel::showActionRenderer('myProfile')?>" class="btn btn-success btn-lg crisp-btn-info">
                                                    <div style="float: left"><i class="fa fa-database fa-2x"></i></div><div class="inlineSpan">
                                                    <span>个人资料维护</span>
                                                </div>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="panel panel-default btn-sharp">
                    <div class="panel-body">

                        <div class="crisp-my-box">
                            <div class="row pad-botm">
                                <div class="col-md-12">
                                    <h4 class="header-line">
                                        <i class="fa fa-dashboard"></i><span>词汇量</span>
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
            Predator.tpl.renderById( "tplUserBaseInfo", pageData[ "userBaseInfo" ] );
        },
        "genies": function ( parent ) {
            var szCurrentWord = $_GET["query"];

            $_CPD({
                "profile": {
                    title: "信息总览",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                            },
                        } );
                    }
                },
                "myTags": {
                    title: "我的标签",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                            },
                        } );
                    }
                },
                "footprint": {
                    title: "我的足迹",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                            },
                        } );
                    }
                },
                "collections": {
                    title: "我的收藏",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                            },
                        } );
                    }
                },
                "infoMaintain": {
                    title: "信息维护",
                    fn: function(parent) {
                        Predator.wizard.smartGenieInstance( this, {
                            "init": function ( self ) {
                                if( pageData['accountData'] ){
                                    var accountData = pageData[ 'accountData' ];
                                    $_PMVC.formDynamicRenderer( accountData, "Modify", null );
                                    $_PINE("#avatarField").append("<p style='margin-left: 16%'>推荐大小255*255,图片最大512KB.</p>");
                                    $_PINE("#usernameModify-pw").val( accountData["username"] );
                                }

                                pageData.fnCheckPw = function() {
                                    if( $_PINE("#newPassword").val() !== $_PINE("#confirmPassword").val() ){
                                        alert("两次密码不相等，请重新输入！");
                                        return false;
                                    }
                                    else if( !(new RegExp(/^(?=.*?[a-z)(?=.*>[A-Z])(?=.*?[0-9])[a-zA_Z0-9]{6,15}$/)).test($_PINE("#newPassword").val()) ){
                                        alert("密码应包含字母和数字！且密码不能少于6位！");
                                        return false;
                                    }
                                    return true;
                                };
                            },
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
