package designPatterns.factory.simpleFactory;


import designPatterns.factory.BMW;
import designPatterns.factory.BMW320;
import designPatterns.factory.BMW523;

/**
 * Created by mortal on 2018/3/7.
 */
public class SimpleFactory {

    public BMW createBMW(int type) {
        switch (type) {
            case 320:
                return new BMW320();
            case 523:
                return new BMW523();
            default:
                break;
        }
        return null;
    }
}
