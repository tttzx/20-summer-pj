package Servlet.PicServlet;

import DAO.PictureDAO;
import DAO.UserDAO;
import Entity.Picture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "UpLoadServlet", value = "/upload")
public class UpLoadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title= request.getParameter("title");
        String path=request.getParameter("file");
        String content =request.getParameter("content");
        String country =request.getParameter("country");
        String region =request.getParameter("region");
        String description =request.getParameter("description");
        HttpSession session = request.getSession();
        String username= (String)session.getAttribute("username");


//        String dir = "/a/b/c/";
//        String path = request.getSession().getServletContext().getRealPath(dir)+"\\"+file.getOriginalFilename();//path 为服务器在硬bai盘的绝对路径 如duH:\tomcat\webapps\youproject\a\b\c\文件名.txt
//        File newFile=new File(path);
        //file.transferTo(newFile); 
        Picture picture=new Picture(null,title,description,region,country,
                UserDAO.getID(username),path,content,0);
        //PictureDAO.save(picture);
        request.getRequestDispatcher("/myphoto").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
