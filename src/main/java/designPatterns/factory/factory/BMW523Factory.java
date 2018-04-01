package designPatterns.factory.adstractFactory;

import designPatterns.factory.BMW;
import designPatterns.factory.BMW523;

/**
 * Created by mortal on 2018/3/7.
 */
public class BMW523Factory implements BMWFactory {

    public static void main(String args[]) {

    }

    @Override
    public BMW createBMW() {
        return new BMW523();
    }
}
