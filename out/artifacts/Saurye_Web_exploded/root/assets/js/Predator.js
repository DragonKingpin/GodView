/**
 * Saurye 1.5
 * Copyright(C)Bean Nuts Foundation (Tyrant Group)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Code by Tyrant Group
 * ;) Hope you enjoy this
 */

UsingNamespace : {
    var pPTraits = Pinecone.PrototypeTraits;
}

var Predator = {
    config:{
        "WizardParameter"  : "do",
        "ControlParameter" : "control",
        "ModelParameter"   : "action",
        "SystemWizard"     : "SystemCoven",
    },

    pageData:{},

    init:function () {

    },

    getWizard:function(){
        return $_GET[ Predator.config.WizardParameter ]
    },

    getAction:function(){
        return $_GET[ Predator.config.ModelParameter ]
    },

    getControl:function(){
        return $_GET[ Predator.config.ControlParameter ]
    },

    spawnWizardQuerySpell: function( szPrototype ){
        return "?" + this.config.WizardParameter + "=" + szPrototype;
    },

    spawnWizardActionSpell: function( szPrototype, szActionFnName ){
        var szQueryString = "?" + this.config.WizardParameter + "=" + szPrototype;
        if( szActionFnName ){
            return szQueryString + "&" + this.config.ModelParameter + "=" + szActionFnName;
        }
        return szQueryString;
    },

    spawnWizardControlSpell: function( szPrototype, szControlFnName ){
        var szQueryString = "?" + this.config.WizardParameter + "=" + szPrototype;
        if( szControlFnName ){
            return szQueryString + "&" + this.config.ControlParameter + "=" + szControlFnName;
        }
        return szQueryString;
    },

    spawnActionQuerySpell: function( szActionFnName ){
        return Predator.spawnActionControlSpell( szActionFnName, null );
    },

    spawnControlQuerySpell: function( szControlFnName ){
        return Predator.spawnActionControlSpell( null, szControlFnName );
    },

    spawnActionControlSpell: function( szActionFnName, szControlFnName ){
        var szQueryString = "?" + this.config.WizardParameter + "=" + this.getWizard();
        if( szActionFnName ){
            szQueryString += "&" + this.config.ModelParameter + "=" + szActionFnName;
        }
        if( szControlFnName ){
            szQueryString += "&" + this.config.ControlParameter + "=" + szControlFnName;
        }
        return szQueryString;
    },

    spawnSystemActonQuerySpell: function( szActionFunctionName ){
        var szQueryString = "?" + this.config.WizardParameter + "=" + this.config["SystemWizard"];
        if( szActionFunctionName ){
            return szQueryString + "&" + this.config.ModelParameter + "=" + szActionFunctionName;
        }
        return szQueryString;
    },

    spawnSystemQuerySpell: function( szControlFunctionName ){
        var szQueryString = "?" + this.config.WizardParameter + "=" + this.config["SystemWizard"];
        if( szControlFunctionName ){
            return szQueryString + "&" + this.config.ControlParameter + "=" + szControlFunctionName;
        }
        return szQueryString;
    },

    QuerySpell: {
        wordExplicaterSpell: function () {
            return Predator.spawnWizardActionSpell( "WordExplicater" , null );
        },

        queryWord: function ( szWord ) {
            return Predator.QuerySpell.wordExplicaterSpell() + "&query=" + szWord;
        }
    },

    warnCommonDialog:function (uiID, title, content, url, btnTitle) {
        btnTitle = btnTitle?btnTitle:"确定";
        return '<div class="modal fade crisp-union-win" id="' + uiID + '" tabindex="-1" role="dialog" aria-labelledby="crisp-WarnCommonLabel" aria-hidden="true" style="margin-top: 6%;text-align: left">\n' +
            '    <div class="modal-dialog">\n' +
            '        <div class="modal-content">\n' +
            '            <div class="modal-header">\n' +
            '                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>\n' +
            '                <h4 class="modal-title" id="crisp-WarnCommonLabel">' + title + '</h4>\n' +
            '            </div>\n' +
            '            <div class="modal-body">' + content + '</div>\n' +
            '            <div class="modal-footer">\n' +
            '                <a href="' + url + '"><button class="btn btn-danger">'+btnTitle+'</button></a>\n' +
            '                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>\n' +
            '            </div>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '</div>';
    },

    simpleCommonDialog:function (uiID, title, content,btnTitle){
        btnTitle = btnTitle?btnTitle:"关闭";
        return '<div class="modal fade crisp-union-win" id="' + uiID + '" tabindex="-1" role="dialog" aria-labelledby="crispSimpleModalLabel" aria-hidden="true" style="margin-top: 6%;">\n' +
            '    <div class="modal-dialog">\n' +
            '        <div class="modal-content">\n' +
            '            <div class="modal-header">\n' +
            '                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>\n' +
            '                <h4 class="modal-title" id="myModalLabel">' + title + '</h4>\n' +
            '            </div>\n' +
            '            <div class="modal-body">\n' + content + '</div>\n' +
            '            <div class="modal-footer">\n' +
            '                <button type="button" class="btn btn-default" data-dismiss="modal">'+btnTitle+'</button>\n' +
            '            </div>\n' +
            '        </div>\n' +
            '    </div>\n' +
            '</div>';
    },

    renderTable:function (tableStream,keyArray) {
        var table = "";
        if(tableStream){
            for(var key in keyArray){
                if(keyArray.hasOwnProperty(key) && tableStream.hasOwnProperty(keyArray[key])){
                    table += "<td>" + tableStream[keyArray[key]] + "</td>";
                }else {
                    table += "<td>&nbsp;</td>";
                }
            }
        }
        return table;
    },

    appendTableWhileThereAreData:function (at,dataStream) {
        if(dataStream){
            $_PINE(at).html(dataStream);
        }
    },

    massDeleteListener: function (at,control,data) {
        $(at).on('click', function () {
            var check = $("input[type=checkbox][class!=allcheck]:checked");
            if (check.length < 1) {
                alert('请选择要删除的记录!');
                return false;
            }
            if (confirm("您确认要删除这些记录吗?")) {
                var ids = [];
                check.each(function (i) {ids[i] = $(this).val();});
                data = data?(function (){var t = {};t[data] = ids;return t;})():{id: ids};
                $_PINE.ajax({
                    type: "POST",
                    url: control,
                    dataType: "text", data: data,
                    success: function (data) {
                        if( data === "true" ){
                            alert('删除成功！');
                            location.reload();
                        }
                        else {
                            alert('删除失败，请联系管理员！');
                        }
                    }
                });
            }
        });
    },

    smartMassDeleteListener: function ( hfnControlName, data ){
        Predator.massDeleteListener( "#" + hfnControlName, Predator.spawnControlQuerySpell( hfnControlName ), data  );
    },

    checkAll: function( that, selector ) {
        console.log( that )
        var checked = $(that).get(0).checked;
        $( selector ? selector + " ":"" + "input[type=checkbox]").prop("checked", checked);
    },

    renderLaydate:function (arr) {
        for(var row in arr){
            var k = Object.keys(arr[row])[0];
            laydate.render({elem:k , type: arr[row][k]});
        }
    },

    quickRenderLaydate:function (arr,type) {
        for(var row in arr){
            laydate.render({elem:arr[row] , type: (type?type:"datetime")});
        }
    },

    parseSystemAuthority :function ( t ) {
        var r;
        return (r = { "normal":"普通用户", "vip":"VIP", "admin":"管理员", "super":"超级管理员" }[t])? r : "普通用户";
    },
};


Predator.chart = {
    mountDefaultPie: function (at,height,tuple) {
        var hCanvasHandle = $(at +" canvas");
        if (hCanvasHandle.length) {
            try{
                $(at).css("height", height + "px");
                var chartData = [], colors = [], labels = [];
                for(var i=0; i<tuple.length; i++){
                    labels.push(tuple[i][0]);
                    chartData.push(tuple[i][1]);
                    colors.push(tuple[i][2]);
                }
                new Chart(
                    hCanvasHandle[0].getContext("2d"),
                    {type: "pie", data: {datasets: [{data: chartData, backgroundColor: colors}], labels: labels},
                        options: {
                            responsive: true, maintainAspectRatio: false, layout: {padding: {left: 10, right: 10, top: 10, bottom: 10}}, legend: {position: "right"}
                        }
                    }
                );
            }catch (e) {}
        }
    },

    mountDefaultBar: function (at,title,width_threshold,tuple) {
        var hHandle = $(at);
        if (hHandle.length) {
            try{
                var chartData = [], colors = [], labels = [];
                for(var i=0; i<tuple.length; i++){
                    labels.push(tuple[i][0]);
                    chartData.push(tuple[i][1]);
                    colors.push(tuple[i][2]);
                }
                new Chart(
                    hHandle[0].getContext("2d"),
                    {
                        type: "horizontalBar", data: {labels: labels, datasets: [{label: title, data: chartData, backgroundColor: colors, borderWidth: 0}]},
                        options: {
                            responsive: true, maintainAspectRatio: width_threshold === false ? false : $(window).width() >= width_threshold,
                            scales: {
                                yAxes: [{
                                    barPercentage: 0.2, ticks: {beginAtZero: false},
                                    scaleLabel: {display: true, labelString:title}}]
                            }
                        }
                    }
                );
            }catch (e) {}
        }
    },

    mountDefaultLine: function ( at,labels,tuple, width_threshold ) {
        var hCanvasHandle = $(at);
        width_threshold = width_threshold === undefined ? 480 : width_threshold;
        if (hCanvasHandle.length) {
            var dataSets = [];
            if(tuple){
                for(var i=0;i<tuple.length;i++){
                    dataSets.push({
                        label: tuple[i][0],
                        data: tuple[i][1],
                        fill: false,
                        borderColor: tuple[i][2],
                        cubicInterpolationMode: "monotone",
                        pointRadius: 0
                    })
                }
            }
            new Chart(
                hCanvasHandle[0].getContext("2d"),
                {type: "line", data: {labels: labels, datasets: dataSets},
                    options: {scales: {yAxes: [{scaleLabel: {display: true, labelString: "Hits"}}]}, maintainAspectRatio : width_threshold === false ? false : $(window).width() >= width_threshold}
                }
            );
        }
    },
};

Predator.page = {
    surveyQueryStrAndBind : function ( kvMapOrDesignatedArray ) {
        var hGET     = pPine.Objects.clone( $_GET );
        var ghConfig = Predator.config;

        var bIsFn    = pPine.PrototypeTraits.isFunction( kvMapOrDesignatedArray );
        if( !kvMapOrDesignatedArray || bIsFn ) {
            delete hGET[ ghConfig.WizardParameter ];
            delete hGET[ ghConfig.ModelParameter ];
            delete hGET[ ghConfig.ControlParameter ];
            if( bIsFn ) {
                kvMapOrDesignatedArray( hGET );
            }
            Predator.page.surveyQueryStrAndBind( Pinecone.Objects.keys( hGET ) );
        }
        else if( pPine.PrototypeTraits.isObject( kvMapOrDesignatedArray ) ) {
            for ( var key in kvMapOrDesignatedArray ) {
                if( kvMapOrDesignatedArray.hasOwnProperty( key ) ){
                    var val = kvMapOrDesignatedArray[key];
                    if( pPTraits.isArray( val ) ){
                        for( var j in val ){
                            if( val.hasOwnProperty( j ) ){
                                $_PINE( val[j] ).val ( hGET[key] );
                            }
                        }
                    }
                    else {
                        $_PINE( val ).val ( hGET[key] );
                    }
                }
            }
        }
        else if ( pPine.PrototypeTraits.isArray( kvMapOrDesignatedArray ) ) {
            for ( var i = 0; i < kvMapOrDesignatedArray.length; i++ ) {
                var row = kvMapOrDesignatedArray[i];
                if( hGET.hasOwnProperty( row ) ){
                    $_PINE( "#" + row ).val ( hGET[row] );
                }
            }
        }
        else {
            if( pPine.isDebugMode() ){
                console.trace( "IllegalArgument: Notice, failed to execute this." );
            }
        }
    },

    interact: {
        globalResize: function() {
            var width = document.body.offsetWidth;
            if( width <= 767 ){
                $(".predator-left-super-menu").slideToggle("slow");
            }
        },

        init: function () {
            var hDropMenu = $('.dropdown-menu');
            hDropMenu.unbind( "click" );
            hDropMenu.click( function(e) {
                e.stopPropagation();
            } );


            var hBoxDown = $(".box-down");
            hBoxDown.unbind( "click" );
            hBoxDown.click( function (e) {
                var handle = $(e.target).parents(".crisp-my-box");
                if( handle[0] ){
                    var hBoxContent = $(handle[0]).children(".box-content");
                    if( hBoxContent.css("display") === "block" ){
                        hBoxContent.hide();
                    }
                    else{
                        hBoxContent.show();
                    }
                }
            } );


            var hAllBox = $(".all-box-down");
            hAllBox.unbind( "click" );
            hAllBox.click( function (e) {
                try{
                    var hI = hAllBox[0].getElementsByTagName("i")[0];
                    if( hI.classList.contains( "fa-angle-down" ) ){
                        hI.outerHTML = "<i class='fa fa-angle-up'></i>"
                    }
                    else {
                        hI.outerHTML = "<i class='fa fa-angle-down'></i>"
                    }

                    $( ".box-content" ).each( function (e) {
                        var hBox = $(this);
                        if( hBox.css("display") === "block" ){
                            hBox.hide();
                        }
                        else {
                            hBox.show();
                        }
                    });
                }
                catch (e) {
                    console.warn( e );
                }
            } );

            var hSuperMenuClip = $(".predator-left-super-menu-clip");
            hSuperMenuClip.unbind( "click" );
            hSuperMenuClip.click( function (e) {
                try {
                    $(".predator-left-super-menu").slideToggle("slow");
                }
                catch (e) {
                    console.warn( e );
                }
            } );

            Predator.page.interact.globalResize();
        },
        refresh: function () {
            Predator.page.interact.init();
        }
    },

    textarea: {
        resize: {
            proto: function ( that, nMinHeight ) {
                "use strict";
                if( nMinHeight === undefined ){
                    nMinHeight =  parseInt( that.style.height, 10 );
                }
                this.mnMinHeight = nMinHeight;

                this.mfnSetAuto = function ( that ) {
                    var nOuterHeight  = parseInt( window.getComputedStyle(that).height, 10 );
                    var nChangeStep   = nOuterHeight - that.clientHeight;
                    that.style.height = 0;
                    that.style.height = Math.max( this.mnMinHeight, that.scrollHeight + nChangeStep ) + 'px';
                };
            },
            auto: function ( that, nMinHeight ) {
                "use strict";
                this.$textarea = this.$textarea ? this.$textarea : {};
                var self = this.$textarea;
                self.mInstance = self.mInstance ? self.mInstance : new Predator.page.textarea.resize.proto( that, nMinHeight );
                return self.mInstance.mfnSetAuto( that );
            }
        }
    },
};

Predator.paginate = {
    config: {
        "QueryPageID"    : "pageid",
        "QueryPageLimit" : "pageLimit",
        "VarPageDataSum" : "nPageDataSum",
        "VarPageLimit"   : "nPageLimit",
        "PaginatePageMax": 5, // Required odd
        "FirstPageTitle" : "首页",
        "LastPageTitle"  : "尾页",
        "InfoControlFmt" : "第{0}-{1}页，共{2}条"
    },
    getQueryPageID:      function () {
        return this.config.QueryPageID;
    },
    getQueryPageLimit:   function () {
        return this.config.QueryPageLimit;
    },
    getVarPageLimit:     function () {
        return this.config.VarPageLimit;
    },
    getVarPageDataSum:   function () {
        return this.config.VarPageDataSum;
    },

    currentPId : function( nDefault ) {
        var t = $_GET[ Predator.paginate.config.QueryPageID ];
        if( !pPTraits.isNumber(nDefault) ){
            return t;
        }
        return t ? t : nDefault;
    },

    spawn: function ( nCurrentPageID, nPageDataSum, nLimit, hConfig ) {
        this.defun = function ( nCurrentPageID, nPageDataSum, nLimit, hConfig ) {
            hConfig      = pPine.PrototypeTraits.isObject( hConfig ) ? hConfig : {};
            var fnIs     = function ( b, d ) { return !!b? b : d; };
            var ghConfig = Predator.paginate.config;

            this.mbUsingInfoControl = fnIs( hConfig["UsingInfoControl"], true );
            this.mszInfoControlFmt  = fnIs( hConfig.InfoControlFmt,  ghConfig.InfoControlFmt ) ;
            this.mszFirstPageTitle  = fnIs( hConfig.FirstPageTitle,  ghConfig.FirstPageTitle ) ;
            this.mszLastPageTitle   = fnIs( hConfig.LastPageTitle ,  ghConfig.LastPageTitle ) ;
            this.mnPaginatePageMax  = fnIs( hConfig.PaginatePageMax, ghConfig.PaginatePageMax ) ;
            this.mszQueryPageID     = fnIs( hConfig.QueryPageID   ,  ghConfig.QueryPageID ) ;
            this.mszMainHref        = window.location.href.toString() ;
            if( this.mszMainHref.indexOf('?') > 0 ) {
                var t = {};
                t[ this.mszQueryPageID ] = null;
                this.mszMainHref = pPine.Navigate.urlAutoMerge ( t, $_GET );
            }

            this.mfnSpawnExtremity = function ( href, szTitle ) {
                var szStyle = "";
                if( !href ) {
                    href    = "javascript:void(0);";
                    szStyle = "cursor:not-allowed;";
                }
                return '<li><a href="' + href + '" style="' + szStyle + '">' + szTitle + '</a></li>';
            };

            this.mfnSpawnPHref     = function ( nPId ) {
                return this.mszMainHref + "&" + this.mszQueryPageID + "=" + nPId;
            };

            this.spawn             = function () {
                var nPagesCount = Math.ceil(nPageDataSum / nLimit ) ;
                nCurrentPageID  = fnIs( parseInt( nCurrentPageID ),1);

                var nStartPage = 1, nEndPage = this.mnPaginatePageMax, nEvenPMax = this.mnPaginatePageMax - 1;
                if( nPagesCount <= this.mnPaginatePageMax ){
                    nEndPage = nPagesCount;
                }
                else {
                    nStartPage = nCurrentPageID - nEvenPMax / 2;
                    nEndPage   = nCurrentPageID + nEvenPMax / 2;

                    if( nStartPage <= 0 ){
                        nStartPage = 1;
                        nEndPage = this.mnPaginatePageMax;
                    }
                    if( nEndPage > nPagesCount ){
                        nEndPage = nPagesCount;
                        nStartPage = nEndPage - nEvenPMax;
                    }
                }

                var szPageFirstControl = '', szPageLastControl = '', szPageFrontControl = '',szPageNextControl = '',szIndexControl = '';

                var szPageInfoControl = "";
                if( this.mbUsingInfoControl ) {
                    szPageInfoControl = '<li><a>' + pPine.String.format(
                        this.mszInfoControlFmt,
                        (nPageDataSum > 0 ? nCurrentPageID : 0),  nPagesCount,  nPageDataSum
                    ) + '</a></li>';
                }
                if( nCurrentPageID <= 1 ){
                    szPageFirstControl = this.mfnSpawnExtremity( null, this.mszFirstPageTitle );
                    szPageFrontControl = this.mfnSpawnExtremity( null, "«" );
                    if(nPagesCount <= 1){
                        szPageLastControl = this.mfnSpawnExtremity( null, this.mszLastPageTitle );
                        szPageNextControl = this.mfnSpawnExtremity( null, "»" );
                    }
                    else {
                        szPageLastControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( nPagesCount ) , this.mszLastPageTitle );
                        szPageNextControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( 2 ), "»" );
                    }
                }
                else if ( nCurrentPageID > 1 && nCurrentPageID < nPagesCount ){
                    szPageFirstControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( 1 ), this.mszFirstPageTitle );
                    szPageFrontControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( nCurrentPageID - 1 ), "«" );
                    szPageLastControl  = this.mfnSpawnExtremity( this.mfnSpawnPHref( nPagesCount ), this.mszLastPageTitle );
                    szPageNextControl  = this.mfnSpawnExtremity( this.mfnSpawnPHref( nCurrentPageID + 1 ), "»" );
                }
                else if ( nCurrentPageID === nPagesCount ){
                    if( nPagesCount === 1 ){
                        szPageFirstControl = this.mfnSpawnExtremity( null, this.mszFirstPageTitle );
                        szPageFrontControl = this.mfnSpawnExtremity( null, "«" );
                    } else {
                        szPageFirstControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( 1 ), this.mszFirstPageTitle );
                        szPageFrontControl = this.mfnSpawnExtremity( this.mfnSpawnPHref( nPagesCount - 1 ), "«" );
                    }
                    szPageLastControl = this.mfnSpawnExtremity( null, this.mszLastPageTitle );
                    szPageNextControl = this.mfnSpawnExtremity( null, "»" );
                }
                for( var i = nStartPage; i <= nEndPage; i++ ){
                    if( i === nCurrentPageID ){
                        szIndexControl += '<li class="paginate_button active"><a href="javascript:void(0);" style="cursor:not-allowed;">' + i + '</a></li>';
                    } else {
                        szIndexControl += '<li><a href="' + this.mfnSpawnPHref( i ) + '">' + i + '</a></li>';
                    }
                }

                return szPageInfoControl + szPageFirstControl + szPageFrontControl + szIndexControl + szPageNextControl + szPageLastControl;
            };

        };
        return ( new this.defun( nCurrentPageID, nPageDataSum, nLimit, hConfig ) ).spawn();
    },

    mount: function ( szUId, nCurrentPageID, nPageDataSum, nLimit, hConfig ) {
        if( szUId ) {
            $_PINE(szUId).append( Predator.paginate.spawn( nCurrentPageID, nPageDataSum, nLimit, hConfig ) );
        }
    },

    smartSpawn: function ( hPageData, hConfig, nCurrentPageID ) {
        var ghConfig     = Predator.paginate.config;
        nCurrentPageID   = !!nCurrentPageID ? nCurrentPageID : Predator.paginate.currentPId();
        var nPageDataSum = hPageData[ ghConfig.VarPageDataSum ];
        var nLimit       = hPageData[ ghConfig.VarPageLimit ];

        return Predator.paginate.spawn( nCurrentPageID, nPageDataSum, nLimit, hConfig );
    },

    smartMount: function ( szUId, hPageData, hConfig, nCurrentPageID ) {
        if( szUId ) {
            $_PINE(szUId).append( Predator.paginate.smartSpawn( hPageData, hConfig, nCurrentPageID ) );
        }
    },

    rowEnumCounter: function ( nRowEachPageOrPD, nCurrentPId ) {
        this.defun = function () {
            this.mnRowEachPage = nRowEachPageOrPD ;
            if( pPTraits.isObject( nRowEachPageOrPD ) ){
                this.mnRowEachPage = nRowEachPageOrPD[ Predator.paginate.config.VarPageLimit ];
            }
            else if( nRowEachPageOrPD === undefined ){
                this.mnRowEachPage = window.pageData[ Predator.paginate.config.VarPageLimit ];
            }
            this.mnCurrentPId  = nCurrentPId  ;
            if( this.mnCurrentPId === undefined ){
                this.mnCurrentPId = Predator.paginate.currentPId( 1 );
            }

            this.now = function ( i ) {
                return i + this.mnRowEachPage * ( this.mnCurrentPId - 1 );
            }
        };

        return new this.defun();
    }
};

Predator.searcher = {
    querySearch : function ( dbNameUidMap, bPageIDClear ) {
        "use strict";

        var proto = {};
        proto.defun = function () {
            this.mhURLs    = {};
            this.proto     = this;

            for ( var db in dbNameUidMap ) {
                if( dbNameUidMap.hasOwnProperty(db) ) {
                    var uid = dbNameUidMap[ db ];

                    var szCVal = $_PINE( uid ).val();
                    this.mhURLs[ db ] = szCVal ? szCVal : null;
                }
            }

            if( bPageIDClear ){
                this.mhURLs[ Predator.paginate.getQueryPageID() ] = null;
            }

            window.location = Pinecone.Navigate.urlAutoMerge( this.mhURLs, $_GET );
        };

        return new proto.defun();
    },

    bindSingleSearch : function ( szDBName, uid, bPageIDClear ) {
        var map = {}; map [ szDBName ] = uid;

        if( event ) {
            if( event.keyCode === 13 || event.type === "change" ) {
                return Predator.searcher.querySearch( map, bPageIDClear );
            }

            return false;
        }

        return Predator.searcher.querySearch( map, bPageIDClear );
    },

    shardedQuerySearch:  function ( szDBName, uid, shardedDBNames, bPageIDClear ) {
        "use strict";

        var proto = {};
        proto.defun = function () {
            this.mhURLs    = {};
            this.proto     = this;

            var szCVal = $_PINE( uid ).val();
            szCVal = szCVal ? szCVal : null;
            this.mhURLs[ szDBName ] = szCVal;

            for ( var i = 0;i < shardedDBNames.length; i++ ) {
                this.mhURLs[ shardedDBNames[i] ] = szCVal;
            }

            if( bPageIDClear ){
                this.mhURLs[ Predator.paginate.getQueryPageID() ] = null;
            }

            window.location = Pinecone.Navigate.urlAutoMerge( this.mhURLs, $_GET );
        };

        return new proto.defun();
    },

    bindSingleShardedSearch : function ( szDBName, uid, shardedDBNames, bPageIDClear ) {
        if( event ) {
            if( event.keyCode === 13 || event.type === "change" ) {
                return Predator.searcher.shardedQuerySearch( szDBName, uid, shardedDBNames, bPageIDClear );
            }

            return false;
        }

        return Predator.searcher.querySearch( szDBName, uid, shardedDBNames, bPageIDClear );
    },
};

Predator.logicControl = {
    bindFunction   : function ( uid, fn ) {
        if( event ) {
            if( event.keyCode === 13 ) {
                return fn( uid );
            }
            return false;
        }
        return fn( uid );
    },
    bindRedirector   : function ( uid, szUrl ) {
        return Predator.logicControl.bindFunction( uid, function ( uid ) {
            window.location = szUrl + $_PINE( uid ).val();
        } );
    },
};

Predator.jsonWordDatumCoding = {
    bandWordDecode : function( jBands, delimiter ) {
        var res = pPTraits.isString( delimiter ) ? "" : [];

        if( jBands ){
            jBands = jBands instanceof Array ? jBands : JSON.parse( jBands );
            for( var i = 0; i<jBands.length; i++ ){
                var row = jBands[i];
                if( pPTraits.isString( res ) ){
                    res += row;
                }
                else {
                    res.push( row );
                }
                if( i !== jBands.length-1 && pPTraits.isString( res )){
                    res += delimiter;
                }
            }
        }
        return res;
    },

    humanifyJMeans: function ( jMeans, szD ) {
        var ss = "";
        szD = szD ? szD : ";";
        if( pPTraits.isArray( jMeans ) ) {
            var l = jMeans.length;
            for( var i = 0; i < l; i++ ){
                ss += jMeans[i] + ( i === l - 1? "" : szD );
            }
        }
        else if( pPTraits.isString( jMeans ) ){
            try{
                return Predator.jsonWordDatumCoding.humanifyJMeans( JSON.parse( jMeans ) );
            }
            catch (e) {
                console.error( e, jMeans );
                return "[object Object]";
            }
        }
        return ss;
    }
};

Predator.tpl = {
    renderById: function ( szId, data ) {
        var h = $_PINE("#" + szId ).parent();
        if( h ){
            h.html( template( szId, data ) );
        }
        return h;
    },
    notice: {
        simpleNoData: "<div class=\"table-responsive\">" +
            "<table class=\"table table-striped table-bordered table-hover crisp-picture-table\"><tbody><tr><td>暂无数据</td></tr></tbody></table>" +
            "</div>"
    }
};

Predator.property = {
    glossary:{
        authority:{
            "public"  : "公开",
            "private" : "私有"
        }
    }
};

Predator.vocabulary = {
    band:{
        getAllLevels: function() {
            var jLevel = Predator.pageData[ "sysAllBandLevels" ];
            if( !$isTrue( jLevel ) ){
                $.ajax({
                    url: "?do=SystemCoven",
                    async: false,
                    type: "GET",
                    data: {'action':'getAllBandLevels'},
                    success: function (result) {
                        jLevel = JSON.parse(result);
                        Predator.pageData[ "sysAllBandLevels" ] = jLevel;
                    }
                });
            }
            return jLevel;
        },

        assembleSelector: function( jLevels ){
            if( !$isTrue( jLevels ) ){
                jLevels = Predator.vocabulary.band.getAllLevels();
            }
            var szBandZone = "";
            for ( var i = 0; i < jLevels.length; i++ ) {
                var szGName = jLevels[i]["g_name"];
                if( szGName !== jLevels[i]["g_nickname"] ){
                    szBandZone += '<option value="' + szGName + '">' + szGName + "(" + jLevels[i]["g_nickname"] + ")" + '</option>';
                }
                else {
                    szBandZone += '<option value="' + szGName + '">' + szGName + '</option>';
                }
            }
            return szBandZone;
        },
        getRawLevels: function(jLevel ){
            try{
                if( pPTraits.isString( jLevel ) ){
                    return JSON.parse( jLevel );
                }
                else if( pPTraits.isArray( jLevel ) ){
                    return jLevel;
                }
            }
            catch (e) {
                return [];
            }
            return [];
        },

        fetchLevels: function( jLevel ){
            return Predator.jsonWordDatumCoding.bandWordDecode(
                Predator.vocabulary.band.getRawLevels( jLevel )
            );
        },
    },






    phonetic: {
        getAudio: function (word, type) {
            var szAudioUrl = 'https://dict.youdao.com/dictvoice?audio=' + word + '&type=' + type;
            return new Audio(szAudioUrl);
        },
        audioPlay: function (word, type) {
            var audio = Predator.vocabulary.phonetic.getAudio( word, type );
            return audio.play();
        }
    },

    frequencyInfo: {
        gsCnMap: {
            "f_spoken"    : "交流",
            "f_fiction"   : "文学",
            "f_magazine"  : "杂志",
            "f_newspaper" : "新闻",
            "f_academic"  : "学术",
        },

        gsOtherInfoKey:{
            "w_pos": true, "f_total": true, "f_band_level": true, "coca_rank":true, "band_rank": true
        },

        nameCnify: function ( sz ) {
            var map = Predator.vocabulary.frequencyInfo.gsCnMap;
            if( map.hasOwnProperty( sz ) ){
                return map[ sz ];
            }
            return sz;
        },

        tryNameCnify: function ( sz ) {
            var map = Predator.vocabulary.frequencyInfo.gsCnMap;
            if( map.hasOwnProperty( sz ) ){
                return map[ sz ];
            }
            return undefined;
        },

        bandNameCnify: function ( sz ) {
            if( sz === 'NEMT' ){
                return "高考";
            }
            else if( sz === 'PEE' ){
                return "考研";
            }
            return sz;
        }
    },

    inflections: {
        gsCnMap:{
            "Self"        : "自身",
            "Plurality"   : "复数",
            "Third"       : "三人称单数",
            "Past"        : "过去式",
            "Done"        : "过去分词",
            "Present"     : "现在分词",
            "Comparative" : "比较级",
            "Superlative" : "最高级",
            "RawAdj"      : "形容词",
            "RawAdv"      : "副词",
            "RawNoun"     : "名词",
            "RawVerb"     : "动词",
        },
    },

    slang : {
        gsCnMap:{
            "1"   : "Urban Dictionary",
            "2"   : "Slang Git [slangit.com]",
            "3"   : "Predator",
        },
    },

    frag: {
        gsCnMap:{
            "prefix"   : "前缀",
            "suffix"   : "后缀",
            "root"     : "词根",
            "mixed"    : "混合"
        },
    },

    phrase: {
        gsTypeCnMap:{
            "general"        : "常用短语",
            "phrasalVerbs"   : "动词短语",
            "idiom"          : "习惯用语",
            "special"        : "特殊短语"
        },
    }

};

Predator.elements = {
    pamphlet : {
        glossary : {},
        sentence : {}
    },

    sentence : {
        translate: function ( szSentence, fn ) {
            $.ajax({
                url: "https://fanyi.youdao.com/openapi.do?type=data&doctype=jsonp&version=1.1&keyfrom=neteaseopen&key=1532272597&callback=?",
                async: false,
                type: "GET",
                dataType: "json",
                data: {'q': szSentence},
                success: fn
            });
        }
    }
};

Predator.wizard = {
    reserveFns: {
        'init' : true,
        'final': true
    },
    defaultGenieData: function(){
        return {
            "$_GET" : $_GET
        };
    },
    enchantGenieMagicFns: function( that ){
        if( that ){
            that.render = function( id, h ){
                return template( id, h );
            };
            that.renderById = function( id ){
                return Predator.tpl.renderById( id, arguments[1]? arguments[1] : that.genieData );
            };
            that.assertRender = function ( b, id, falseDo, trueDo ) {
                if( b ){
                    if( pPTraits.isFunction(trueDo) ) {
                        trueDo( that );
                        that.renderById( id );
                    }
                    else {
                        that.renderById( id, trueDo );
                    }
                }
                else {
                    if( pPTraits.isFunction( falseDo ) ) {
                        falseDo( that );
                    }
                    else if( pPTraits.isString( falseDo ) ){
                        $_PINE("#" + id ).parent().html( falseDo );
                    }
                }
            };
        }
    },
    smartGenieInstance: function ( that, fns ) {
        if( that && that !== window ){
            if( that.genieData === undefined ){
                that.genieData = Predator.wizard.defaultGenieData();
            }
            that.genieData.fns = fns;
            if( that.genieData.fns ){
                Predator.wizard.enchantGenieMagicFns( that );

                try{
                    if( that.genieData.fns.init ){
                        if( that.genieData.fns.init( that ) === false ){
                            return;
                        }
                    }
                }
                catch (e) {
                    console.warn( e );
                }

                Predator.wizard.afterGenieReadied( that );

                try{
                    if( that.genieData.fns.final ){
                        that.genieData.fns.final( that );
                    }
                }
                catch (e) {
                    console.warn( e );
                }
            }
        }
        else {
            if( pPine.isDebugMode() ){
                console.warn( "Smart genie must has its own class proto." );
            }
        }
    },
    afterGenieReadied: function ( that ) {
        if( that ){
            if( that.genieData ){
                var fns = that.genieData[ "fns" ];
                if( pPTraits.isObject( fns ) ){
                    for( var key in fns ){
                        if( fns.hasOwnProperty( key ) && pPTraits.isFunction( fns[key] ) && Predator.wizard.reserveFns[key] === undefined ){
                            try {
                                fns[key] ( that );
                            }
                            catch (e) {
                                console.warn( e );
                            }
                        }
                    }
                }
            }
        }
    },

    conjurer: {
        superBtn: {
            namespace: "IndexLabel",
            summoned : function ( who, ns ) {
                var szNs = ns ? ns : Predator.wizard.conjurer.superBtn.namespace;
                $_PINE( "#" + who + szNs ).css({"text-decoration":"underline","font-weight":"bold"});
            }
        },
        tabBtn: {
            namespace: "IndexLabel",
            summoned : function ( who, ns ) {
                var szNs = ns ? ns : Predator.wizard.conjurer.tabBtn.namespace;
                $_PINE( "#" + who + szNs ).addClass( "active" );
            }
        }
    },

    address: {
        syndicate:{
            "WordExplicater": function ( w ){ var h = Predator.spawnWizardActionSpell( "WordExplicater" ) + "&query=" + w; return h; },
            "GeniusExplorer": function ( m ){ var h = Predator.spawnWizardActionSpell( "GeniusExplorer", m ) ; return h; },
        }
    },
};

Predator.equipment = {
    ui: {}
};

Predator.auxiliary = {
    substr: function ( str, f, to, more ) {
        more = more ? more : "...";
        var sub = str.substr( f, to );
        if( str.length > sub.length ){
            return sub + more;
        }
        return sub;
    },

    jsDownloader: function ( data, szFileName, szType, szCharset ) {
        "use strict";

        var proto = {
            defun : function () {
                this.proto           = this;
                this.mData           = data;
                this.mszFileName     = szFileName;
                this.mszType         = szType ? szType : "txt";
                this.mszCharset      = szCharset ? szCharset : "utf-8";

                this.fnIsMsieVersion = function() {
                    var ua   = window.navigator.userAgent;
                    var msie = ua.indexOf("MSIE ");
                    return msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./);
                };

                this.spawn = function () {
                    if ( this.fnIsMsieVersion() ) {
                        var hIEWin = window.open();
                        hIEWin.document.write('sep=,\r\n' + this.mData );
                        hIEWin.document.close();
                        hIEWin.document.execCommand('SaveAs', true, this.mszFileName + "." + this.mszType );
                        hIEWin.close();
                    }
                    else {
                        var uri  = 'data:application/' + this.mszType + ';charset=' + this.mszCharset + ',' + this.mData;
                        var link = document.createElement("a");
                        link.href     = uri;
                        link.style    = "disable:none";
                        link.download = this.mszFileName + "." + this.mszType;
                        document.body.appendChild( link );
                        link.click();
                        document.body.removeChild( link );
                    }
                };

                this.spawn();
            }
        };

        return new proto.defun();
    }
};

Predator.init = function(){
    Predator.page.interact.refresh();
};

Predator.math = {
    polynomialEval: function ( para, x ) {
        var nPolyPara = para.length;

        var y = 0.0;
        for ( var i = 0; i < nPolyPara; i++ ) {
            y += para[i][0] * Math.pow( x, i );
        }

        return y;
    }
};


var $_Predator = function ( hPageData, renderer ) {
    "use strict";
    var proto = {
        reserveFns: {
            'init'      : true,
            'genies'    : true,
            'final'     : true
        }
    };
    proto.afterPageDataLoaded = function () {
        window.pageData = hPageData;
        Predator.init();
    };
    proto.afterPageDataLoaded();

    proto.defun = function () {
        this.mhPageData   = hPageData;
        this.my           = Predator;
        this.my.pageData  = this.mhPageData;
        this.config       = this.my.config;
        this.proto        = this;
        this.currentFun   = "";

        this.invokePageFns = function( that ){
            var pd = that.mhPageData;
            if( pd ){
                var fns = pd["$_Predator"][ "fns" ];
                if( pPTraits.isObject( fns ) ){
                    for( var key in fns ){
                        if( fns.hasOwnProperty( key ) && pPTraits.isFunction( fns[key] ) && proto.reserveFns[key] === undefined ){
                            try {
                                that.currentFun = key;
                                fns[key] ( that );
                            }
                            catch (e) {
                                console.warn( e );
                            }
                        }
                    }
                }
            }
        };

        this.pageInstance = function( that ){
            that.mhPageData["$_Predator"] = {
                "fns" : renderer
            };
            var hFns = that.mhPageData["$_Predator"][ "fns" ];

            try{
                if( hFns.init ){
                    if( hFns.init( that ) === false ){
                        return;
                    }
                }
            } catch (e) {
                console.warn( e );
            }

            try{
                if( hFns.genies ){
                    hFns.genies( that );
                }
            } catch (e) {
                console.warn( e );
            }

            that.invokePageFns( that );

            try{
                if( hFns.final ){
                    hFns.final( that );
                }
            } catch (e) {
                console.warn( e );
            }
        };

        if( pPTraits.isFunction( renderer ) ){
            renderer( this );
        }
        else if ( pPTraits.isObject( renderer ) ){
            this.pageInstance( this );
        }

        return this.proto;
    };

    return new proto.defun();
};

function setTagMultipleStyle(obj,css) {
    for(var attr in css){
        obj.style[attr] = css[attr];
    }
}

var PineconeInputValueCheck = {
    valueChecked:false,

    checkResult : function () {
        return this.valueChecked ;
    },

    checkInputValue : function (obj){
        if(obj){
            if(obj.value!==""){
                setTagMultipleStyle(obj,{"border-color":"rgba(75,191,15,0.87)", "box-shadow":"0 0 5px rgb(75,191,15"});
                this.valueChecked = true;
            }else {
                setTagMultipleStyle(obj,{"border-color":"rgba(255, 17, 17, 0.87)", "box-shadow":"0 0 5px #ef100a"});
                this.valueChecked =  false;
            }
        }
    }
};




