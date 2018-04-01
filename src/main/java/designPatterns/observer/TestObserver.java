package designPatterns.observer;

/**
 * Created by mortal on 2018/3/5.
 */
public class TestObserver {

    public static void main(String args[]){
        SubjectForHealth subjectForHealth = new SubjectForHealth();
        SubjectForSport subjectForSport = new SubjectForSport();
        Observer1 observer1 = new Observer1();
        observer1.registerSubject(subjectForHealth);
        observer1.registerSubject(subjectForSport);
        subjectForHealth.setMessage("按时吃饭，按时睡觉");
        subjectForSport.setMessage("今天打篮球");
    }
}
