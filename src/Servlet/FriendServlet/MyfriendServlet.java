package Servlet.FriendServlet;

import DAO.FriendDAO;
import DAO.UserDAO;
import Entity.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyfriendServlet",value = "/myFriend")
public class MyfriendServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name= (String)session.getAttribute("username");
        String UID = UserDAO.getID(name);
        request.setAttribute("myFriends", FriendDAO.allFriends(UID));
        request.setAttribute("requestIReceived",FriendDAO.allRequestsIReceived(UID));
        request.setAttribute("requestISent",FriendDAO.allRequestsISent(UID));
        List<User> users1 =FriendDAO.allRequestsISent(UID);
       for (User user:users1){
           System.out.println(user.getUserName());
       }

        String text = request.getParameter("text");
        List<User> users = UserDAO.findLikeUser(text);
        request.setAttribute("results",users);
        request.getRequestDispatcher("myfriend.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
