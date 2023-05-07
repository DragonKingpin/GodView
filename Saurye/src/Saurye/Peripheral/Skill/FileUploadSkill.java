package Saurye.Peripheral.Skill;

import Pinecone.Framework.Util.Summer.MultipartFile.MultipartFile;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.FileHelper;
import Saurye.System.PredatorArchWizardum;

import java.io.File;
import java.io.IOException;
import java.util.Map;

public class FileUploadSkill extends SkillSoul implements SoulSkill, MultipleSkill {
    private PredatorArchWizardum mSoul = null;

    public FileUploadSkill( Coach coach ) {
        super( coach );
        this.mProperties = this.mCoach.nodeProperty().optJSONObject( this.prototypeName() );
        if( !this.mProperties.hasOwnProperty( "charset" ) ){
            this.mProperties.put( "charset", this.mCoach.host().getServerCharset() );
        }
        if( !this.mProperties.hasOwnProperty( "fileMaxSize" ) ){
            this.mProperties.put( "fileMaxSize", this.mCoach.host().getPredatorUploadConfig().get( "PublicFileUpSize" ) );
        }
        if( !this.mProperties.hasOwnProperty( "saveLocation" ) ){
            this.mProperties.put( "saveLocation", this.mCoach.host().getPredatorUploadConfig().get( "PublicFilePath" ) );
        }
    }

    public FileUploadSkill( PredatorArchWizardum soul ){
        this( soul.coach() );
        this.bind( soul );
    }

    @Override
    public void bind( PredatorArchWizardum soul ) {
        this.mSoul = soul;
    }

    @Override
    public String prototypeName() {
        return this.getClass().getSimpleName();
    }

    public PredatorArchWizardum mySoul(){
        return this.mSoul;
    }

    @Override
    public FileUploadSkill setProperty( String key, Object val ){
        return (FileUploadSkill) super.setProperty( key, val );
    }

    @Override
    public FileUploadSkill setProperty( JSONObject properties ){
        return (FileUploadSkill) super.setProperty( properties );
    }

    public Map<String, MultipartFile > files(){
        return this.mSoul.$_FILES();
    }

    @MajorSkill
    public Object upload ( String szFieldName ) {
        String szSaveRelated  = this.mProperties.optString( "saveLocation" );
        String szSaveLocation = this.host().getSystemPath() + szSaveRelated;
        Map<String, MultipartFile > $_FILES = this.mSoul.$_FILES();

        MultipartFile multipartFile = $_FILES.get( szFieldName );
        if( multipartFile != null ){
            String szOriginalName = multipartFile.getOriginalFilename();
            String[] debris       = szOriginalName.split( "\\." );
            String szExtName      = debris[ debris.length - 1 ].toLowerCase();

            Object dyRandomName   = this.mProperties.opt( "randomName" );
            String szRealFilePath = szSaveLocation;
            String szFileName     = szOriginalName;
            if( dyRandomName instanceof Boolean && !(Boolean) dyRandomName ){
                szRealFilePath += szOriginalName ;
            }
            else {
                int nLength = (int) dyRandomName;
                szFileName     = FileHelper.randomName( szSaveLocation, nLength, szExtName );
                szRealFilePath = szSaveLocation + szFileName ;
            }

            JSONArray alloweds = this.mProperties.optJSONArray( "allowTypes" );
            if( alloweds != null ){
                boolean bQualified = false;
                for( Object ext : alloweds ){
                    if( szExtName.equals(ext) ){
                        bQualified = true;
                        break;
                    }
                }

                if( !bQualified ){
                    return -1; // Illegal file type.
                }
            }


            long nMaxSize = this.mProperties.optLong( "fileMaxSize" );
            if( multipartFile.getSize() > nMaxSize ) {
                return -2; // To lager.
            }

            File fDest = new File( szRealFilePath );
            if( fDest.exists() ){
                if( !fDest.delete() ){
                    return -3; // Legacy file is ingrained.
                }
            }

            try{
                multipartFile.transferTo( fDest );
            }
            catch ( IOException e ) {
                return -4; // Unable to move file.
            }

            return szSaveRelated + szFileName;
        }

        return -5; // No upload file given.
    }

    @Buff( "Image" )
    public Object uploadImage ( String szFieldName, String szErrorBackHref ) throws IOException {
        MultipartFile multipartFile = this.mSoul.$_FILES().get( szFieldName );
        if( multipartFile != null ){
            if( !this.mProperties.hasOwnProperty( "imgMaxSize" ) ){
                this.mProperties.put( "imgMaxSize", this.mCoach.host().getPredatorUploadConfig().get( "PublicImgUpSize" ) );
            }
            if( multipartFile.getSize() > this.mProperties.optLong("imgMaxSize" ) ){
                this.mSoul.alert( "文件过大，上传失败！",0, szErrorBackHref );
                return null;
            }

            Object that = this.upload( szFieldName );
            if( that instanceof String ){
                return that;
            }
            else if( (int) that == -1 ){
                this.mSoul.alert( "不支持的类型，上传失败！",0, szErrorBackHref );
                return null;
            }
        }

        this.mSoul.alert( "文件上传失败，请联系管理员！",0, szErrorBackHref );
        return null;
    }

}
