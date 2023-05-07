Predator.equipment.ui.KeyWordList = {
    defun: function( at, name, max ){
        this.mhAt       = $_PINE( at );
        this.mszName    = name;
        this.mnMax      = max ? max : 8;
        this.mnColSize  = 6;
        this.mnCountNum = 0;
        this.mnFieldID  = 0;
        this.mszNS      = pPine.Random.nextString( 12 );

        this.fnSetColSize = function ( nSize ) {
            this.mnColSize = nSize;
        };

        this.mfnGetId   = function () {
            return this.mszNS + this.mnFieldID;
        };

        this.fnAdd = function ( key ) {
            key = key? key : "";
            if( this.mnCountNum < this.mnMax ){
                this.mhAt.append(
                    "<div class='col-md-" + this.mnColSize + "' ><div class=\"panel panel-default\" style=\"border-radius: 0;\">\n" +
                    "   <div class=\"panel-body\" style=\"padding: 10px;\">\n" +
                    "      <div class=\"form-group com-group-control-relate\">\n" +
                    "         <label>关键字: </label>\n" +
                    "         <input class=\"form-control\" id=\""+this.mfnGetId()+"\" name=\"" + this.mszName + "[]\" type=\"text\"  value='"+key+"'  placeholder=\"请输入关键字\" maxlength=\"50\" required\>\n" +
                    "      </div>\n" +
                    "      <a href='javascript:void(0)' id=\"optRemove"+ this.mfnGetId()+"\" style=\"float: right;margin-bottom: -1%;color: black\"><i class=\"fa fa-close\"></i></a>\n" +
                    "   </div>\n" +
                    "</div></div>");

                var self  = this;
                var hOpt = $_PINE("#optRemove" + this.mfnGetId() );
                hOpt.on('click', function () {
                    self.fnRemove( hOpt );
                });
                this.mnCountNum++;
                this.mnFieldID++;
            }
            else {
                alert("过多的关键字，限制" + this.mnMax + "个！")
            }
        };

        this.fnRemove = function ( e ) {
            $(e).parent("div").parent("div").remove();
            this.mnCountNum--;
        }
    },

    spawn: function ( at, name, max ) {
        return new Predator.equipment.ui.KeyWordList.defun(  at, name, max  );
    }

};