package designPatterns.factory.abstractFactory;

import designPatterns.factory.BMW;
import designPatterns.factory.Engine;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

/**
 * Created by mortal on 2018/3/7.
 */
public class TestInterfaceCls implements TestInterface {

    @Override
    public Engine createEngine() {
        return null;
    }

    @Override
    public BMW createBMW() {
        return null;
    }

    public static void main(String args[]) {
        try {
            BufferedInputStream bufferedInputStream = new BufferedInputStream(new BufferedInputStream(new FileInputStream("")));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
