package algorithm;

/**
 * Created on 2018/4/2.
 * 我们不妨考虑一个这样的序列：1，-3，5，-2，4
 * a[i]表示这个序列的第 i 个元素，dp[i]表示最后一个元素是a[i]的最大连续和（此乃状态，是不是跟LIS的DP解法有点类似），于是：
 * dp[0] : a[0] ; ( 1 )
 * dp[1] : max(dp[0] + a[1] , a[1]) ; ( -2 )
 * dp[2] : max(dp[1] + a[2] , a[2]) ; ( 5 )
 * dp[3] : max(dp[2] + a[3] , a[3]) ; ( 3 )
 * dp[4] : max(dp[3] + a[4] , a[4]) ; ( 7 )
 * 所以：ans = 7 （dp数组的最大值）
 * 于是，我们可以得到状态转移方程：dp[i+1] = max(dp[i]+a[i+1] , a[i+1])
 * 写成代码的话，我们可以忽略掉dp数组，直接用一个变量sum来记录 i 之前的最大增量（因为如果这个增量为负，则变为0）
 */
public class MaxSubArray {

    private final byte[] lock = new byte[0];

    public void run(int arr) {

    }
}
