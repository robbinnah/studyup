package designPatterns.observer;

import java.util.Observable;

/**
 * Created by mortal on 2018/3/5.
 * 观察者模式
 */
public class SubjectForHealth extends Observable {

    private String message;

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
        setChanged();
        notifyObservers();
    }
}
