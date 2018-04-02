package designPatterns.factory.abstractFactory;

import designPatterns.factory.BMW;
import designPatterns.factory.Engine;

/**
 * Created by mortal on 2018/3/7.
 */
public interface AbstractFactory {

    Engine createEngine();

    BMW createBMW();

    public static void main(String args[]) {

    }
}
