package Servlet.FriendServlet;

import DAO.FriendDAO;
import DAO.UserDAO;
import Entity.FriendRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AgreeRequestServlet", value = "/agree")
public class AgreeRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name= (String)session.getAttribute("username");
        String UID = UserDAO.getID(name);
        String id=(String)request.getParameter("id");
        FriendRequest request1 = FriendDAO.findRequest(id,UID);
        FriendDAO.agree(request1.getID());
        response.sendRedirect(request.getHeader("Referer"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
