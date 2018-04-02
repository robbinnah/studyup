import java.util.Arrays;
import java.util.stream.Collectors;

/**
 * Created on 2018/3/28.
 */
public class QuickSort {

    static void quick(int arr[]){
        qsort(arr, 0 , arr.length-1);
    }

    static void qsort(int arr[], int low, int high){
        if(low < high){
            int pivot = partition(arr, low, high);
            qsort(arr, low, pivot-1);
            qsort(arr, pivot+1, high);
        }
    }

    static int partition(int[] arr, int low, int high) {
        int pivot = arr[low];
        while (low < high) {
            while (low < high && pivot <= arr[high]) --high;
            arr[low] = arr[high];
            while (low < high && pivot >= arr[low]) ++low;
            arr[high] = arr[low];
        }
        arr[low] = pivot;
        return low;
    }

    public static void main(String args[]){
        int[] arr = {4,7,2,1,3,8};
        quick(arr);
        Arrays.stream(arr).forEach(i->System.out.print(i+","));
    }
}
