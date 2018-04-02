package designPatterns.adapter;

/**
 * Created by mortal on 2018/3/7.
 */
public class TestAdapter {

    public static void main(String args[]) {
        V5Power v5PowerAdapter = new V5PowerAdapter(new V220Power());
        Mobile mobile = new Mobile();
        mobile.inputMobile(v5PowerAdapter);
    }
}
