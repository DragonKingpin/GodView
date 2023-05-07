var $EP_Pamphlet = Predator.elements.pamphlet = {
    renderDailySearch:  function ( that, szDateKey ) {
        $.ajax({
            url: Predator.spawnActionQuerySpell( "loadGroupedDaily" ),
            async: true,
            type: "GET",
            data: {'class_id':$_GET[ "class_id" ]},
            success: function ( result ) {
                var list = JSON.parse( result ) [ "DailyList" ];
                var sz = "<option value=\"\" >请选择</option>";
                var szQDaily = $_GET[ "daily_type" ];

                for ( var i = 0; i < list.length; i++ ) {
                    sz += "<option value=\"" + list[i][ szDateKey ] + "\" " +
                        ( szQDaily === list[i][ szDateKey ] ? "selected" :"" )
                        + " >" + list[i][ szDateKey ] + "</option>";
                }

                $_PINE( that ).html( sz );
            }
        });
    },
};