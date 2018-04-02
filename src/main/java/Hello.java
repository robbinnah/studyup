import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * Created on 2018/1/31.
 */
public class Hello {

    public static void main(String args[]){
        System.out.println("hello world");
//        testList();
    }
    private static int mprint(int o){
        ScheduledExecutorService ses = Executors.newScheduledThreadPool(1);
        ses.scheduleWithFixedDelay(() ->{
            System.out.println("exec");
        }, 0, 1, TimeUnit.SECONDS);
        return o;
    }

    static void testList(){
        ArrayList<Integer> arrayList = new ArrayList<>(1);
        arrayList.add(1);
        arrayList.add(1);
        arrayList.add(1);
        arrayList.add(1);
        System.out.println(arrayList.size());
    }
}
