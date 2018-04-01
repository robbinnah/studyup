package other;

import util.SysUtil;

import java.io.File;
import java.util.Arrays;
import java.util.List;

/**
 * Created by mortal on 2018/2/3.
 */
public class ForFun {

    public static void main(String args[]){
        File file = new File("F:\\DownLoad\\movies\\生活大爆炸1-8季\\The Big Bang Theory Season 4");
        lastChange(file);

    }

    public static void lastChange(File file){
        List<String> fileNames = Arrays.asList(file.list());

        for(File tmp : file.listFiles()){
            String tmpName = tmp.getName();
            if(tmpName.endsWith("rar")) continue;
            if(tmpName.endsWith("ass")) tmp.delete();
            String prefix = tmpName.substring(0, tmpName.lastIndexOf("."));
            String postfix = tmpName.substring(tmpName.lastIndexOf("."), tmpName.length());
            String commonName = tmpName.substring(tmpName.indexOf("S0"), tmpName.indexOf("S0")+6);
//            SysUtil.sopln("pre:"+prefix+", post:"+postfix+", common:" + commonName);

            if(postfix.startsWith(".srt")){
                for(String f: fileNames){
                    if((f.endsWith("m4v") || f.endsWith("mkv")||f.endsWith("mp4")) && f.contains(commonName)){
                        String updateName;
                        updateName = tmp.getParent()+"\\"+f.substring(0, f.lastIndexOf("."))+postfix;
                        SysUtil.sopln("update: "+updateName);
                        tmp.renameTo(new File(updateName));
                    }
                }
            }
        }

    }


}
