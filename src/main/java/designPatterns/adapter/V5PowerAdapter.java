package designPatterns.adapter;

/**
 * Created by mortal on 2018/3/7.
 */
public class V5PowerAdapter implements V5Power {

    private V220Power v220Power;

    public V5PowerAdapter(V220Power v220Power) {
        this.v220Power = v220Power;
    }

    @Override
    public int providerV5Power() {
        int aV220Power = v220Power.providePower();
        System.out.println("220V转化成5V");
        return 5;
    }
}
