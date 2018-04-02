package nio;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.util.Iterator;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Created on 2018/3/1.
 */
public class UDPServer {

    private final int MAX_BUFFER_SIZE = 1024;
    private final int port = 9999;
    private Selector selector;
    private DatagramChannel datagramChannel;
    private ScheduledExecutorService ses = Executors.newScheduledThreadPool(1);

    public void init() throws IOException {
        selector = Selector.open();
        datagramChannel = DatagramChannel.open();
        datagramChannel.configureBlocking(false);
        datagramChannel.bind(new InetSocketAddress(port));
        datagramChannel.register(selector, SelectionKey.OP_READ);
        ses.scheduleWithFixedDelay(() -> {
            System.out.println("等待客户端请求...");
            try {
                while (selector.select() > 0) {
                    Iterator<SelectionKey> keyIterator = selector.selectedKeys().iterator();
                    while (keyIterator.hasNext()) {
                        SelectionKey key = keyIterator.next();
                        try {
                            keyIterator.remove();
                            if (key.isReadable()) {
                                receive(key);
                            }
                        } catch (Exception e) {
                            if (key != null) {
                                key.cancel();
                                key.channel().close();
                            }
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }, 0, 1, TimeUnit.SECONDS);
    }

    /**
     * 接收数据
     */
    public void receive(SelectionKey key) throws IOException {
        String content = "";
        ByteBuffer buffer = ByteBuffer.allocate(MAX_BUFFER_SIZE);
        buffer.clear();
        DatagramChannel channel = (DatagramChannel) key.channel();
        channel.receive(buffer);
        buffer.flip();
        while (buffer.hasRemaining()) {
            byte[] bytes = new byte[buffer.limit()];
            buffer.get(bytes);
            content += new String(bytes);
        }
        buffer.clear();
        System.out.println("receive content : " + content);
    }

    public static void main(String args[]) {
        UDPServer udpServer = new UDPServer();
        try {
            udpServer.init();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
