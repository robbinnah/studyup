package designPatterns.observer;

import java.util.Observable;
import java.util.Observer;

/**
 * Created by mortal on 2018/3/5.
 */
public class Observer1 implements Observer {

    public void registerSubject(Observable observable){
        observable.addObserver(this);
    }

    public void update(Observable o, Object arg) {
        if(o instanceof SubjectForHealth){
            SubjectForHealth subjectForHealth = (SubjectForHealth) o;
            System.out.println("来自健康订阅号的消息："+subjectForHealth.getMessage());
        }
        if(o instanceof SubjectForSport){
            SubjectForSport subjectForSport = (SubjectForSport) o;
            System.out.println("来自运动订阅号的消息："+subjectForSport.getMessage());
        }
    }
}
