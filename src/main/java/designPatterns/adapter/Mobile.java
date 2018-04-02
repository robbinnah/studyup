package designPatterns.adapter;

/**
 * Created by mortal on 2018/3/7.
 */
public class Mobile {

    public void inputMobile(V5Power v5Power) {
        int power = v5Power.providerV5Power();
        System.out.println("mobile need to be provided power:" + power + "v");
    }

    public static void main(String args[]) {

    }
}
