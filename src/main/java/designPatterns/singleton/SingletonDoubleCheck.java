package designPatterns.singleton;

/**
 * Created by mortal on 2018/1/30.
 * 方案3.双重校验锁
 * 星级：3
 * 描述：延迟加载，线程安全，但singleton = new SingletonDoubleCheck()仍可能抛出空指针异常，因为jvm分配对象内存和引用赋值是两步操作，非原子操作
 */
public class SingletonDoubleCheck {
    private static SingletonDoubleCheck singleton;

    // 禁止被实例化
    private SingletonDoubleCheck() {
    }

    public static SingletonDoubleCheck getSingleton() {
        if (singleton == null) {
            synchronized (SingletonDoubleCheck.class) {
                if (singleton == null) {
                    singleton = new SingletonDoubleCheck();
                }
            }
        }
        return singleton;
    }
}


