package designPatterns.factory.factory;

import designPatterns.factory.BMW;
import designPatterns.factory.BMW320;

/**
 * Created by mortal on 2018/3/7.
 */
public class BMW320Factory implements BMWFactory {

    public static void main(String args[]) {

    }

    @Override
    public BMW createBMW() {
        return new BMW320();
    }
}
