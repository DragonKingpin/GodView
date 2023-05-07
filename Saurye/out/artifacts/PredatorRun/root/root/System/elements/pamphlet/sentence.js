var $EP_Sentence = Predator.elements.pamphlet.sentence = {
    multiplSentence2Map: function ( hList ){
        var sMap = {};
        for ( var i = 0; i < hList.length; i++ ) {
            var row = hList[ i ];
            var mega_id  = row[ "mega_id" ];
            sMap[ mega_id ] = pPine.Objects.affirmObject( sMap[ mega_id ] );
            sMap[ mega_id ][ "id"         ] = mega_id;
            sMap[ mega_id ][ "mega_id"    ] = row[ "mega_id" ];
            sMap[ mega_id ][ "index_of"   ] = row[ "index_of" ];
            sMap[ mega_id ][ "s_sentence" ] = row[ "s_sentence" ];
            sMap[ mega_id ][ "s_cn_def"   ] = row[ "s_cn_def" ];
            sMap[ mega_id ][ "s_add_date" ] = row[ "s_add_date" ];
            sMap[ mega_id ][ "words"      ] = pPine.Objects.affirmArray( sMap[ mega_id ][ "words" ] );
            if( $isTrue( row[ "en_word" ] ) ){
                sMap[ mega_id ][ "words"      ].push( row[ "en_word" ] );
            }
        }

        return sMap;
    },

    registerListAction: function ( pageData, self ) {
        pageData.fnSiftByDate         = function () {
            Predator.searcher.querySearch( {
                "startTime" : "#startTime", "endTime" : "#endTime"
            }, true );
        };

        pageData.fnSiftByDaily       = function () {
            Predator.searcher.bindSingleShardedSearch(
                "daily_type", '#daily_type', [ 'startTime', 'endTime' ],  true
            );
        };

        pageData.fnClearDateSearch         = function () {
            Pinecone.Navigate.redirect(
                Pinecone.Navigate.urlAutoMerge( {
                    "startTime" : null, "endTime" : null, "daily_type": null
                }, $_GET )
            );
        };

        pageData.fnSortSentences         = function () {
            Predator.searcher.bindSingleSearch( "sort_type", '#sort_type', true );
        };


        pageData.fnAdvanceSwitch      = function () {
            var hAdvBox = $_PINE( ".p-p-searcher-advance" );
            if( hAdvBox.css("display") === "none" ) {
                hAdvBox.show();
            }
            else {
                hAdvBox.hide();
            }
        };
    },

    renderSentenceSearcher: function (  ) {
        $EP_Sentence.MagicSort.mountSelector( "#sort_type" );

        pPine.renderer.quickRender( {
            "#startTime" : pPine.DateTime.format( "yyyy-MM-dd" ),
            "#endTime"   : pPine.DateTime.format( "yyyy-MM-dd" )
        } );

        var szQStartTime = $_GET[ "startTime"  ], szQEndTime = $_GET[ "endTime"   ],
            szQDaily     = $_GET[ "daily_type" ], szKeyWord  = $_GET[ "keyWord"   ];

        if( szQStartTime || szQEndTime || szKeyWord || szQDaily ) {
            $_PINE( ".p-p-searcher-advance" ).show();
        }
    },

    MagicSort : {
        "available" : [
            { "ms_key": "0", "ms_name" : "随机排序" },
            { "ms_key": "1", "ms_name" : "添加顺序" },
            { "ms_key": "2", "ms_name" : "最近添加" },
        ],

        "fnSpawnSelector" : function () {
            var sz = "", list = $EP_Sentence.MagicSort.available;

            for ( var i = 0; i < list.length; i++ ) {
                sz += "<option value=\"" + list[i][ "ms_key" ] + "\">" + list[i][ "ms_name" ] + "</option>";
            }

            return sz;
        },

        "mountSelector" : function ( at ) {
            $_PINE( at ).append( $EP_Sentence.MagicSort.fnSpawnSelector() )
        }
    }
};
