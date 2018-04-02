package designPatterns.factory.abstractFactory;

import designPatterns.factory.BMW;
import designPatterns.factory.BMW320;
import designPatterns.factory.Engine;
import designPatterns.factory.EngineA;

/**
 * Created by mortal on 2018/3/7.
 */
public class BMW320Factory implements AbstractFactory {

    @Override
    public Engine createEngine() {
        return new EngineA();
    }

    @Override
    public BMW createBMW() {
        return new BMW320();
    }

    public static void main(String args[]) {
        AbstractFactory factory = new BMW320Factory();
        factory.createEngine();
        factory.createBMW();
    }
}
