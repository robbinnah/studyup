package nio;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;

/**
 * Created on 2018/3/1.
 */
public class UDPClient {

    private final int MAX_BUFFER_SIZE = 1024;
    private final int port = 9999;

    public void send(String message) throws IOException {
        ByteBuffer buffer = ByteBuffer.allocate(MAX_BUFFER_SIZE);
        buffer.clear();
        buffer.put(message.getBytes());
        buffer.flip();
        DatagramChannel channel = DatagramChannel.open();
        InetSocketAddress socketAddress = new InetSocketAddress("127.0.0.1", port);
        int n = channel.send(buffer, socketAddress);
        System.out.println(n);
        channel.close();
    }

    public static void main(String args[]) {
        UDPClient udpClient = new UDPClient();
        try {
            udpClient.send("hello, server");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
