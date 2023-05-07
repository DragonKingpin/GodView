package Saurye.System;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;

import java.io.IOException;
import java.sql.SQLException;

public class CurrencyTemplate {
    private PredatorArchWizardum mhParentImage;

    private String szPictureMultipleExplorerContent;

    private String szPictureSingleExplorerContent;

    private final int nDefaultFileAllowSize = 2097152;

    private final JSONObject mhDefaultFileCSSStyle = new JSONObject("{\"color\":\"#1E88C7\",\"background\":\"#D0EEFF\",\"font-size\":\"16px\",\"padding\":\"6px 12px\",\"border\":\"1px solid #99D3F5\",\"border-radius\":\"4px\",\"line-height\":\"20px\"}");


    CurrencyTemplate( PredatorArchWizardum hSoul ) {
        this.mhParentImage = hSoul;
        try{
            this.szPictureMultipleExplorerContent =  this.parent().readFileContentAll( this.getPictureMultipleExplorerPath() );
            this.szPictureSingleExplorerContent   =  this.parent().readFileContentAll( this.getPictureSingleExplorerPath()   );
        }
        catch ( IOException e ){
            e.printStackTrace();
        }
    }

    private String getTemplatePath(){
        return this.parent().getSystemPath()+this.parent().getRealTemplatePath()+this.getEquipmentsConfig().getString("TemplatePath");
    }

    private Predator parent(){
        return this.mhParentImage.system();
    }

    private JSONObject getEquipmentsConfig(){
        return this.parent().getPeripheralConfig().getJSONObject( "Equipment" );
    }



    private String getPictureMultipleExplorerPath(){
        return this.getTemplatePath()+"PictureMultipleExplorer.html";
    }

    private String getPictureMultipleExplorerContent(){
        return this.szPictureMultipleExplorerContent;
    }


    private String getPictureSingleExplorerPath(){
        return this.getTemplatePath()+"PictureSingleExplorer.html";
    }

    private String getPictureSingleExplorerContent(){
        return this.szPictureSingleExplorerContent;
    }






    private String spawnInnerFileUploader(JSONArray hSpawnArray, int  nAllowSize,JSONObject hCssStyle){
        StringBuilder szFileUploaderStream = new StringBuilder();
        szFileUploaderStream.append("<style>\n" + "            .crisp-file-upload {\n" + "                position: relative;\n" + "                display: inline-block;\n" + "                color: ").append(hCssStyle.getString("color")).append(";\n").append("                background: ").append(hCssStyle.getString("background")).append(";\n").append("                font-size: ").append(hCssStyle.getString("font-size")).append(";\n").append("                padding: ").append(hCssStyle.getString("padding")).append(";\n").append("                border: ").append(hCssStyle.getString("border")).append(";\n").append("                border-radius: ").append(hCssStyle.getString("border-radius")).append("; ?>;\n").append("                line-height: ").append(hCssStyle.getString("line-height")).append(";\n").append("                overflow: hidden;\n").append("                text-decoration: none;\n").append("                text-indent: 0;\n").append("                border-radius: 0;\n").append("            }\n").append("\n").append("            .crisp-file-upload:hover {\n").append("                background: #AADFFD;\n").append("                border-color: #78C3F3;\n").append("                color: #004974;\n").append("                text-decoration: none;\n").append("                cursor: pointer;\n").append("            }\n").append("\n").append("            .crisp-file-upload:hover input {\n").append("                cursor: pointer;\n").append("            }\n").append("        </style>\n").append("        <script>\n").append("            function CrispFileUploader(spawnAtID, uName, allowSize, fileName, filePath) {\n").append("                this.spawnAtID = spawnAtID;\n").append("                this.uName = uName;\n").append("                this.allowSize = allowSize;\n").append("                this.filePath = filePath ? filePath : \"#\";\n").append("                this.downloadFileDisplay = filePath ? \"display: inline-block\" : \"display: none\";\n").append("                this.fileName = fileName ? fileName : \"点击此处上传文件\";\n").append("                this.fileUploaderID = spawnAtID + \"-CrispFileUploader\";\n").append("                this.fileDownloadID = spawnAtID + \"-CrispFileDownload\";\n").append("                this.spawn = function () {\n").append("                    var objHandle = document.getElementById(this.spawnAtID);\n").append("                    if (objHandle) {\n").append("                        var fileUploadZone = \"\";\n").append("                        fileUploadZone += '\\n' +\n").append("                            '<a href=\"javascript:void(0)\" class=\"crisp-file-upload\" id=\"'+this.fileUploaderID+'\" onclick=\"document.getElementById(\\''+this.uName+'\\').click();\">'+this.fileName+'</a>\\n' +\n").append("                            '<input type=\"file\" name='+this.uName+' id='+this.uName+' onchange=\"previewFile(\\''+this.fileUploaderID+'\\',this,\\''+this.allowSize+'\\')\" style=\"display: none;\" />\\n'+\n").append("                            '<a href=\"'+this.filePath+'\" class=\"crisp-file-upload\" id=\"'+this.fileDownloadID+'\" style=\"'+this.downloadFileDisplay+';\"><i class=\"fa fa-download\">下载</i></a>';\n").append("                        objHandle.insertAdjacentHTML('beforeend', fileUploadZone);\n").append("                    }\n").append("                };\n").append("            }\n").append("\n").append("            function previewFile(uID, hObj, allowSize) {\n").append("                var arrs = hObj.value.split('\\\\');\n").append("                if (hObj && arrs.length > 1) {\n").append("                    var hFile = hObj.files[0];\n").append("                    if (allowSize) {\n").append("                        if (allowSize < hFile.size) {\n").append("                            hObj.value = null;\n").append("                            alert(\"文件太大，不允许超过\" + allowSize / 1024 /1024 + \"MB!\");\n").append("                            return null;\n").append("                        }\n").append("                    }\n").append("                    document.getElementById(uID).innerText=arrs[arrs.length-1];\n").append("                }\n").append("            }\n").append("\n").append("            function monitorUploadFile(fId) {\n").append("                this.uploadFileId = fId ;\n").append("                if(document.getElementById(this.uploadFileId).value===\"\"){\n").append("                    alert(\"请上传文件\");\n").append("                    return false;\n").append("                }\n").append("                return true;\n").append("            }");
        for(int i = 0;i<hSpawnArray.length();i++){
//            szFileNameFiled != null ? szFileNameFiled : null
//             szFilePathFiled != null ? szFilePathFiled : null

            szFileUploaderStream.append("new CrispFileUploader(\"").append(hSpawnArray.getJSONObject(i).getString("at")).append("\", \"").append(hSpawnArray.getJSONObject(i).getString("name")).append("\",").append(nAllowSize).append(",\n").append("                ").append(hSpawnArray.getJSONObject(i).opt("fileName").toString()).append(",\n").append("                ").append(hSpawnArray.getJSONObject(i).opt("filePath").toString()).append(").spawn();");
        }
        return szFileUploaderStream+"</script>";
    }

    public String usingFileUploader(JSONArray hSpawnArray, int  nAllowSize,JSONObject hCssStyle){
        return this.spawnInnerFileUploader(hSpawnArray,nAllowSize,hCssStyle);
    }

    public String usingFileUploader(JSONArray hSpawnArray, int  nAllowSize){
        return this.spawnInnerFileUploader(hSpawnArray,nAllowSize,this.mhDefaultFileCSSStyle);
    }

    public String usingFileUploader(JSONArray hSpawnArray, JSONObject hCssStyle){
        return this.spawnInnerFileUploader(hSpawnArray,this.nDefaultFileAllowSize,hCssStyle);
    }

    public String usingFileUploader(JSONArray hSpawnArray){
        return this.spawnInnerFileUploader(hSpawnArray,this.nDefaultFileAllowSize,this.mhDefaultFileCSSStyle);
    }



    public String usingPredatorPictureSingleExplorer(){
        return this.getPictureSingleExplorerContent();
    }

    public String spawnPredatorPictureSingleExplorer(String szURL,String szName,int nSize){
        return "<div class=\""+szName+"\">\n" +
                "            <input name=\""+szName+"\" class=\"form-control\" type=\"text\" value=\""+szURL+"\" />\n" +
                "            <button onclick=\"CrispPictureSingleExplorer.showDialog('"+szName+"')\" type=\"button\" class=\"btn btn-default\"  data-toggle=\"modal\" data-target=\"#CrispPictureSingleExplorerDialog\">选择图片</button>\n" +
                "            <div class=\"input-group \" style=\"margin-top:.5em;\">\n" +
                "                <img src=\""+szURL+"\" onerror=\"this.src='/root/root/system/img/nopic.jpg'; this.title='图片未找到.'\" class=\"img-responsive img-thumbnail\" width=\""+nSize+"\">\n" +
                "                <em class=\"close\" style=\"position:absolute; top: 0; right: -14px;\" title=\"删除这张图片\" onclick=\"deleteImage(this)\">×</em>\n" +
                "            </div>\n" +
                "        </div>";
    }

    public String usingPredatorPictureMultipleExplorer(){
        return this.getPictureMultipleExplorerContent();
    }

    public String spawnPredatorPictureMultipleExplorer(String szTableName,String szName,int nSize){
        try {
            String szImageURL = this.parent().mysql().fetch(
                    "SELECT imageurl FROM " + szTableName
                            + " where classof='carouselMain'").getJSONObject(0).getString("imageurl");
            if( szImageURL != null ) {
                StringBuilder szPredatorPictureMultipleExplorerContent = new StringBuilder(" <div class=\"" + szName + "\">\n" +
                        "            <span class=\"uneditable-input\" style=\"width: 85%;\">批量上传图片</span>\n" +
                        "            <button onclick=\"CrispPictureMultipleExplorer.showDialog('" + szName + "');\" type=\"button\" class=\"btn btn-default\"  data-toggle=\"modal\" data-target=\"#CrispPictureMultipleExplorerDialog\">选择图片</button>\n" +
                        "            <div class=\"input-group multi-img-details\" id=\"input-group\">");
                JSONArray hURLArray = new JSONArray( szImageURL );
                for(int i=0;i<hURLArray.length();i++){
                    Object row = hURLArray.get(i);
                    szPredatorPictureMultipleExplorerContent.append("<div class=\"multi-item\"  style=\"margin-top:0.5em;\">\n" + "                            <img src=\"").append(row.toString()).append("\" onerror=\"this.src='/root/system/img/nopic.jpg'; this.title='图片未找到.'\" class=\"img-responsive img-thumbnail\" width=\"").append(nSize).append("\">\n").append("                            <input name=\"").append(szName).append("[]\" value=\"").append(row.toString()).append("\" type=\"hidden\"/>\n").append("                            <em class=\"close\" style=\"position: absolute; top: 0; right: -14px;\" title=\"删除这张图片\" onclick=\"deleteMultiImage(this)\">×</em>\n").append("                        </div>");
                }
                szPredatorPictureMultipleExplorerContent.append(" </div>\n" + "        </div>");
                return szPredatorPictureMultipleExplorerContent.toString();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "";
    }

    public String usingUEditor(){
        String href = this.getEquipmentsConfig().getString("ueditor");
        return "<script src=\"" + href +"ueditor.config.js\"></script><script src=\"" + href +"ueditor.all.min.js\"></script>";
    }

    public String usingLaydate(){
        String href = this.getEquipmentsConfig().getString("laydate");
        return "<script src=\"" + href +"laydate.js\"></script>";
    }

    public String spitUEditor(String szUiID,String szName,int nHeight,boolean bUsingTemplate){
        String szUEditorContent = "<script> var "+szUiID+"Handle = UE.getEditor('"+szUiID+"', {initialFrameWidth: null, initialFrameHeight: "+nHeight+"});</script>";
//        if(bUsingTemplate){
//
//        }
        szName = szName.isEmpty()? " ": "name=\""+szName+"\"";
        szUEditorContent += "<script id=\""+szUiID+"\" type=\"text/plain\" "+szName+"></script>";
        return szUEditorContent;
    }

}
