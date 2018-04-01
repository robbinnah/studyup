package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by mortal on 2018/2/23.
 */
public class SHA256Util {

    public static String toSHA256Str(String str){
        MessageDigest messageDigest;
        String encodeStr ="";
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(str.getBytes("UTF-8"));
            encodeStr = byte2Hex(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return encodeStr;
    }

    private static String byte2Hex(byte[] bytes){
        StringBuffer stringBuffer = new StringBuffer("");
        String tmp = null;
        for(int i=0; i<bytes.length; i++){
            // byte&0XFF 计算机以二进制补码存储， byte 8位 int 32位 如果不& byte高24位将补成1, 补码将发生变化
            tmp = Integer.toHexString(bytes[i]&0xFF);
            if(tmp.length() == 1){
                stringBuffer.append("0");
            }
            stringBuffer.append(tmp);
        }
        return stringBuffer.toString();
    }
    public static void main(String args[]){
        int x = 5;
        int y = 0;
        while(!SHA256Util.toSHA256Str(x*y +"").endsWith("0")){
            y++;
        }
        System.out.println("++++最终结果:" + y);
    }
}
