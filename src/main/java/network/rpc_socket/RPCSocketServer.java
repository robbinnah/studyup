package network.rpc_socket;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Created by mortal on 2018/3/8.
 */
public class RPCSocketServer {

    public static void publish(final Object service, int port) throws IOException {
        if (null == service) throw new IllegalArgumentException("未发现服务");
        if (port <= 0 || port > 65535) throw new IllegalArgumentException("端口号不合法");
        ServerSocket server = new ServerSocket(9000);
        while (true) {
            try {
                final Socket socket = server.accept();
                new Thread(() -> {

                    ObjectInputStream inputStream = null;
                    ObjectOutputStream outputStream = null;
                    try {
                        inputStream = new ObjectInputStream(socket.getInputStream());
                        String methodName = inputStream.readUTF();
                        Class<?>[] paramTypes = (Class<?>[]) inputStream.readObject();
                        Object[] args = (Object[]) inputStream.readObject();
                        outputStream = new ObjectOutputStream(socket.getOutputStream());
                        Method method = service.getClass().getMethod(methodName, paramTypes);
                        Object result = method.invoke(service, args);
                        outputStream.writeObject(result);
                    } catch (IOException e) {
                        e.printStackTrace();
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            assert outputStream != null;
                            assert inputStream != null;
                            outputStream.close();
                            inputStream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                });
                socket.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String args[]) {

    }
}
