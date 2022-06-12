package com.zllh;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.util.List;
import java.util.Properties;

public class CopyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        FileOutputStream out = null;
        //通过类加载器获取相应的资源
        InputStream is =CopyServlet.class.getClassLoader().getResourceAsStream("config.properties");
        Properties properties = new Properties();
        properties.load(is);
        String ip = properties.getProperty("ip");
        int port  = Integer.parseInt(properties.getProperty("port"));
        Socket socket =new Socket(ip,port);

        try {
            out= (FileOutputStream) socket.getOutputStream();
            String text = req.getParameter("copy");
            System.out.println("收到的客户端内容是"+text);
            out.write(text.getBytes());
            System.out.println("传输成功");
            req.getRequestDispatcher("/success1.jsp").forward(req,resp);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        finally{

               if (out != null){
                   out.close();
               }

               if(socket!=null){
                   socket.close();
               }
        }
    }
}
