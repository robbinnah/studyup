package designPatterns.singleton;

/**
 * Created by mortal on 2018/1/30.
 * 方案1：枚举
 * 星级：5
 * desc: 借助JDK1.5中添加的枚举来实现单例模式。不仅能避免多线程同步问题，而且还能防止反序列化重新创建新的对象
 */
public enum SingletonEnum {
    singleton;

    public void doWhatever(){
        System.out.print("do some thing");
    }
   /* public static void main(String args[]){
        SingletonEnum.singleton.doWhatever();
    }*/
}
