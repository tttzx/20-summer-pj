package Servlet.UserServlet;

import DAO.PictureDAO;
import Entity.Picture;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FavorPicServlet",value = "/myfavour")
public class FavorPicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username= (String)session.getAttribute("username");
        List<Picture> pictures = PictureDAO.findFavour(username);
        String result = PictureDAO.parseToJson(pictures);
        request.setAttribute("pictures",result);
        request.getRequestDispatcher("myfavourite.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
