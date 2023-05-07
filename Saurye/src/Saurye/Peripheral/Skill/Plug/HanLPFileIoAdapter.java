package Saurye.Peripheral.Skill.Plug;

import Saurye.System.Predator;
import com.hankcs.hanlp.corpus.io.IIOAdapter;

import java.io.*;

public class HanLPFileIoAdapter implements IIOAdapter {
    private static HanLPFileIoAdapter prototype;

    private Predator mHost;

    public static void asPrototype( Predator host ){
        HanLPFileIoAdapter.prototype = new HanLPFileIoAdapter( host );
    }

    public HanLPFileIoAdapter( Predator host ){
        this.mHost = host;
    }

    public HanLPFileIoAdapter(){
        this.mHost = HanLPFileIoAdapter.prototype.mHost;
    }

    @Override
    public InputStream open( String path ) throws IOException {
        return new FileInputStream(this.mHost.getResourcesPath() + path );
    }

    @Override
    public OutputStream create( String path ) throws IOException {
        return new FileOutputStream(this.mHost.getResourcesPath() + path );
    }


}