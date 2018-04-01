package designPatterns.singleton;

/**
 * Created by mortal on 2018/3/5.
 */
public class TestSingleton {

    public static void main(String args[]){
        for(int i=0; i<1000; i++){
//            System.out.println(SingletonInner.getSingleton());
//            System.out.println(SingletonEnum.singleton.getClass().hashCode());
            System.out.println(SingletonDoubleCheck.getSingleton());
        }

    }
}
