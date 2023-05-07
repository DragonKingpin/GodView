package Saurye.Peripheral.Skill;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class CipherSkill extends SkillSoul implements BasicSkill, MagicEnchantSkill {
    protected Cipher mCipher = null; /** AES128 CTR PKCS5 **/

    protected byte[]   mRawKey = null;

    protected SecretKeySpec mKeySpec = null;

    protected IvParameterSpec mShardIvParameterSpec = null;

    private void initCipher() {
        try {
            this.mCipher = Cipher.getInstance( "AES/CTR/PKCS5Padding");
        }
        catch ( NoSuchAlgorithmException | NoSuchPaddingException e ){
            e.printStackTrace();
        }
        String szKey = this.getInner16Key();
        if ( szKey.length() == 16 ) {
            this.mRawKey = szKey.getBytes( StandardCharsets.UTF_8 );
            this.mKeySpec = new SecretKeySpec( this.mRawKey, "AES" );
            this.mShardIvParameterSpec = new IvParameterSpec( this.mRawKey );
        }
    }

    public CipherSkill( Coach coach ) {
        super( coach );
        this.initCipher();
    }

    @Override
    public String prototypeName() {
        return this.getClass().getSimpleName();
    }

    public Cipher getCipher() {
        return this.mCipher;
    }

    public String getInner16Key() {
        return this.host().get16BitInnerPassword();
    }

    public String simpleEncrypt( byte[] data ) {
        if( this.mRawKey == null || this.mCipher == null ){
            return null;
        }

        try{
            this.mCipher.init( Cipher.ENCRYPT_MODE, this.mKeySpec, this.mShardIvParameterSpec );
            byte[] encrypted = this.mCipher.doFinal( data );
            return CipherSkill.base64Encode( encrypted );
        }
        catch ( InvalidAlgorithmParameterException | InvalidKeyException | IllegalBlockSizeException | BadPaddingException e ){
            e.printStackTrace();
            return null;
        }
    }

    public byte[] simpleDecrypt( String szBase64Data ) {
        if( this.mRawKey == null || this.mCipher == null ){
            return null;
        }

        try {
            this.mCipher.init( Cipher.DECRYPT_MODE, this.mKeySpec, this.mShardIvParameterSpec );
            return this.mCipher.doFinal( CipherSkill.base64Decode( szBase64Data ) );
        }
        catch ( InvalidAlgorithmParameterException | InvalidKeyException | IllegalBlockSizeException | BadPaddingException e ){
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String enchant( Object data ) {
        return this.simpleEncrypt( (byte[]) data );
    }

    @Override
    public byte[] disenchant( Object szBase64Data ) {
        return this.simpleDecrypt( (String) szBase64Data );
    }


    public static byte[] base64Decode( String b ) {
        return Base64.getDecoder().decode( b.getBytes() );
    }

    public static String base64Encode( byte[] bytes ){
        return new String( Base64.getEncoder().encode( bytes ) );
    }

}
