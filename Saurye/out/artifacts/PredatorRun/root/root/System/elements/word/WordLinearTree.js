var labelType, useGradients, nativeTextSupport, animate;
(function() {
  var ua = navigator.userAgent,
      iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i),
      typeOfCanvas = typeof HTMLCanvasElement,
      nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'),
      textSupport = nativeCanvasSupport 
        && (typeof document.createElement('canvas').getContext('2d').fillText == 'function');
  //I'm setting this based on the fact that ExCanvas provides text support for IE
  //and that as of today iPhone/iPad current text support is lame
  labelType = (!nativeCanvasSupport || (textSupport && !iStuff))? 'Native' : 'HTML';
  nativeTextSupport = labelType == 'Native';
  useGradients = nativeCanvasSupport;
  animate = !(iStuff || !nativeCanvasSupport);
})();

var WordLinearTree = {
    render: function ( at, loger, treeData, ns ) {
        var getTree = (function() {
            return function(nodeId, level) {
                return null;
            };
        })();

        //Implement a node rendering function called 'nodeline' that plots a straight line
        //when contracting or expanding a subtree.
        //实现节点渲染函数nodeline,在收缩或展开的子树时绘制一条直线
        $jit.ST.Plot.NodeTypes.implement({
            'nodeline': {
                'render': function(node, canvas, animating) {
                    if(animating === 'expand' || animating === 'contract') {
                        var pos = node.pos.getc(true), nconfig = this.node, data = node.data;
                        var width  = nconfig.width, height = nconfig.height;
                        var algnPos = this.getAlignedPos(pos, width, height);
                        var ctx = canvas.getCtx(), ort = this.config.orientation;
                        ctx.beginPath();
                        if(ort == 'left' || ort == 'right') {
                            ctx.moveTo(algnPos.x, algnPos.y + height / 2);
                            ctx.lineTo(algnPos.x + width, algnPos.y + height / 2);
                        } else {
                            ctx.moveTo(algnPos.x + width / 2, algnPos.y);
                            ctx.lineTo(algnPos.x + width / 2, algnPos.y + height);
                        }
                        ctx.stroke();
                    }
                }
            }

        });

        //init Spacetree 初始化Spacetree
        //Create a new ST instance 创建一个新的ST实例
        var st = new $jit.ST({
            'injectInto': at,
            //set duration for the animation 为动画设置时间
            duration: 300,
            //set animation transition type 设置动画过渡类型
            transition: $jit.Trans.Quart.easeInOut,
            //set distance between node and its children 设置节点及其子节点之间的最大距离
            levelDistance: 50,
            //set max levels to show. Useful when used with 设置显示的最大的树的层级
            //the request method for requesting trees of specific depth 在请求的特定深度的树时十分有用
            levelsToShow: 4,
            //constrained: false,

            offsetX: 200,

            Navigation: {
                enable:true,
                panning:true
            },

            Node: {
                height: 26,
                width: 50,
                //use a custom
                //node rendering function
                type: 'nodeline',
                color:'#23A4FF',
                lineWidth: 2,
                align:"center",
                overridable: true
            },

            Edge: {
                type: 'bezier',
                lineWidth: 2,
                color:'#23A4FF',
                overridable: true
            },

            //Add a request method for requesting on-demand json trees.
            //This method gets called when a node
            //is clicked and its subtree has a smaller depth
            //than the one specified by the levelsToShow parameter.
            //In that case a subtree is requested and is added to the dataset.
            //This method is asynchronous, so you can make an Ajax request for that
            //subtree and then handle it to the onComplete callback.
            //Here we just use a client-side tree generator (the getTree function).
            //添加一个请求方法，按需请求json树。
            //此方法被调用当一个节点被点击时且其子树中具有比levelsToShow参数所指定的更小的深度。
            //在这种情况下，一个子树被请求，并添加到数据集。
            //这种方法是异步的，这样就可以使一个Ajax请求的子树，然后使用onComplete回调函数进行处理。
            //这里我们只使用一个客户端树生成器（getTree功能）。
            request: function( nodeId, level, onComplete ) {
                var ans = getTree(nodeId, level);
                onComplete.onComplete(nodeId, ans);
            },

            onBeforeCompute: function(node){
                loger.write( "当前选中: " + node.name );
            },

            onAfterCompute: function(){},

            //This method is called on DOM label creation.
            //Use this method to add event handlers and styles to
            //your node.
            //调用此方法为DOM创建标签。使用此方法将事件处理程序和样式添加到您的节点。
            onCreateLabel: function(label, node){//树状图的节点样式
                label.id = node.id;
                label.innerHTML = node.name;
                label.onclick = function(){
                    st.onClick(node.id);
                };
                //set label styles 设置标签样式
                var style = label.style;
                style.width = 50 + 'px';
                style.height = 24 + 'px';
                style.cursor = 'pointer';
                style.color = '#000';
                //style.backgroundColor = '#1a1a1a';
                style.fontSize = '14px';
                style.textAlign= 'center';
                style.textDecoration = 'underline';
                style.paddingTop = '3px';

            },

            //This method is called right before plotting
            //a node. It's useful for changing an individual node
            //style properties before plotting it.
            //The data properties prefixed with a dollar
            //sign will override the global node style properties.
            //这个方法在绘制一个节点之前被正确调用。这对绘制之前，改变单个节点的样式属性非常有用。前面有一个美元符号的数据属性将覆盖全局节点的样式属性。
            onBeforePlotNode: function(node){
                //add some color to the nodes in the path between the
                //root node and the selected node.
                //在根节点到选定的节点之间的路径上给节点添加一些颜色。
                if (node.selected) {
                    node.data.$color = "#ff7";
                }
                else {
                    delete node.data.$color;
                }
            },

            //This method is called right before plotting
            //an edge. It's useful for changing an individual edge
            //style properties before plotting it.
            //Edge data proprties prefixed with a dollar sign will
            //override the Edge global style properties.
            //此方法绘制一条边前才调用。这对绘制之前改变单个边样式属性非常有用。前面有一个美元符号将覆盖边缘全局样式属性EDGE数据的属性。
            onBeforePlotLine: function(adj){
                if (adj.nodeFrom.selected && adj.nodeTo.selected) {
                    adj.data.$color = "#666";
                    adj.data.$lineWidth = 3;
                }
                else {
                    delete adj.data.$color;
                    delete adj.data.$lineWidth;
                }
            }
        });
        //load json data 读取json数据

        st.loadJSON(  treeData  );
        //st.loadJSON( eval( '(' + json + ')' ) );
        //compute node positions and layout 计算节点的位置和布局
        st.compute();

        st.geom.translate(new $jit.Complex(-200, 0), "current");
        //emulate a click on the root node. 模拟根节点上的点击事件
        st.onClick(st.root);
        //end
        //Add event handlers to switch spacetree orientation. 添加事件处理程序切换spacetree树展示的方向
        function get(id) {
            return document.getElementById(id);
        }

        ns = ns ? ns : "";

        var top = get(ns + 'r-top'),
            left = get(ns + 'r-left'),
            bottom = get(ns + 'r-bottom');

        console.log( left );

        function changeHandler() {
            if(this.checked) {
                top.disabled = bottom.disabled = left.disabled = true;
                st.switchPosition(this.value, "animate", {
                    onComplete: function(){
                        top.disabled = bottom.disabled = left.disabled = false;
                    }
                });
            }
        }

        top.onchange = left.onchange = bottom.onchange = changeHandler;

    }
};

