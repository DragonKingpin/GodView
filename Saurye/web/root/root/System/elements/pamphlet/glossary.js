var $EP_Glossary = Predator.elements.pamphlet.glossary = {
    multipleWordsList2Map: function ( hList ) {
        var sMap = {};
        for ( var i = 0; i < hList.length; i++ ) {
            var row = hList[i];
            var szWord = row["en_word"];
            var szCnD  = row["cn_means"];
            var nFreq  = row["w_freq_base"] ? row["w_freq_base"] : -1;
            sMap[ szWord ] = pPine.Objects.affirmObject( sMap[ szWord ] );
            if( sMap[ szWord ][ "freq" ] === undefined ){
                sMap[ szWord ][ "freq" ] = nFreq;
            }
            else {
                sMap[ szWord ][ "freq" ] = Math.min( sMap[ szWord ][ "freq" ], nFreq );
            }
            sMap[ szWord ][ "band"    ] = Predator.jsonWordDatumCoding.bandWordDecode( row["w_level"], ',' );
            pPine.Objects.merge( sMap[ szWord ], row, [ "id", "d_add_date","d_sort_id","g_note","w_level" ] );

            var szCnKey = row[ "m_property" ] + ". " + szCnD;
            sMap[ szWord ][ "defs" ]            = pPine.Objects.affirmObject( sMap[ szWord ][ "defs" ]  );
            sMap[ szWord ][ "defs" ][ szCnKey ] = pPine.Objects.affirmObject( sMap[ szWord ][ "defs" ][ szCnKey ] );
        }

        for( var k in sMap ){
            if( sMap.hasOwnProperty( k ) ){
                var each = sMap[ k ][ "defs" ];
                var szCnDef = "";
                var nSize   = sizeof( each );
                var i = 0;
                for( var szCn in each ){
                    szCnDef += szCn;
                    if( ++i !== nSize ){
                        szCnDef += ';';
                    }
                }
                sMap[ k ][ "defs" ] = szCnDef;
            }
        }

        return sMap;
    },

    registerWordListAction: function ( pageData, self ) {

        pageData.fnPlayWord = function ( s ){
            return Predator.vocabulary.phonetic.audioPlay( s, 1 );
        };

        pageData.fnReadPageWords = function(){
            if( self.genieData.threadFnReadPageWords ){
                window.clearInterval( self.genieData.threadFnReadPageWords );
            }
            var adWords = [], iW = 0;
            for( var word in self.genieData[ "wordList" ] ){
                if( self.genieData[ "wordList" ].hasOwnProperty( word ) ){
                    adWords.push( Predator.vocabulary.phonetic.getAudio( word, 1 ) );
                }
            }
            var nSpeed = parseInt( $_PINE("#seReadSpeed").val() );
            self.genieData.threadFnReadPageWords = setInterval(function(){
                if( iW < adWords.length ){
                    var audio = adWords[iW++] ;
                    audio.play();
                }
                else {
                    window.clearInterval( self.genieData.threadFnReadPageWords );
                }
            }, nSpeed );
        };
        pageData.fnSortWords         = function () {
            Predator.searcher.bindSingleSearch( "sort_type", '#sort_type', true );
        };

        pageData.fnSiftByDate        = function () {
            Predator.searcher.querySearch( {
                "startTime" : "#startTime", "endTime" : "#endTime"
            }, true );
        };

        pageData.fnClearDateSearch   = function () {
            Pinecone.Navigate.redirect(
                Pinecone.Navigate.urlAutoMerge( {
                    "startTime" : null, "endTime" : null, "daily_type": null
                }, $_GET )
            );
        };

        pageData.fnSiftByDaily       = function () {
            Predator.searcher.bindSingleShardedSearch(
                "daily_type", '#daily_type', [ 'startTime', 'endTime' ],  true
            );
        };

        pageData.fnAdvanceSwitch     = function () {
            var hAdvBox = $_PINE( ".p-p-searcher-advance" );
            if( hAdvBox.css("display") === "none" ) {
                hAdvBox.show();
            }
            else {
                hAdvBox.hide();
            }
        };

        pageData.fnHideAllDef        = function ( that ) {
            var hGWDef = $(".p-g-w-def");
            var hMask  = $(".p-g-w-def-mask");
            if( that.innerText === "显示释义" ){
                that.innerText = "隐藏释义";
                hGWDef.show(); hMask.hide();
            }else {
                that.innerText = "显示释义";
                hGWDef.hide(); hMask.show();
            }
        };
        pageData.fnHideAllWordDetail = function ( that ) {
            var h = $(".p-w-details");
            if( that.innerText === "展开详细" ){
                that.innerText = "收起详细";
                h.show();
            }else {
                that.innerText = "展开详细";
                h.hide();
            }
        };
        pageData.fnShowWordDetail    = function( that ){
            var h = $( "#" + that );
            if( h.css("display") === "block" ){
                h.hide();
            }else {
                h.show();
            }
        };
        pageData.fnHideCurrentDef    = function ( that ) {
            var p = that.parentNode;
            $( p.nextElementSibling ).show();
            $( p ).hide();
        };
        pageData.fnShowCurrentDef    = function ( that ) {
            $( that.previousElementSibling ).show();
            $( that ).hide();
        };
        pageData.fnSaveSortedList    = function () {
            if( confirm("您确实要保存当前表格吗？") ){
                var data = {};
                data [ Predator.config.ControlParameter ] = "saveSortedWordList";
                Pinecone.Navigate.redirect(
                    Pinecone.Navigate.urlAutoMerge( data, $_GET )
                );
            }
        };

        pageData.fnDownloadAsTable   = function () {
            try {
                var szFileName = "glossary";
                if( pageData.GlossaryProfile ) {
                    szFileName = pageData.GlossaryProfile[0][ 'ph_name' ];
                }

                var keys = [ 'defs', 'band', 'freq', 'd_add_date', 'g_note' ];
                var sMap = pageData.glossaryDownloadDataMap;
                if( $isTrue( sMap ) ) {
                    var fileDS = "";
                    for ( var word in sMap ) {
                        if( sMap.hasOwnProperty( word ) ) {
                            var infos      = sMap[ word ];
                            var lineStream = "";

                            lineStream += word + ',';
                            for ( var i in keys ) {
                                var k = keys[i];
                                lineStream += (
                                    $isTrue( infos[k] )  ? '"' + infos[k] + '"' : ""
                                ) + ',';
                            }

                            lineStream.slice( 0, lineStream.length - 1 );
                            fileDS += lineStream + '\r\n';
                        }
                    }

                    Predator.auxiliary.jsDownloader( fileDS, szFileName, "csv" );
                }
                else {
                    alert( "Download compromised, no data given !" );
                }
            }
            catch ( e ) {
                alert( "Download compromised !" );
                console.error( e );
            }
        }
    },

    renderWordSearcher: function (  ) {
        $EP_Glossary.MagicSort.mountSelector( "#sort_type" );
        pPine.renderer.quickRender( {
            "#startTime" : pPine.DateTime.format( "yyyy-MM-dd" ),
            "#endTime"   : pPine.DateTime.format( "yyyy-MM-dd" )
        } );

        var szQStartTime = $_GET[ "startTime"  ], szQEndTime = $_GET[ "endTime" ],
            szQDaily     = $_GET[ "daily_type" ];

        if( szQStartTime || szQEndTime || szQDaily ) {
            $_PINE( ".p-p-searcher-advance" ).show();
        }
    },

    MagicSort : {
        "available" : [
            { "ms_key": "0", "ms_name" : "随机排序" },
            { "ms_key": "1", "ms_name" : "字典排序" },
            { "ms_key": "2", "ms_name" : "词长排序" },
            { "ms_key": "3", "ms_name" : "词频排序" },
            { "ms_key": "4", "ms_name" : "添加顺序" },
            { "ms_key": "5", "ms_name" : "最近添加" },
            { "ms_key": "6", "ms_name" : "最优(生活实用)" },
            { "ms_key": "7", "ms_name" : "最优(阅读实用)" },
            { "ms_key": "8", "ms_name" : "最优(学术实用)" },
            { "ms_key": "9", "ms_name" : "最优(词频预测)" },
            { "ms_key": "10", "ms_name" : "最优(词源最优)" },
            { "ms_key": "11", "ms_name" : "最优(词根最优)" },
            { "ms_key": "12", "ms_name" : "最优(当前考试)" },
            { "ms_key": "13", "ms_name" : "最优(专业最优)" },
            { "ms_key": "14", "ms_name" : "最优(最高性价比)" },
            { "ms_key": "15", "ms_name" : "特殊(最难记忆)" },
            { "ms_key": "16", "ms_name" : "特殊(最易记忆)" }
        ],

        "fnSpawnSelector" : function () {
            var sz = "", list = $EP_Glossary.MagicSort.available;

            for ( var i = 0; i < list.length; i++ ) {
                sz += "<option value=\"" + list[i][ "ms_key" ] + "\">" + list[i][ "ms_name" ] + "</option>";
            }

            return sz;
        },
        
        "mountSelector" : function ( at ) {
            $_PINE( at ).append( $EP_Glossary.MagicSort.fnSpawnSelector() )
        }
    }
};

