package designPatterns.singleton;

/**
 * Created by mortal on 2018/1/30.
 * 单例模式能够保证整个应用中有且只有一个实例。例如Tomcat的servlet, 继承于此的spring mvc的dispatcherServlet
 * 方案2. 内部类
 * 星级：4
 * 描述： 类加载机制保证初始化实例时只有一个线程,并延迟加载
 *
 *
 * 关于静态内部类
 * 静态内部类的加载不需要依附外部类，在使用时才加载。不过在加载静态内部类的过程中也会加载外部类。
 */
public class SingletonInner{

    // 禁止被实例化
    private SingletonInner() {
    }

    private static class SingletonHolder{
        private static final SingletonInner singleton = new SingletonInner();
    }

    public static SingletonInner getSingleton(){
        return SingletonHolder.singleton;
    }
}
